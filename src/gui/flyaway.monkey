'Strict

Import monkey.list
Import logger
Import sprite
Import textsprite

Class Flyaway

    Global activeFlyaways: List<Flyaway> = New List<Flyaway>()
    Global temporarilyDisableNewFlyaways: Int

    Function RenderAll: Void()
        Debug.TraceNotImplemented("Flyaway.RenderAll()")
    End Function

    Function StopRenderingOfAllCurrentFlyaways: Void()
        Debug.TraceNotImplemented("Flyaway.StopRenderingOfAllCurrentFlyaways()")
    End Function

    Function UpdateAll: Void()
        If Flyaway.temporarilyDisableNewFlyaways > 0
            Flyaway.temporarilyDisableNewFlyaways -= 1
        End If

        For Local flyaway := EachIn Flyaway.activeFlyaways
            flyaway.Update()
        End For
    End Function

    Function _EditorFix: Void() End

    Method New(filename: String, xVal: Int, yVal: Int, tempXOff: Int, tempYOff: Int, inWrld: Bool, xSpd: Float, ySpd: Float, textString: Bool, dur: Int)
        Debug.TraceNotImplemented("Flyaway.New(String, Int, Int, Int, Int, Bool, Float, Float, Bool, Int)")
    End Method

    Field noRender: Bool
    Field x: Int
    Field y: Int
    Field xSpeed: Float
    Field ySpeed: Float
    Field xOff: Float
    Field yOff: Float
    Field image: Sprite
    Field image2: TextSprite
    Field inWorld: Bool
    Field flyawayDur: Int
    Field frameCounter: Int
    Field alphaMultiplier: Float

    Method CenterX: Void()
        Debug.TraceNotImplemented("Flyaway.CenterX()")
    End Method

    Method Render: Void()
        Debug.TraceNotImplemented("Flyaway.Render()")
    End Method

    Method Update: Void()
        Debug.TraceNotImplemented("Flyaway.Update()")
    End Method

End Class
