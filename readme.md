# Davinci Resolve Retime Speed
This is AHK Script, designed to fix the lack of configuration in otherwise good video editor, Davinci Resolve v16. Here is the short Demo what happens after you install this Script and when you press `Alt+Ctrl+S`:

![Demonstration of what happens on hotkey](https://github.com/kotylo/davinci-resolve-retime-speed/blob/master/misc/intro.gif?raw=true)

By default, Resolve opens up the **Retime Frame**, which is not useful at all. People on the [blackmagic forum](https://forum.blackmagicdesign.com/viewtopic.php?f=33&t=102519) have raised the Feature Request for v17, but instead of waiting for *possible* changes, let's act and achieve auto preselection of **Retime Speed** now!

# Installing
You just have to run the `resolve-retime-speed.exe` and it will stay in the Windows Tray, listening for hotkey within Davinci Resolve.

*Hint:* Put the shortcut inside your `Win+R` → `shell:startup` → `OK` location for starting with Windows.

*Note:* in case you are using .exe directly, unblock it:
![Unblocking in Windows 10](https://github.com/kotylo/davinci-resolve-retime-speed/blob/master/misc/unblock.png?raw=true)

# Usage
Just select the video track, Press the `Alt+Ctrl+S` hotkey and see the magic.

# Compilation
You need [AutoHotkey]([https://www.autohotkey.com/download/), it's a Script App that lets you run `.ahk` files and compile them within Windows Context Menu into `.exe`

## Alternative
Also you can use Pulover's Macro Creator, it's the same Script, but in different format.

# Versioning

### **v1.0**
Initial release.
- Of course it can be buggy and there is a room for improvement
- Zooms in automatically in case the dropdown is not in the view
- Reactivates *Retime Speed* automatically after closing the Retime Curve
  - Note: May not work in case of Zoom, Pitch or other were already selected before

# Feature Requests
- Changing the default 300% speed to 4000% is the next feature that I'm thinking about, because I change it all the time. Let's see if I have energy to change that, otherwise, PR are welcome.