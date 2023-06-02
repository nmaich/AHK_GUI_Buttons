;;使い方(how to use)
;F1: GUIを表示します
;ESC: GUIを非表示にします
;ボタンをクリックすると設定したコマンドが実行されます
;矢印キーとEnterでも実行できます

;;設定(how to change button setting)
;HEIGHTとWIDTHでボタンの数を指定
;ボタンを押したときに実行されるコマンドは
;下の方にあるButton_N_M関数で指定します(上からN番目、左からM番目のボタン)
;ifequal event, SetInnerHTML, return "ABCDEF" のところでボタンに表示されるテキストを指定します
;<img src=""" . A_ScriptDir . "/ABC.png"">とすれば画像も貼れます
;fonts.google.com/icons等で画像を拾ってくるといいかもしれません
;その下にAHKで実行するコマンドを書きます

#NoEnv
#SingleInstance force
SetBatchLines, -1
SetTitleMatchMode,3
CoordMode, Mouse, Screen

#Include %A_ScriptDir%\Neutron.ahk-master\Neutron.ahk

Menu, Tray, Icon, %A_ScriptDir%\icon.png

;how many buttons
;ボタンの数（縦・横）
HEIGHT := 4
WIDTH := 4
;initial window size
WINDOW_H := 500
WINDOW_W := 800

;empty html
html = 

css =
( ; css
	/* Make the title bar dark with light text */
	header {
		background: #333;
		color: white;
	}

	/* Make the content area dark with light text */
	.main {
		background: #444;
		color: white;
        white-space: nowrap;
        overflow: hidden;
	}

	button {
        border: none;
		border-radius: 5px;
        vertical-align: middle;
		background: dimgray;
        font-size: 1em;
		color: white;
        width: calc(98`%/%WIDTH% - 4px);
        height: calc(98`%/%HEIGHT% - 4px);
        margin: 2px;
        white-space: normal;
	}

    button:focus {
        background: orange;
    }

)

js =
( ; js
	// Write some JavaScript here
)

title = AHK GUI Buttons

neutron := new NeutronWindow(html, css, js, title)

;change label prefix from Gui to Neutron
neutron.Gui("+LabelNeutron")

;create html buttons
Loop, %HEIGHT%
    {
        i := A_Index
        Loop, %WIDTH%
        {
            j := A_Index
            funcName := "Button_" . i . "_" . j
            elem:= "`n<button onclick=""ahk." . funcName . "(event)""></button>"
            ;MsgBox, % elem
            neutron.qs(".main").innerHTML .= elem
        }
        neutron.qs(".main").innerHTML .= "<br>"
    }
;MsgBox, % neutron.qs("body").innerHTML

;load button innerHTML
buttons := neutron.doc.getElementsByTagName("BUTTON")
Loop, %HEIGHT%
{
    i := A_Index
    Loop, %WIDTH%
    {
        j := A_Index
        funcName := "Button_" . i . "_" . j
        innerHTML := %funcName%("" , "SetInnerHTML")
        idx:=(i-1)*WIDTH+j-1
        buttons[idx].InnerHTML := innerHTML
    }
}

;set focus on first button
buttons[0].focus()

;show window
window_option := "x0 y0 w" . WINDOW_W . " h" . WINDOW_H
neutron.Show(window_option)

return
;end of auto execution area---------------------------------------------------------

; The built in GuiClose, GuiEscape, and GuiDropFiles event handlers will work
; with Neutron GUIs.  Here, we're using the name NeutronClose because the GUI was
; given a custom label prefix up in the auto-execute section.
NeutronClose:
    neutron.Hide()
    ;ExitApp
Return

;;Hot Keys-------------------------------------------------------------------------
F1::
    If neutron.doc.activeElement.tagName != "BUTTON"
    {
        neutron.doc.getElementsByTagName("BUTTON")[0].focus()
    }
    neutron.Show()
Return

#If WinActive("AHK_GUI_Buttons.ahk")
Right::FocusNextElement(neutron)
Left::FocusPreviousElement(neutron)
Down::FocusBelowElement(neutron)
Up::FocusAboveElement(neutron)
Esc::neutron.Hide()
#If


FocusNextElement(neutron)
{
    active := neutron.doc.activeElement
    active.nextElementSibling.focus()
}
FocusPreviousElement(neutron)
{
    active := neutron.doc.activeElement
    active.previousElementSibling.focus()
}
FocusBelowElement(neutron)
{
    global WIDTH
    active := neutron.doc.activeElement
    Loop, %WIDTH%
    {
        active := active.nextElementSibling
    }
    active.nextElementSibling.focus()
}
FocusAboveElement(neutron)
{
    global WIDTH
    active := neutron.doc.activeElement
    Loop, %WIDTH%
    {
        active := active.previousElementSibling
    }
    active.previousElementSibling.focus()
}

;;Button Event ---------------------------------------------------------------------------
;ボタンが押されたときに実行されるコマンドを記述します
;WIDTHやHEIGHTを増やした場合はボタンを足してください

Button_1_1(neutron, event)
{
    ifequal event, SetInnerHTML, return "1_1"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_1_2(neutron, event)
{
    ifequal event, SetInnerHTML, return "1_2"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_1_3(neutron, event)
{
    ifequal event, SetInnerHTML, return "1_3"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_1_4(neutron, event)
{
    ifequal event, SetInnerHTML, return "日付入力"
    neutron.Hide()
    SendDayString()
}

;------------------------------------------------------------------------------
Button_2_1(neutron, event)
{
    ifequal event, SetInnerHTML, return "2_1"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_2_2(neutron, event)
{
    ifequal event, SetInnerHTML, return "2_2"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_2_3(neutron, event)
{
    ifequal event, SetInnerHTML, return "2_3"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_2_4(neutron, event)
{
    ifequal event, SetInnerHTML, return "音声出力デバイスを変更"
    ChangeAudioOutDevice()
}

;-----------------------------------------------------------------------
Button_3_1(neutron, event)
{
    ifequal event, SetInnerHTML, return "3_1"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_3_2(neutron, event)
{
    ifequal event, SetInnerHTML, return "3_2"
    MsgBox, % "You clicked: " event.target.innerText
    neutron.Hide()
}
Button_3_3(neutron, event)
{
    ifequal event, SetInnerHTML, return "3_3"
    MsgBox, % "You clicked: " event.target.innerText
    neutron.Hide()
}
Button_3_4(neutron, event)
{
    ifequal event, SetInnerHTML, return "<img src=""" . A_ScriptDir . "/pen.png""><span style=""font-size: 15px; color: yellow;"">Open AHK Script</span>"
    neutron.Hide()
    Run, "Notepad.exe" "%A_ScriptDir%\AHK_GUI_Buttons.ahk"
}

