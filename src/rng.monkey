Strict

Import logger

Class RNG

    Function Make: RNG(x: Int)
        If x < 1
            x = 147483646 * (-x / $7FFFFFFE) + x + 2147483646
        End If

        If x >= $7FFFFFFF
            x += -2147483646 * ((x - 1) / $7FFFFFFE)
        End If

        Local rng: RNG = new RNG()
        rng.SetSeed(x)

        Return rng
    End Function

    Function _EditorFix: Void() End

    Field seed: Int = 1

    Method Rand: Int()
        Local seed: Int = 48271 * (Self.seed Mod 44488) - 3399 * (Self.seed / 44488)
        If seed <= 0
            seed += $7FFFFFFF
        End If
        Self.seed = seed

        Return seed
    End Method

    Method RndIntRange: Int(lo: Int, hi: Int)
        Return lo + Rand() Mod (hi - lo + 1)
    End Method

    Method SetSeed: Void(seed_: Int)
        Debug.Assert(1 <= Self.seed And Self.seed < 2147483647, "1<=m_seed && m_seed<2147483647")

        Self.seed = seed_
    End Method

    Method Split: RNG()
        Local rnd: Int = Rand()
        If rnd >= $40000000
            rnd -= 2147483646
        End If
        rnd += $3FFFFFFF

        Local rng: RNG = new RNG()
        rng.SetSeed(rnd)

        Return rng
    End Method

End Class
