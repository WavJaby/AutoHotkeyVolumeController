;######## 設定 ########
closeDelay = 1000
backGroundColor = 1A1A1A
barColor = 666666
titleColor = FFFFFF
title = 音量
barHeight = 12
width = 100
height = 50
gap = 25
;#####################


Volume_Up::
    EditValue("+2")
    return

Volume_Down::
    EditValue("-2")
    return

Volume_Mute::
    SoundSet, +1,,mute
    gosub, VolumeShow
    sleep, 50
    return

;設定音量
EditValue(Val){
    SoundSet, Val
    gosub, VolumeShow
    sleep, 50
}


VolumeShow:
	;只執行一次，初始化
	if (!Volume_OSD_c){
		; mY := (A_ScreenHeight/2)-(height/2), mX := (A_ScreenWidth/2)-(width/2) ;中間
		SysGet m, MonitorWorkArea, 1
		mY:= mTop + gap, mX:= mLeft + gap ;位置 左上角
		;B無邊框
		;CT 文字顏色
		;CW 背景顏色
		;CB 進度條的顏色
		;WS 進度條文字大小
		;FS 進度條文粗細
		;FM title文字大小
		;WM title文字粗細
		;ZY 進度條與文字的間隙
		;C 文字至中
		volumeBarOptions = CW%backGroundColor% CT%titleColor% CB%barColor% x%mX% y%mY% w%width% h%height% B FS8 WS700 FM8 WM700 ZH%barHeight% ZY3 C11
		Progress Hide %volumeBarOptions%,, %title%, "volumeBar", Tahoma
		Volume_OSD_c:= !Volume_OSD_c
	}
	;顯示
	Progress Show
	SoundGet, volume
	;設定視窗名稱"volumeBar"的透明度
	WinSet, Transcolor, Black 225, "volumeBar"
	volume:= Round(Volume)
	;設定進度條的數值, 進度文字
	Progress %volume%, %volume% `%
	;設定時間隱藏 volumeBar
	SetTimer, VolumeClose, %closeDelay%
	return

VolumeClose:
	SetTimer, VolumeClose, Off
	;消失並重設
	Progress Hide %volumeBarOptions%,,%title%, "volumeBar", Tahoma
	return
