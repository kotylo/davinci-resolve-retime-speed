# Davinci Resolve Retime Speed
This is AHK Script, designed to fix the lack of configuration in otherwise good video editor, Davinci Resolve v16. Here is the short Demo what happens, when you press `Alt+S`:

![Demonstration of what happens on hotkey](https://github.com/kotylo/davinci-resolve-retime-speed/misc/intro.gif)

By default, Resolve opens up the **Retime Frame**, which is not useful at all. People on the [blackmagic forum](https://forum.blackmagicdesign.com/viewtopic.php?f=33&t=102519) have raised the Feature Request for v17, but instead of waiting for *possible* changes, let's act and achieve auto preselection of **Retime Speed** now!

# Installing
You just have to run the `resolve-retime-speed.exe` and it will stay in the Windows Tray, listening for hotkey within Davinci Resolve. 

*Hint:* Put the shortcut inside your `Win+R` → `shell:startup` → `OK` location for starting with Windows.

# Usage
Just select the video track, Press the `Alt+S` hotkey and see the magic.

# Compilation
You need [AutoHotkey]([https://www.autohotkey.com/download/), it's a Script App that lets you run `.ahk` files and compile them within Windows Context Menu into `.exe`

## Alternative
Also you can use Pulover's Macro Creator, it's the same Script, but in different format.