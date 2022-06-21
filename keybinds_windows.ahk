#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Keymaps, it is still recommended manually to manually map caps lock to ctrl if desired using (Windows: https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10) rather than through autohotkey. Below are keymaps that give a more fluid experience between Mac and Windows.
!z::sendinput ^z
!+z::sendinput ^+z
!x::sendinput ^x
!c::sendinput ^c
!v::sendinput ^v
!w::sendinput ^w
!f::sendinput ^f
!t::sendinput ^t
