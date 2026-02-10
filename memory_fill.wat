(module
  (memory (export "memory") 0)


  (func (export "memory_fill") (result i32)
    (local $i i32)
    (local $size i32)

    (drop (memory.grow (i32.const 2048)))
    (local.set $size (i32.mul (i32.const 2048) (i32.const 65536)))

    ;; memory.fill(dst, value, len)
    (memory.fill
      (i32.const 0)         ;; dst
      (i32.const 255)       ;; value = 0xFF
      (local.get $size)     ;; len
    )

    (local.set $i (i32.const 0))
    (block $exit
      (loop $check
        (br_if $exit (i32.ge_u (local.get $i) (local.get $size)))
        (if (i32.ne (i32.load8_u (local.get $i)) (i32.const 255))
          (then (return (i32.add (i32.const 1) (local.get $i))))
        )
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $check)
      )
    )

    (i32.const 0)
  )
)

