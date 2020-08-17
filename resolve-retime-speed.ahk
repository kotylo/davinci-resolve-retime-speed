; This script was created using Pulover's Macro Creator
; www.macrocreator.com

#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1

; Alt + Control + S
^!s::
Macro1:
IfNotExist, images\edit-page-timeline-settings.png
{
    MsgBox, 0, , Please check if folder "images" is found in %A_ScriptDir%
    Return
}
IfWinNotExist, ahk_exe Resolve.exe
{
    MsgBox, 0, , Please start Resolve to use Retime Speed selection
    Return
}
WinActivate, ahk_exe Resolve.exe
Sleep, 333
MouseGetPos, StartMouseX, StartMouseY
/*
MsgBox, 0, , Find timeline icon for setting search boundaries:
*/
CoordMode, Pixel, Window
ImageSearch, TimelineCursorX, TimelineCursorY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, images\edit-page-timeline-settings.png
If ErrorLevel
	Return
If ErrorLevel = 0
{
    ClipSearchBeginX := TimelineCursorX + 100
    ClipSearchBeginY := TimelineCursorY + 75
    ClipSearchEndX := A_ScreenWidth
    ClipSearchEndY := A_ScreenHeight - 90
    TimelineCursorY += 45
    /*
    Click, %ClipSearchBeginX%, %ClipSearchBeginY%, 0
    Sleep, 10
    Sleep, 5000
    */
}
Else
{
    MsgBox, 0, , No timeline has been found
    Return
}
ClickOnRetimeDropdownCount := 0
ClickOnRetimeDropdown:
ClickOnRetimeDropdownCount += 1
MouseGetPos, TempMouseX, TempMouseY
Click, 0, 0, 0
Sleep, 10
Sleep, 50
CoordMode, Pixel, Window
PixelSearch, ClipX, ClipY, %ClipSearchBeginX%, %ClipSearchBeginY%, %ClipSearchEndX%, %ClipSearchEndY%, 0xE64B3D, 0, Fast RGB
Click, %TempMouseX%, %TempMouseY%, 0
Sleep, 10
If ErrorLevel
{
    MsgBox, 0, , Please select video clip first
    Return
}
/*
MsgBox, 0, , Found %ClipX%`, %ClipY%
*/
ClipEndX := FindClipEnd(ClipX, ClipY)
If ClipEndX > 0
{
    /*
    Click, %ClipEndX%, %ClipY%, 0
    Sleep, 10
    MsgBox, 0, , Found the end of a clip %ClipEndX%!
    */
}
Else
{
    ClipEndX := A_ScreenWidth
}
ClipClickableX := ClipX + 20
ClipClickableY := ClipY + 5
CoordMode, Pixel, Window
ImageSearch, RetimeOpenedX, RetimeOpenedY, %ClipX%, %ClipY%, %ClipEndX%, %ClipSearchEndY%, *1 images\retime-is-opened.png
If ErrorLevel
{
    /*
    MsgBox, 0, , If Retime is closed`, do the menu click
    */
    Click, %ClipClickableX%, %ClipClickableY% Right, 1
    Sleep, 10
    /*
    MsgBox, 0, , Right Clicked on the selected Video Clip
    */
    MenuTopRightX := ClipClickableX
    MenuTopRightX += 375
    Sleep, 300
    CoordMode, Pixel, Window
    ImageSearch, FoundX, FoundY, %ClipClickableX%, 0, %MenuTopRightX%, %A_ScreenHeight%, images\retime-curve.png
    CenterImgSrchCoords("images\retime-curve.png", FoundX, FoundY)
    If ErrorLevel = 0
    	Click, %FoundX%, %FoundY%, 0
    If ErrorLevel
    {
        MsgBox, 0, , Menu has not been opened. Clip is either too narrow or not fully visible. Move it fully inside the view or zoom a bit.
        Return
    }
    Click, Left, 1
    Sleep, 10
    /*
    MsgBox, 0, , Clicked on Retime Curve %A_ScreenWidth% %A_ScreenHeight%
    */
}
Else
{
    /*
    MsgBox, 0, , FOUND THE EVENT ICON!
    */
}
Sleep, 200
CoordMode, Pixel, Window
ImageSearch, RetimeSpeedX, RetimeSpeedY, %ClipX%, %ClipSearchBeginY%, %ClipEndX%, %A_ScreenHeight%, images\retime-speed-dropdown-active-check.png
If ErrorLevel = 0
{
    /*
    MsgBox, 0, , Retime Speed is already opened`, return
    */
    Return
}
CoordMode, Pixel, Window
ImageSearch, RetimeFrameX, RetimeFrameY, %ClipX%, %ClipSearchBeginY%, %ClipEndX%, %ClipSearchEndY%, *1 images\retime-frame-dropdown.png
CenterImgSrchCoords("*1 images\retime-frame-dropdown.png", RetimeFrameX, RetimeFrameY)
If ErrorLevel = 0
{
    /*
    MsgBox, 0, , Found Retime Frame dropdown
    */
    PixelGetColor, RetimeFrameColor, RetimeFrameX, RetimeFrameY
    Click, %RetimeFrameX%, %RetimeFrameY% Left, 1
    Sleep, 10
    Loop, 60
    {
        CoordMode, Pixel, Window
        PixelSearch, FoundX, FoundY, %RetimeFrameX%, %RetimeFrameY%, %RetimeFrameX%, %RetimeFrameY%, %RetimeFrameColor%, 0, Fast RGB
        Sleep, 50
    }
    Until ErrorLevel
    Sleep, 50
    RetimeFrameY += 15
    /*
    MsgBox, 0, , Finding and clicking on "Retime Speed" and "Retime Frame"...
    */
    CoordMode, Pixel, Screen
    PixelSearch, DropdownBottomLeftX, DropdownBottomLeftY, %RetimeFrameX%, %RetimeFrameY%, %RetimeFrameX%, %A_ScreenHeight%, 0x090909, 0, Fast RGB
    If ErrorLevel
    {
        DropdownBottomLeftX := RetimeFrameX
        DropdownBottomLeftY := A_ScreenHeight
        ;MsgBox, 0, , Couldn't find the end of Dropdown Menu`, exiting.
        ;Return
    }
    /*
    Click, %DropdownBottomLeftX%, %DropdownBottomLeftY%, 0
    Sleep, 10
    Sleep, 1000
    */
    DropdownTopRightX := DropdownBottomLeftX
    DropdownTopRightX += 20
    DropdownTopRightY := DropdownBottomLeftY
    DropdownTopRightY -= 55
    /*
    Click, %DropdownTopRightX%, %DropdownTopRightY%, 0
    Sleep, 10
    Sleep, 1000
    MsgBox, 0, , Finding max 2 checked items and unchecking them
    */
    Loop, 2
    {
        CoordMode, Pixel, Window
        ImageSearch, CheckedX, CheckedY, %DropdownBottomLeftX%, %DropdownTopRightY%, %DropdownTopRightX%, %DropdownBottomLeftY%, *1 images\dropdown-checkbox.png
        CenterImgSrchCoords("*1 images\dropdown-checkbox.png", CheckedX, CheckedY)
        If ErrorLevel = 0
        {
            Click, %CheckedX%, %CheckedY% Left, 1
            Sleep, 10
            Sleep, 100
        }
    }
    Sleep, 200
    DropdownRetimeSpeedX := DropdownBottomLeftX
    DropdownRetimeSpeedX += 4
    DropdownRetimeSpeedY := DropdownBottomLeftY
    DropdownRetimeSpeedY -= 35
    Click, %DropdownRetimeSpeedX%, %DropdownRetimeSpeedY% Left, 1
    Sleep, 10
    Sleep, 200
    DropdownRetimeSpeedX += 15
    Click, %DropdownRetimeSpeedX%, %DropdownRetimeSpeedY% Left, 1
    Sleep, 10
    Click, %StartMouseX%, %StartMouseY%, 0
    Sleep, 10
    Return
}
/*
MsgBox, 0, , No Retime Frame`, need to zoom in
*/
Click, %ClipX%, %TimelineCursorY% Left, 1
Sleep, 10
/*
MsgBox, 0, , Clicked on the timeline playhead near the clip to zoom in next
*/
Send, {LControl Down}{= Down}{= Up}{LControl Up}
Sleep, 200
If ClickOnRetimeDropdownCount <= 5
{
    /*
    MsgBox, 0, , Zoomed in`, trying again...
    */
    Goto, ClickOnRetimeDropdown
}
MsgBox, 0, , Unknown error`, probably couldn't find some elements.
Return

FindClipEnd(ClipX, ClipY)
{
    ClipEndX := ClipX + 10
    ClipEndY := ClipY + 10
    CoordMode, Pixel, Window
    PixelSearch, FoundX, FoundY, %ClipEndX%, %ClipEndY%, %A_ScreenWidth%, %ClipEndY%, 0xE64B3D, 0, Fast RGB
    If ErrorLevel = 0
    {
        return FoundX
    }
}


CenterImgSrchCoords(File, ByRef CoordX, ByRef CoordY)
{
	static LoadedPic
	LastEL := ErrorLevel
	Gui, Pict:Add, Pic, vLoadedPic, %File%
	GuiControlGet, LoadedPic, Pict:Pos
	Gui, Pict:Destroy
	CoordX += LoadedPicW // 2
	CoordY += LoadedPicH // 2
	ErrorLevel := LastEL
}
