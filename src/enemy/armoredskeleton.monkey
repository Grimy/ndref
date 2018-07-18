'Strict

Import monkey.math
Import audio2
Import enemy
Import entity
Import logger
Import point
Import shrine
Import util

Class ArmoredSkeleton Extends Enemy

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int, l: Int)
        Super.New()

        If Shrine.warShrineActive
            l = math.Min(3, l)
        End If

        Self.Init(xVal, yVal, l, "armoredskeleton")

        Self.animOverride = False

        Self.overrideHitSound = "skeletonHit"
        Self.overrideDeathSound = "skeletonDeath"
        Self.overrideAttackSound = "skeletonAttack"

        If Audio.debugEnablePlaceholders And
           l = 4
            Self.overrideDeathSound = "iceBreak"
        End If

        If Self.isFormationDancer
            Self.beatsPerMove = 4
            Self.currentMoveDelay = 4
        End If
    End Method

    Field hasHead: Bool = True
    Field cachedMoveDir: Point = New Point(0, 0)
    Field directionHitFrom: Int = -1
    Field gotBounced: Bool
    Field shieldDestroyed: Bool
    Field shieldDir: Int = 1
    Field justBounced: Bool
    Field willHaveHead: Bool = True

    Method CanBeLord: Bool()
        Debug.TraceNotImplemented("ArmoredSkeleton.CanBeLord()")
    End Method

    Method DestroyShield: Void(dir: Int)
        Debug.TraceNotImplemented("ArmoredSkeleton.DestroyShield(Int)")
    End Method

    Method GetMovementDirection: Point()
        Debug.TraceNotImplemented("ArmoredSkeleton.GetMovementDirection()")
    End Method

    Method Hit: Bool(damageSource: String, damage: Int, dir: Int, hitter: Entity, hitAtLastTile: Bool, hitType: Int)
        Debug.TraceNotImplemented("ArmoredSkeleton.Hit(String, Int, Int, Entity, Bool, Int)")
    End Method

    Method Knockback: Void(dir: Int)
        Debug.TraceNotImplemented("ArmoredSkeleton.Knockback(Int)")
    End Method

    Method MoveSucceed: Void(hitPlayer: Bool, moveDelayed: Bool)
        Debug.TraceNotImplemented("ArmoredSkeleton.MoveSucceed(Bool, Bool)")
    End Method

    Method Update: Void()
        If Not Self.shieldDestroyed
            Select Self.shieldDir
                Case Direction.Left
                    Self.image.FlipX(False, True)
                Case Direction.Right
                    Self.image.FlipX(True, True)
            End Select
        End If

        If Self.directionHitFrom <> Direction.None And
           Self.gotBounced And
           Not Self.hasHead
            Self.gotBounced = False

            If Self.x < Self.lastX
                Self.directionHitFrom = Direction.Left
            Else If Self.x > Self.lastX
                Self.directionHitFrom = Direction.Right
            Else If Self.y < Self.lastY
                Self.directionHitFrom = Direction.Up
            Else If Self.y > Self.lastY
                Self.directionHitFrom = Direction.Down
            End If
        End If

        If Not Self.shieldDestroyed
            Select Self.shieldDir
                Case Direction.Left,
                     Direction.Right
                    Self.animOverrideState = 2
                Case Direction.Up
                    Self.animOverrideState = 0
                Default
                    Self.animOverrideState = 4
            End Select

            Self.animOverride = Audio.IsBeatAnimTime(False, False)
        End If

        Super.Update()
    End Method

End Class
