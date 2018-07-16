'Strict

Import mojo.graphics
Import level
Import trap
Import audio2
Import entity
Import logger
Import util

Class BounceTrap Extends Trap

    Function _EditorFix: Void() End

    Method New(xVal: Int, yVal: Int, d: Int)
        Super.New(xVal, yVal, TrapType.BounceTrap)
        
        Self.xOff = 12.0
        Self.yOff = 18.0

        Select d
            Case BounceTrapDirection.None
                Const limit := 500

                For Local i := limit - 1 Until 0 Step -1
                    Self.bounceDir = Util.RndIntRangeFromZero(3, True)
                    
                    Select Self.bounceDir
                        Case BounceTrapDirection.Right
                            If Not Level.IsWallAt(xVal + 1, yVal, False, False) Then Exit
                        Case BounceTrapDirection.Left
                            If Not Level.IsWallAt(xVal - 1, yVal, False, False) Then Exit
                        Case BounceTrapDirection.Down
                            If Not Level.IsWallAt(xVal, yVal + 1, False, False) Then Exit
                        Case BounceTrapDirection.Up
                            If Not Level.IsWallAt(xVal, yVal - 1, False, False) Then Exit
                    End Select
                End For
            Case BounceTrapDirection.Spin
                Self.bounceDir = Util.RndIntRangeFromZero(3, True)

                If Util.RndBool(True)
                    Self.isRotatingCW = True
                Else
                    Self.isRotatingCCW = True
                End If
            Default
                Self.bounceDir = d
        End Select

        Select Self.bounceDir
            Case BounceTrapDirection.Omni
                Self.image = New Sprite("traps/bouncetrap_omni.png", 14, 16, 12, Image.MidHandle)
            Case BounceTrapDirection.UpRight,
                 BounceTrapDirection.UpLeft,
                 BounceTrapDirection.DownLeft,
                 BounceTrapDirection.DownRight
                Self.image = New Sprite("traps/diagonal_bouncetrap.png", 14, 16, 16, Image.MidHandle)
            ' Covers spin and cardinal direction bounce traps.
            Default
                Self.image = New Sprite("traps/bouncetrap.png", 14, 16, 12, Image.MidHandle)
        End Select

        Self.image.SetZ(-995.0)

        Self.originalDir = Self.bounceDir

        Local debugBounceDir := Self.bounceDir
        If d = BounceTrapDirection.Spin
            debugBounceDir = BounceTrapDirection.Spin
        End If
        Debug.WriteLine("    Direction: " + BounceTrapDirection.ToString(debugBounceDir))
    End Method

    Field isRotatingCW: Bool
    Field isRotatingCCW: Bool
    Field bounceDir: Int
    Field originalDir: Int
    Field retractCounter: Int
    Field rotatedBeat: Int = -1

    Method GetFrameToShow: Int()
        Select Self.originalDir
            Case BounceTrapDirection.Right
                Self.image.FlipX(True, False)
            Case BounceTrapDirection.Left
                Self.image.FlipX(False, False)
        End Select

        Local frame := 0

        Select Self.originalDir
            Case BounceTrapDirection.Right,
                 BounceTrapDirection.Left,
                 BounceTrapDirection.DownRight
                frame = 2
            Case BounceTrapDirection.Down,
                 BounceTrapDirection.UpRight
                frame = 4
            Case BounceTrapDirection.UpLeft
                frame = 6
        End Select

        If Self.triggered
            frame += 1
        End If

        Return frame
    End Method

    Method Rotate: Void()
        If Self.isRotatingCW
            Self.bounceDir = Self.RotateDir(Self.bounceDir, True)
        Else If Self.isRotatingCCW
            Self.bounceDir = Self.RotateDir(Self.bounceDir, False)
        End If

        Self.rotatedBeat = Audio.GetClosestBeatNum(True)
    End Method

    Method RotateDir: Int(dir: Int, cw: Bool)
        Debug.TraceNotImplemented("BounceTrap.RotateDir(Int, Bool)")
    End Method

    Method Trigger: Void(ent: Entity)
        Debug.TraceNotImplemented("BounceTrap.Trigger(Entity)")
    End Method

    Method Update: Void()
        If Self.retractCounter > 0
            Self.retractCounter -= 1
            If Self.retractCounter = 0
                Self.triggered = False
            End If
        End If

        If Self.rotatedBeat <> Audio.GetClosestBeatNum(True)
            Self.Rotate()
        End If

        Local frameToShow := Self.GetFrameToShow()
        Self.image.SetFrame(frameToShow)

        Super.Update()
    End Method

End Class

Class BounceTrapDirection

    Const None: Int = -1
    Const Right: Int = 0
    Const Left: Int = 1
    Const Down: Int = 2
    Const Up: Int = 3
    Const DownRight: Int = 4
    Const DownLeft: Int = 5
    Const UpLeft: Int = 6
    Const UpRight: Int = 7
    Const Omni: Int = 8
    Const Spin: Int = 9

    Function ToString: String(dir: Int)
        Select dir
            Case BounceTrapDirection.Right Return "Right"
            Case BounceTrapDirection.Left Return "Left"
            Case BounceTrapDirection.Down Return "Down"
            Case BounceTrapDirection.Up Return "Up"
            Case BounceTrapDirection.DownRight Return "Down Right"
            Case BounceTrapDirection.DownLeft Return "Down Left"
            Case BounceTrapDirection.UpLeft Return "Up Left"
            Case BounceTrapDirection.UpRight Return "Up Right"
            Case BounceTrapDirection.Omni Return "Omni"
            Case BounceTrapDirection.Spin Return "Spin"
        End Select

        Return "None"
    End Function

End Class
