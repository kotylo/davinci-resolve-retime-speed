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
CoordMode, Pixel, Window
PixelSearch, ClipX, ClipY, %ClipSearchBeginX%, %ClipSearchBeginY%, %ClipSearchEndX%, %ClipSearchEndY%, 0xE64B3D, 0, Fast RGB
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
CoordMode, Pixel, Screen
ImageSearch, RetimeOpenedX, RetimeOpenedY, %ClipX%, %ClipY%, %ClipEndX%, %ClipSearchEndY%, images\retime-is-opened.png
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
    MenuTopRightY := ClipClickableY
    MenuTopRightX += 375
    MenuTopRightY -= 758
    Sleep, 300
    CoordMode, Pixel, Window
    ImageSearch, FoundX, FoundY, %ClipClickableX%, %MenuTopRightY%, %MenuTopRightX%, %ClipClickableY%, images\retime-curve.png
    CenterImgSrchCoords("images\retime-curve.png", FoundX, FoundY)
    If ErrorLevel = 0
    	Click, %FoundX%, %FoundY%, 0
    If ErrorLevel
    {
        MsgBox, 49, Continue?, Image / Pixel Not Found.`nPress OK to continue.
        IfMsgBox, Cancel
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
ImageSearch, RetimeFrameX, RetimeFrameY, %ClipX%, %ClipSearchBeginY%, %ClipEndX%, %ClipSearchEndY%, images\retime-frame-dropdown.png
If ErrorLevel = 0
{
    /*
    MsgBox, 0, , Found Retime Frame dropdown
    */
    RetimeFrameX -= 9
    RetimeFrameY += 13
    Click, %RetimeFrameX%, %RetimeFrameY% Left, 1
    Sleep, 10
    Sleep, 400
    /*
    MsgBox, 0, , Finding and clicking on "Retime Speed" and "Retime Frame"...
    */
    CoordMode, Pixel, Window
    ImageSearch, MenuRetimeSpeedX, MenuRetimeSpeedY, %ClipX%, %ClipSearchBeginY%, %ClipEndX%, %A_ScreenHeight%, images\menu-retime-speed.png
    If ErrorLevel = 0
    {
        /*
        MsgBox, 0, , Menu "Retime Speed" has been found!
        */
        MenuRetimeSpeedX += 5
        MenuRetimeSpeedY += 9
        /*
        MsgBox, 0, , Click on the Retime Frame first`, so that Speed is last and active
        */
        MenuRetimeSpeedY += 25
        Click, %MenuRetimeSpeedX%, %MenuRetimeSpeedY% Left, 1
        Sleep, 10
        Sleep, 200
        MenuRetimeSpeedY -= 25
        Click, %MenuRetimeSpeedX%, %MenuRetimeSpeedY% Left, 1
        Sleep, 10
        Sleep, 200
    }
    Else
    {
        /*
        MsgBox, 0, , Menu has not been opened`, OR Retime Speed is already active?!
        */
        CoordMode, Pixel, Window
        ImageSearch, MenuRetimeFrameX, MenuRetimeFrameY, %ClipX%, %ClipSearchBeginY%, %ClipEndX%, %A_ScreenHeight%, images\menu-retime-frame-active.png
        If ErrorLevel = 0
        {
            /*
            MsgBox, 0, , Retime Frame has to be declicked and Retime Speed activated
            */
            MenuRetimeFrameX += 5
            MenuRetimeFrameY += 9
            /*
            MsgBox, 0, , Click on the Retime Frame first`, ACTIVATE Speed later
            */
            Click, %MenuRetimeFrameX%, %MenuRetimeFrameY% Left, 1
            Sleep, 10
            Sleep, 200
            MenuRetimeFrameY -= 25
            MenuRetimeFrameX += 30
            Click, %MenuRetimeFrameX%, %MenuRetimeFrameY% Left, 1
            Sleep, 10
        }
    }
    Click, %ClipX%, %ClipY% Left, 1
    Sleep, 10
    Return
}
/*
MsgBox, 0, , No Retime Frame`, need to zoom in?
*/
CoordMode, Pixel, Window
ImageSearch, RetimeSpeedX, RetimeSpeedY, %ClipX%, %ClipSearchBeginY%, %ClipEndX%, %A_ScreenHeight%, images\retime-speed-dropdown-active-check.png
If ErrorLevel = 0
{
    /*
    MsgBox, 0, , Retime Speed is already opened`, return
    */
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
