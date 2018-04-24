'Strict

Import enemy
Import logger

Class Gorgon Extends Enemy

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int, l: Int)
        Debug.TraceNotImplemented("Gorgon.New(Int, Int, Int)")
    End Method

    Field statueFlashFrames: Int

    Method AfterHitPlayer: Void(p: Object)
        Debug.TraceNotImplemented("Gorgon.AfterHitPlayer(Object)")
    End Method

    Method Die: Void()
        Debug.TraceNotImplemented("Gorgon.Die()")
    End Method

End Class