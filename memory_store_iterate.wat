(module
  (memory (export "memory") 0)

  ;; Grow to 2048 pages, store 0xFFFFFFFFFFFFFFFF at every 8-byte aligned address,
  ;; then verify by loading 64-bit words.
  (func (export "memory_store_iterate") (result i32)
    (local $i i32)
    (local $size i32)

    (drop (memory.grow (i32.const 2048)))

    (local.set $size
      (i32.mul (i32.const 2048) (i32.const 65536))
    )

    ;; Write loop: for i = 0; i < size; i += 8: store 0xFFFFFFFFFFFFFFFF at i
    (local.set $i (i32.const 0))
    (block $exitW
      (loop $write
        (br_if $exitW (i32.ge_u (local.get $i) (local.get $size)))

        (i64.store
          (local.get $i)
          (i64.const -1)   ;; 0xFFFFFFFFFFFFFFFF
        )

        (local.set $i (i32.add (local.get $i) (i32.const 8)))
        (br $write)
      )
    )

    ;; Check loop: for i = 0; i < size; i += 8: load and compare with 0xFFFFFFFFFFFFFFFF
    (local.set $i (i32.const 0))
    (block $exitR
      (loop $read
        (br_if $exitR (i32.ge_u (local.get $i) (local.get $size)))

        (if (i64.ne (i64.load (local.get $i)) (i64.const -1))
          (then (return (i32.add (i32.const 1) (local.get $i))))
        )

        (local.set $i (i32.add (local.get $i) (i32.const 8)))
        (br $read)
      )
    )

    (i32.const 0)
  )
)

