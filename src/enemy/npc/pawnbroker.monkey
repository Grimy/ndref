'Strict

Import enemy.npc
Import entity
Import item
Import logger

Class Pawnbroker Extends NPC

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int, l: Int, captv: Bool)
        Super.New()

        Self.NPCInit(xVal, yVal, l, "pawnbroker", captv, False)
    End Method

    Method Die: Void()
        If Not Self.dead
            If Not Self.falling
                New Item(Self.x, Self.y, ItemType.Coupon, False, -1, False)
            End If

            Super.Die()
        End If
    End Method

    Method Hit: Bool(damageSource: String, damage: Int, dir: Int, hitter: Entity, hitAtLastTile: Bool, hitType: Int)
        Debug.TraceNotImplemented("Pawnbroker.Hit(String, Int, Int, Entity, Bool, Int)")
    End Method

End Class
