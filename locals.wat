(module
  (func (export "run") (param $n i32) (result i32)
    (local $i i32)
    (local $acc i32)

    ;; 100 locals: $l0 .. $l99
    (local $l0 i32)  (local $l1 i32)  (local $l2 i32)  (local $l3 i32)  (local $l4 i32)
    (local $l5 i32)  (local $l6 i32)  (local $l7 i32)  (local $l8 i32)  (local $l9 i32)
    (local $l10 i32) (local $l11 i32) (local $l12 i32) (local $l13 i32) (local $l14 i32)
    (local $l15 i32) (local $l16 i32) (local $l17 i32) (local $l18 i32) (local $l19 i32)
    (local $l20 i32) (local $l21 i32) (local $l22 i32) (local $l23 i32) (local $l24 i32)
    (local $l25 i32) (local $l26 i32) (local $l27 i32) (local $l28 i32) (local $l29 i32)
    (local $l30 i32) (local $l31 i32) (local $l32 i32) (local $l33 i32) (local $l34 i32)
    (local $l35 i32) (local $l36 i32) (local $l37 i32) (local $l38 i32) (local $l39 i32)
    (local $l40 i32) (local $l41 i32) (local $l42 i32) (local $l43 i32) (local $l44 i32)
    (local $l45 i32) (local $l46 i32) (local $l47 i32) (local $l48 i32) (local $l49 i32)
    (local $l50 i32) (local $l51 i32) (local $l52 i32) (local $l53 i32) (local $l54 i32)
    (local $l55 i32) (local $l56 i32) (local $l57 i32) (local $l58 i32) (local $l59 i32)
    (local $l60 i32) (local $l61 i32) (local $l62 i32) (local $l63 i32) (local $l64 i32)
    (local $l65 i32) (local $l66 i32) (local $l67 i32) (local $l68 i32) (local $l69 i32)
    (local $l70 i32) (local $l71 i32) (local $l72 i32) (local $l73 i32) (local $l74 i32)
    (local $l75 i32) (local $l76 i32) (local $l77 i32) (local $l78 i32) (local $l79 i32)
    (local $l80 i32) (local $l81 i32) (local $l82 i32) (local $l83 i32) (local $l84 i32)
    (local $l85 i32) (local $l86 i32) (local $l87 i32) (local $l88 i32) (local $l89 i32)
    (local $l90 i32) (local $l91 i32) (local $l92 i32) (local $l93 i32) (local $l94 i32)
    (local $l95 i32) (local $l96 i32) (local $l97 i32) (local $l98 i32) (local $l99 i32)

    ;; init loop counter + acc
    (local.set $i   (i32.const 0))
    (local.set $acc (i32.const 0))

    ;; initialize locals with 1..100 (cheap, one-time)
    (local.set $l0  (i32.const 1))   (local.set $l1  (i32.const 2))   (local.set $l2  (i32.const 3))   (local.set $l3  (i32.const 4))   (local.set $l4  (i32.const 5))
    (local.set $l5  (i32.const 6))   (local.set $l6  (i32.const 7))   (local.set $l7  (i32.const 8))   (local.set $l8  (i32.const 9))   (local.set $l9  (i32.const 10))
    (local.set $l10 (i32.const 11))  (local.set $l11 (i32.const 12))  (local.set $l12 (i32.const 13))  (local.set $l13 (i32.const 14))  (local.set $l14 (i32.const 15))
    (local.set $l15 (i32.const 16))  (local.set $l16 (i32.const 17))  (local.set $l17 (i32.const 18))  (local.set $l18 (i32.const 19))  (local.set $l19 (i32.const 20))
    (local.set $l20 (i32.const 21))  (local.set $l21 (i32.const 22))  (local.set $l22 (i32.const 23))  (local.set $l23 (i32.const 24))  (local.set $l24 (i32.const 25))
    (local.set $l25 (i32.const 26))  (local.set $l26 (i32.const 27))  (local.set $l27 (i32.const 28))  (local.set $l28 (i32.const 29))  (local.set $l29 (i32.const 30))
    (local.set $l30 (i32.const 31))  (local.set $l31 (i32.const 32))  (local.set $l32 (i32.const 33))  (local.set $l33 (i32.const 34))  (local.set $l34 (i32.const 35))
    (local.set $l35 (i32.const 36))  (local.set $l36 (i32.const 37))  (local.set $l37 (i32.const 38))  (local.set $l38 (i32.const 39))  (local.set $l39 (i32.const 40))
    (local.set $l40 (i32.const 41))  (local.set $l41 (i32.const 42))  (local.set $l42 (i32.const 43))  (local.set $l43 (i32.const 44))  (local.set $l44 (i32.const 45))
    (local.set $l45 (i32.const 46))  (local.set $l46 (i32.const 47))  (local.set $l47 (i32.const 48))  (local.set $l48 (i32.const 49))  (local.set $l49 (i32.const 50))
    (local.set $l50 (i32.const 51))  (local.set $l51 (i32.const 52))  (local.set $l52 (i32.const 53))  (local.set $l53 (i32.const 54))  (local.set $l54 (i32.const 55))
    (local.set $l55 (i32.const 56))  (local.set $l56 (i32.const 57))  (local.set $l57 (i32.const 58))  (local.set $l58 (i32.const 59))  (local.set $l59 (i32.const 60))
    (local.set $l60 (i32.const 61))  (local.set $l61 (i32.const 62))  (local.set $l62 (i32.const 63))  (local.set $l63 (i32.const 64))  (local.set $l64 (i32.const 65))
    (local.set $l65 (i32.const 66))  (local.set $l66 (i32.const 67))  (local.set $l67 (i32.const 68))  (local.set $l68 (i32.const 69))  (local.set $l69 (i32.const 70))
    (local.set $l70 (i32.const 71))  (local.set $l71 (i32.const 72))  (local.set $l72 (i32.const 73))  (local.set $l73 (i32.const 74))  (local.set $l74 (i32.const 75))
    (local.set $l75 (i32.const 76))  (local.set $l76 (i32.const 77))  (local.set $l77 (i32.const 78))  (local.set $l78 (i32.const 79))  (local.set $l79 (i32.const 80))
    (local.set $l80 (i32.const 81))  (local.set $l81 (i32.const 82))  (local.set $l82 (i32.const 83))  (local.set $l83 (i32.const 84))  (local.set $l84 (i32.const 85))
    (local.set $l85 (i32.const 86))  (local.set $l86 (i32.const 87))  (local.set $l87 (i32.const 88))  (local.set $l88 (i32.const 89))  (local.set $l89 (i32.const 90))
    (local.set $l90 (i32.const 91))  (local.set $l91 (i32.const 92))  (local.set $l92 (i32.const 93))  (local.set $l93 (i32.const 94))  (local.set $l94 (i32.const 95))
    (local.set $l95 (i32.const 96))  (local.set $l96 (i32.const 97))  (local.set $l97 (i32.const 98))  (local.set $l98 (i32.const 99))  (local.set $l99 (i32.const 100))

    (block $done
      (loop $loop
        ;; stop when i >= n
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))

        ;; acc += l0 + l25 + l50 + l75 + l99  (spread-out gets)
        (local.set $acc
          (i32.add (local.get $acc)
            (i32.add
              (i32.add (local.get $l0) (local.get $l25))
              (i32.add (local.get $l50) (i32.add (local.get $l75) (local.get $l99))))))

        ;; rotate a window of 25 locals: l0..l24
        (local.set $l0  (i32.add (local.get $l0)  (local.get $l1)))
        (local.set $l1  (i32.add (local.get $l1)  (local.get $l2)))
        (local.set $l2  (i32.add (local.get $l2)  (local.get $l3)))
        (local.set $l3  (i32.add (local.get $l3)  (local.get $l4)))
        (local.set $l4  (i32.add (local.get $l4)  (local.get $l5)))
        (local.set $l5  (i32.add (local.get $l5)  (local.get $l6)))
        (local.set $l6  (i32.add (local.get $l6)  (local.get $l7)))
        (local.set $l7  (i32.add (local.get $l7)  (local.get $l8)))
        (local.set $l8  (i32.add (local.get $l8)  (local.get $l9)))
        (local.set $l9  (i32.add (local.get $l9)  (local.get $l10)))
        (local.set $l10 (i32.add (local.get $l10) (local.get $l11)))
        (local.set $l11 (i32.add (local.get $l11) (local.get $l12)))
        (local.set $l12 (i32.add (local.get $l12) (local.get $l13)))
        (local.set $l13 (i32.add (local.get $l13) (local.get $l14)))
        (local.set $l14 (i32.add (local.get $l14) (local.get $l15)))
        (local.set $l15 (i32.add (local.get $l15) (local.get $l16)))
        (local.set $l16 (i32.add (local.get $l16) (local.get $l17)))
        (local.set $l17 (i32.add (local.get $l17) (local.get $l18)))
        (local.set $l18 (i32.add (local.get $l18) (local.get $l19)))
        (local.set $l19 (i32.add (local.get $l19) (local.get $l20)))
        (local.set $l20 (i32.add (local.get $l20) (local.get $l21)))
        (local.set $l21 (i32.add (local.get $l21) (local.get $l22)))
        (local.set $l22 (i32.add (local.get $l22) (local.get $l23)))
        (local.set $l23 (i32.add (local.get $l23) (local.get $l24)))
        (local.set $l24 (i32.add (local.get $l24) (i32.const 1)))

        ;; also touch far locals to prevent over-specialization
        (local.set $l50 (i32.add (local.get $l50) (local.get $l75)))
        (local.set $l75 (i32.add (local.get $l75) (local.get $l99)))
        (local.set $l99 (i32.add (local.get $l99) (i32.const 1)))

        ;; i++
        (local.set $i (i32.add (local.get $i) (i32.const 1)))

        (br $loop)
      )
    )

    (local.get $acc)
  )
)