;------------------------------------------------------------------------
Button_4_1(neutron, event)
{
    ifequal event, SetInnerHTML, return "4_1"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_4_2(neutron, event)
{
    ifequal event, SetInnerHTML, return "4_2"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_4_3(neutron, event)
{
    ifequal event, SetInnerHTML, return "4_3"
    neutron.Hide()
    MsgBox, % "You clicked: " event.target.innerText
}
Button_4_4(neutron, event)
{
    ifequal event, SetInnerHTML, return "<img src=""" . A_ScriptDir . "/refresh.png""><span style=""font-size: 15px; color: yellow;"">Reload AHK Script</span>"
    Reload
}

;User Functions-----------------------------------------------------------------
SendDayString()
{
    FormatTime,TimeString,,yyyy/MM/dd
    Send,%TimeString%
    FormatTime,TimeString,,ddd
    Send,%TimeString%
    Return
}

ChangeAudioOutDevice(){
    run,control mmsys.cpl sounds
    WinWait,サウンド ahk_class #32770
    BlockInput,On
    WinGet, sound, ID,サウンド ahk_class #32770
    ControlGet,list,list,,SysListView321,ahk_id %sound%
    current_device_idx := -1
    top_available_device_idx:=-1
    next_available_device_idx := -1
    Loop,Parse,list,`n
    {
        ;現在の既定のデバイスを探す
        IfInString,A_LoopField,既定
        {
            current_device_idx:=A_Index
        }
        
        IfInString,A_LoopField,準備完了
        {
            ;先頭の準備完了デバイス
            If(top_available_device_idx == -1 and current_device_idx == -1)
            {
                top_available_device_idx:=A_Index
            }
            ;現在の既定のデバイス以降の準備完了デバイス
            If(current_device_idx != -1)
            {
                next_available_device_idx:=A_Index
                break
            }
        }
    }
    ;MsgBox, %current_device_idx%`n%top_available_device_idx%`n%next_available_device_idx%

    ;デバイスを変更
    If(next_available_device_idx == -1)
    {
        Loop,%top_available_device_idx%
            {
                ControlSend,SysListView321,{down},ahk_id %sound%
            }
    }
    Else
    {
        Loop,%next_available_device_idx%
        {
            ControlSend,SysListView321,{down},ahk_id %sound%
        }
    }   
    ControlSend,Button2,{Space},ahk_id %sound%
    ControlSend,Button2,{Enter},ahk_id %sound%
    BlockInput,Off
    return
}


