
;; This file contains patterns for OptimizeInstructions. Basically, we use a DSL for the patterns,
;; and the DSL is just wasm itself, plus some functions with special meanings
;;
;; This file is converted into OptimizeInstructions.wast.processed by
;;    scripts/process_optimize_instructions.py
;; which makes it importable by C++. Then we just #include it there, avoiding the need to ship
;; a data file on the side.

(module
  ;; "any" represents an arbitrary expression. The input is an id, so the same expression
  ;; can appear more than once. The type (i32 in i32.any, etc.) is the return type, as this
  ;; needs to have the right type for where it is placed.
  (import $none.any "dsl" "none.any" (param i32))
  (import $i32.any "dsl" "i32.any" (param i32) (result i32))
  (import $i64.any "dsl" "i64.any" (param i32) (result i64))
  (import $f32.any "dsl" "f32.any" (param i32) (result f32))
  (import $f64.any "dsl" "f64.any" (param i32) (result f64))
  (import $any.any "dsl" "any.any" (param i32)) ;; ignorable return type

  ;; main function. each block here is a pattern pair of input => output
  (func $patterns
    (block
      ;; flip if-else arms to get rid of an eqz
      (if
        (i32.eqz
          (call $i32.any (i32.const 0))
        )
        (call $any.any (i32.const 1))
        (call $any.any (i32.const 2))
      )
      (if
        (call $i32.any (i32.const 0))
        (call $any.any (i32.const 2))
        (call $any.any (i32.const 1))
      )
    )
    ;; De Morgans Laws
    (block
      (i32.eqz (i32.eq (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.ne (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.ne (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.eq (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.lt_s (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.ge_s (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.lt_u (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.ge_u (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.le_s (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.gt_s (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.le_u (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.gt_u (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.gt_s (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.le_s (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.gt_u (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.le_u (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.ge_s (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.lt_s (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.ge_u (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1))))
      (i32.lt_u (call $i32.any (i32.const 0)) (call $i32.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.eq (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.ne (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.ne (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.eq (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.lt_s (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.ge_s (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.lt_u (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.ge_u (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.le_s (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.gt_s (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.le_u (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.gt_u (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.gt_s (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.le_s (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.gt_u (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.le_u (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.ge_s (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.lt_s (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.ge_u (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1))))
      (i64.lt_u (call $i64.any (i32.const 0)) (call $i64.any (i32.const 1)))
    )
    (block
      (i32.eqz (f32.eq (call $f32.any (i32.const 0)) (call $f32.any (i32.const 1))))
      (f32.ne (call $f32.any (i32.const 0)) (call $f32.any (i32.const 1)))
    )
    (block
      (i32.eqz (f32.ne (call $f32.any (i32.const 0)) (call $f32.any (i32.const 1))))
      (f32.eq (call $f32.any (i32.const 0)) (call $f32.any (i32.const 1)))
    )
    (block
      (i32.eqz (f32.lt (call $f32.any (i32.const 0)) (call $f32.any (i32.const 1))))
      (f32.ge (call $f32.any (i32.const 0)) (call $f32.any (i32.const 1)))
    )
    (block
      (i32.eqz (f32.le (call $f32.any (i32.const 0)) (call $f32.any (i32.const 1))))
      (f32.gt (call $f32.any (i32.const 0)) (call $f32.any (i32.const 1)))
    )
    (block
      (i32.eqz (f64.eq (call $f64.any (i32.const 0)) (call $f64.any (i32.const 1))))
      (f64.ne (call $f64.any (i32.const 0)) (call $f64.any (i32.const 1)))
    )
    (block
      (i32.eqz (f64.ne (call $f64.any (i32.const 0)) (call $f64.any (i32.const 1))))
      (f64.eq (call $f64.any (i32.const 0)) (call $f64.any (i32.const 1)))
    )
    (block
      (i32.eqz (f64.lt (call $f64.any (i32.const 0)) (call $f64.any (i32.const 1))))
      (f64.ge (call $f64.any (i32.const 0)) (call $f64.any (i32.const 1)))
    )
    (block
      (i32.eqz (f64.le (call $f64.any (i32.const 0)) (call $f64.any (i32.const 1))))
      (f64.gt (call $f64.any (i32.const 0)) (call $f64.any (i32.const 1)))
    )
  )
)

