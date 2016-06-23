
;; This file contains patterns for OptimizeInstructions. Basically, we use a DSL for the patterns,
;; and the DSL is just wasm itself, plus some functions with special meanings
;;
;; This file is converted into OptimizeInstructions.wast.processed by
;;    scripts/process_optimize_instructions.py
;; which makes it importable by C++. Then we just #include it there, avoiding the need to ship
;; a data file on the side.

(module
  (import $any "dsl" "any" (param i32))
  (func $patterns
    ;; each block here is a pattern pair of input => output
    (block
      ;; flip if-else arms to get rid of an eqz
      (if
        (i32.eqz
          (call $any (i32.const 0))
        )
        (call $any (i32.const 1))
        (call $any (i32.const 2))
      )
      (if
        (call $any (i32.const 0))
        (call $any (i32.const 2))
        (call $any (i32.const 1))
      )
    )
    ;; De Morgan's Laws
    (block
      (i32.eqz (i32.eq (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.ne (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.ne (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.eq (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.lt_s (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.ge_s (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.lt_u (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.ge_u (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.le_s (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.gt_s (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.le_u (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.gt_u (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.gt_s (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.le_s (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.gt_u (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.le_u (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.ge_s (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.lt_s (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i32.ge_u (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i32.lt_u (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.eq (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.ne (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.ne (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.eq (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.lt_s (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.ge_s (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.lt_u (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.ge_u (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.le_s (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.gt_s (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.le_u (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.gt_u (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.gt_s (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.le_s (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.gt_u (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.le_u (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.ge_s (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.lt_s (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (i64.ge_u (call $any (i32.const 0)) (call $any (i32.const 1))))
      (i64.lt_u (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (f32.eq (call $any (i32.const 0)) (call $any (i32.const 1))))
      (f32.ne (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (f32.ne (call $any (i32.const 0)) (call $any (i32.const 1))))
      (f32.eq (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (f32.lt (call $any (i32.const 0)) (call $any (i32.const 1))))
      (f32.ge (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (f32.le (call $any (i32.const 0)) (call $any (i32.const 1))))
      (f32.gt (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (f64.eq (call $any (i32.const 0)) (call $any (i32.const 1))))
      (f64.ne (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (f64.ne (call $any (i32.const 0)) (call $any (i32.const 1))))
      (f64.eq (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (f64.lt (call $any (i32.const 0)) (call $any (i32.const 1))))
      (f64.ge (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
    (block
      (i32.eqz (f64.le (call $any (i32.const 0)) (call $any (i32.const 1))))
      (f64.gt (call $any (i32.const 0)) (call $any (i32.const 1)))
    )
  )
)

