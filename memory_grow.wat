(module
  (memory (export "memory") 0)

  (func (export "memory_grow") (result i32)
    (local $k i32)     ;; how many grows performed
    (local $i i32)     ;; byte index for checking
    (local $size i32)  ;; total bytes after growth

    ;; Grow memory by 1 page, 2048 times
    (local.set $k (i32.const 0))
    (block $exitGrow
      (loop $grow
        (br_if $exitGrow (i32.ge_u (local.get $k) (i32.const 2048)))

        ;; memory.grow returns previous page count, or -1 on failure
        (if (i32.eq (memory.grow (i32.const 1)) (i32.const -1))
          (then
            ;; return a non-zero error code if growth fails
            (return (i32.const 1))
          )
        )

        (local.set $k (i32.add (local.get $k) (i32.const 1)))
        (br $grow)
      )
    )

    ;; size in bytes = 2048 * 65536
    (local.set $size
      (i32.mul (i32.const 2048) (i32.const 65536))
    )

    ;; Check all bytes are zero
    (local.set $i (i32.const 0))
    (block $exitCheck
      (loop $check
        (br_if $exitCheck (i32.ge_u (local.get $i) (local.get $size)))

        (if (i32.ne (i32.load8_u (local.get $i)) (i32.const 0))
          (then (return (i32.add (i32.const 1) (local.get $i))))
        )

        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $check)
      )
    )

    (i32.const 0)
  )
)

