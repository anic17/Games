Dim oPlayer, FSO
Set oPlayer = CreateObject("WMPlayer.OCX")
Set FSO = createObject("Scripting.FileSystemObject")
Set tmpsmSND = FSO.createtextfile("TMP\StartMusic.ini",true)
tmpsmSND.writeline "Start=1"
tmpsmSND.close


If Not FSO.FileExists("Sounds\StartMusic.wav") Then
	msgbox "Cannot find .\Core\Sounds\StartMusic.wav:"&vbCrLf&"Audio cannot be displayed",4112,"Cannot find .\Core\Sounds\StartMusic.wav"
	WScript.Quit()
End If
oPlayer.URL = "Sounds\StartMusic.wav"
do
'Play start music
oPlayer.controls.play 
While oPlayer.playState <> 1 ' 1 = Stopped
  WScript.Sleep 100
Wend

If Not FSO.FileExists("TMP\StartMusic.ini") Then
	oPlayer.Close
	WScript.Quit()
End If

loop
oPlayer.close

