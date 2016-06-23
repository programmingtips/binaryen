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

static const char* patternInput =
#include "OptimizeInstructions.wast.processed"
;

struct PatternDatabase {
  Module wasm;

  PatternDatabase() {
    SExpressionParser parser(const_cast<char*>(patternInput));
    Element& root = *parser.root;
    if (options.debug) std::cerr << "w-parsing..." << std::endl;
    SExpressionWasmBuilder builder(wasm, *root[0]);
  }
};

static PatternDatabase patterns;

struct OptimizeInstructions : public WalkerPass<PostWalker<OptimizeInstructions, Visitor<OptimizeInstructions>>> {
  bool isFunctionParallel() override { return true; }

  Pass* create() override { return new OptimizeInstructions; }

};

Pass *createOptimizeInstructionsPass() {
  return new OptimizeInstructions();
}

} // namespace wasm
