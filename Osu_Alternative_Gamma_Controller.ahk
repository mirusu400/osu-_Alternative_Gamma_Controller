#SingleInstance Force
Menu,Tray, DeleteAll
Menu,Tray, Add, Show GUI, ShowGui
Gui, Add, GroupBox, x22 y49 w500 h180 vL_GroupTrans, TransParency Setting
Gui, Add, Slider, x202 y69 w100 h20 gSlide vSlideVal Range0-255, 150
Gui, Add, Edit, x122 y69 w80 h20 vTransParency, 150
Gui, Add, Text, x32 y73 w78 h20 vL_TransParency Right, TransParency
Gui, Add, Text, x12 y9 w440 h20 vL_MadeBy, MadeBy. mirusu400    osu Alternative Gamma Controller
Gui, Add, Text, x322 y73 w88 h20 vL_Language Right, Language
Gui, Add, DropDownList, x412 y69 w100 h60 gLang vLanguage, English|한국어
Gui, Add, GroupBox, x32 y99 w260 h120 vL_CustomSize, Custom Size
Gui, Add, CheckBox, x42 y109 w200 h40 gUseCustom_L vUseCustom, Use Custom Size Gamma`n(Default if Blank)
Gui, Add, Edit, x82 y149 w60 h20 vX, 
Gui, Add, Edit, x82 y179 w60 h20 vY, 
Gui, Add, Edit, x212 y149 w60 h20 vWidth, 
Gui, Add, Edit, x212 y179 w60 h20 vHeight, 
Gui, Add, Text, x42 y152 w38 h20 Right, X
Gui, Add, Text, x42 y182 w38 h20 Right, Y
Gui, Add, Text, x162 y152 w48 h20 vL_Width Right, Width
Gui, Add, Text, x162 y182 w48 h20 vL_Height Right, Height
Gui, Add, Button, x312 y149 w200 h70 gSaveRun vSave, Save / Run
Gui, Add, Text, x312 y102 w98 h20 vL_BGColor Right, BG Color
Gui, Add, DropDownList, x412 y99 w100 h100 vBGColor, White|Black|Red|Blue|Green
; Generated using SmartGUI Creator 4.0
Gui, Show,  h252 w546, New GUI Window
GuiControl, ChooseString, BGColor, White
GuiControl, ChooseString, Language, English
GuiControl,Disabled,X
GuiControl,Disabled,Y
GuiControl,Disabled,Width
GuiControl,Disabled,Height
OnExit("ExitFunc")

ifExist,save.ini
{
	Gosub,Load
	Gosub,Lang
}

Return
SplashImageGUI(X, Y, W, H, BGColor, Destroy=0)
{
	if (Destroy == 1)
	{
		Gui, XPT99:Destroy
		return
	}
	Gui, XPT99:Margin , 0, 0
	if(BGColor == "White")
		Gui, XPT99:Color, FFFFFF
	if(BGColor == "Black")
		Gui, XPT99:Color, 000000
	if(BGColor == "Red")
		Gui, XPT99:Color, FF0000
	if(BGColor == "Blue")
		Gui, XPT99:Color, 0000FF
	if(BGColor == "Green")
		Gui, XPT99:Color, 00FF00
	Gui, XPT99:+LastFound -Caption +ToolWindow -Border
	Gui, XPT99:Show, x%X% y%Y% w%W% h%H%
	return
}
ExitFunc(ExitReason, ExitCode)
{
    Gui, XPT99:Destroy
	WinSet, Transparent, 255, ahk_exe osu!.exe
}

ShowGui:
Reload
return


Load:
IniRead, TransParency, save.ini, 저장, TransParency
IniRead, SlideVal, save.ini, 저장, SlideVal
IniRead, Language, save.ini, 저장, Language
IniRead, UseCustom, save.ini, 저장, UseCustom
IniRead, X, save.ini, 저장, X
IniRead, Y, save.ini, 저장, Y
IniRead, Width, save.ini, 저장, Width
IniRead, Height, save.ini, 저장, Height
IniRead, BGColor, save.ini, 저장, BGColor
Guicontrol,,TransParency,%TransParency%
Guicontrol,,SlideVal,%SlideVal%
GuiControl, ChooseString, Language, %Language%
GuiControl, ChooseString, BGColor, %BGColor%
Guicontrol,,UseCustom,%UseCustom%
Guicontrol,,X,%X%
Guicontrol,,Y,%Y%
Guicontrol,,Width,%Width%
Guicontrol,,Height,%Height%
return

RemoveToolTip:
ToolTip
return

SaveRun:
Gui, Submit, hide
IniWrite, %TransParency%, save.ini, 저장, TransParency
IniWrite, %SlideVal%, save.ini, 저장, SlideVal
IniWrite, %Language%, save.ini, 저장, Language
IniWrite, %UseCustom%, save.ini, 저장, UseCustom
IniWrite, %X%, save.ini, 저장, X
IniWrite, %Y%, save.ini, 저장, Y
IniWrite, %Width%, save.ini, 저장, Width
IniWrite, %Height%, save.ini, 저장, Height
IniWrite, %BGColor%, save.ini, 저장, BGColor
ToolTip, Gamma Will Turn On When Osu Activate., A_ScreenWidth, A_ScreenHeight
SetTimer, RemoveToolTip, -3000
loop
{
	loop
	{

		if WinActive("ahk_exe osu!.exe")
		{
			SplashImage, Off
			if(UseCustom==0)
				WinGetPos , X, Y, Width, Height,ahk_exe osu!.exe
			SplashImageGUI(X, Y, Width, Height, BGColor)
			WinSet, Transparent, %TransParency%, ahk_exe osu!.exe
			WinActivate,ahk_exe osu!.exe
			break
		}
		sleep,1000
	}
	loop
	{
		if !WinActive("ahk_exe osu!.exe")
		{
			SplashImageGUI(X, Y, Width, Height, BGColor, 1)
			WinSet, Transparent, 255, ahk_exe osu!.exe
			break
		}
		WinSet, Transparent, %TransParency%, ahk_exe osu!.exe
		sleep,1000
	}
}
return


UseCustom_L:
GuiControlGet,UseCustom
if(UseCustom == 1)
{
	GuiControl,Enabled,X
	GuiControl,Enabled,Y
	GuiControl,Enabled,Width
	GuiControl,Enabled,Height
}
else
{
	GuiControl,Disabled,X
	GuiControl,Disabled,Y
	GuiControl,Disabled,Width
	GuiControl,Disabled,Height
}
return

Lang:
GuiControlGet,Language
if(Language == "English")
{
	Guicontrol,,L_GroupTrans,TransParency Setting
	Guicontrol,,L_TransParency,TransParency
	Guicontrol,,L_Language,Language
	Guicontrol,,L_MadeBy,MadeBy. mirusu400    osu Alternative Gamma Controller
	Guicontrol,,L_CustomSize,Custom Size
	Guicontrol,,UseCustom,Use Custom Size Gamma`n(Default if Blank)
	Guicontrol,,L_Width,Width
	Guicontrol,,L_Height,Height
	Guicontrol,,Save,Save / Run
	Guicontrol,,L_BGColor,BG Color
}
if(Language == "한국어")
{
	Guicontrol,,L_GroupTrans,투명도 설정
	Guicontrol,,L_TransParency,투명도(감마)
	Guicontrol,,L_Language,언어
	Guicontrol,,L_MadeBy,제작: mirusu400    오스 수동 감마 컨트롤러
	Guicontrol,,L_CustomSize,수동 크기
	Guicontrol,,UseCustom,수동으로 감마 영역 지정하기`n(빈칸일시 기본값)
	Guicontrol,,L_Width,가로
	Guicontrol,,L_Height,세로
	Guicontrol,,Save,저장 및 실행
	Guicontrol,,L_BGColor,배경 색
}
return

Slide:
GuiControlGet, SlideVal
Guicontrol,,TransParency,%SlideVal%
Return

GuiClose:
Gosub,SaveRun

