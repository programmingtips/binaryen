/*
 * Copyright 2016 WebAssembly Community Group participants
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
// Optimize combinations of instructions
//

#include <algorithm>

#include <wasm.h>
#include <pass.h>
#include <wasm-s-parser.h>

namespace wasm {

// Information about a possible match
struct Match {
  // Apply the match, generate an output expression from the matched input, performing substitutions as necessary
  Expression* apply(Expression* input) {
  }
};

// A pattern
struct Pattern {
  Expression* input;
  Expression* output;

  Pattern(Expression* input, Expression* output) : input(input), output(output) {}

  // Try to match seen to this pattern, generating a match object if so
  bool match(Expression* seen, Match& match) {
  }
};

// Database of patterns
struct PatternDatabase {
  Module wasm;

  char* input;

  std::map<Expression::Id, std::vector<Pattern>> patternMap; // root expression id => list of all patterns for it TODO optimize more

  PatternDatabase() {
    // TODO: do this on first use, with a lock, to avoid startup pause
    // generate module
    input = strdup(
      #include "OptimizeInstructions.wast.processed"
    );
    SExpressionParser parser(input);
    Element& root = *parser.root;
    SExpressionWasmBuilder builder(wasm, *root[0]);
    // parse module form
    auto* func = wasm.getFunction("patterns");
    auto* body = func->body->cast<Block>();
    for (auto* item : body->list) {
      auto* pair = item->cast<Block>();
      patternMap[pair->list[0]->_id].emplace_back(pair->list[0], pair->list[1]);
    }
  }

  ~PatternDatabase() {
    free(input);
  };
};

static PatternDatabase database;

struct OptimizeInstructions : public WalkerPass<PostWalker<OptimizeInstructions, UnifiedExpressionVisitor<OptimizeInstructions>>> {
  bool isFunctionParallel() override { return true; }

  Pass* create() override { return new OptimizeInstructions; }

  void visitExpression(Expression* curr) {
    // we may be able to apply multiple patterns, one may open opportunities that look deeper NB: patterns must not have cycles
    while (1) {
      auto iter = database.patternMap.find(curr->_id);
      if (iter == database.patternMap.end()) return;
      auto& patterns = *iter;
      bool more = false;
      for (auto& pattern : patterns) {
        Match match;
        if (pattern.match(curr, match)) {
          curr = match.apply(curr);
          replaceCurrent(curr);
          more = true;
          break; // exit pattern for loop, return to main while loop
        }
      }
      if (!more) break;
    }
  }
};

Pass *createOptimizeInstructionsPass() {
  return new OptimizeInstructions();
}

} // namespace wasm
