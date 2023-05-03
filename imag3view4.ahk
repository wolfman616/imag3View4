﻿#NoEnv
#NoTrayIcon
#SingleInstance,Force
#IfTimeout,200 ;* DANGER *: Performance impact if set too low. *think about using this*.
#include C:\Script\AHK\- _ _ LiB\GDI+_All.ahk
PiD:= DllCall("GetCurrentProcessId")
;(imgv_instance:= winexist("imgvi3w4 ahk_class AutoHotkeyGUI",,"ahk_pid " . PID)? exitapp())
; if (!instr(A_AhkPath,"UIA")&&!A_IsCompiled) {
	; run,%A_AhkPath%\..\AutoHotkeyU64_UIA.exe "%A_ScriptFullPath%" "%1%"
	; exitApp,
; }
#maxthreadsperhotkey 3
menu,tray,icon
ListLines,Off
;Setworkingdir,% (ahkexe:= splitpath(A_AhkPath)).dir
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,	2
SetTitleMatchMode	Slow
SetBatchLines,		-1
SetWinDelay,		-1
coordMode,	ToolTip,Screen
coordmode,	  Mouse,Screen

%0%? ImagePath:= A_Args[1] : ()
gosub,onMsgs

OPT_Brightness:= 80 ;test

OPT_Anchor:= True ; anchor session to position last used.

fTypes:= [], fTypes:= ["png","jpg","jpeg","jfif","gif","bmp","ico","xcf","tiff","cur","ani","bin"]

global hks:= "~wheelup,~wheeldown,~left,~right,~wheelleft,~wheelright,~=,~-,~#r,~r,~XButton1,~XButton2,~F21,~F22"

loop,parse,% "Varz,Reg_Read,Menus,Binds,OPT_enact,TOP_PreCheckInit",`,
	gosub(A_loopfield)

loop,parse,% hk,`,
	hotkey,% A_loopfield,testlabel,On

hotkey,~Escape,guiEscape,On

MAIN(ImagePath)
return,

~escape::
critical
tt("GuiClose")
exit:= True
exitapp,

Moved() {
	gpos:= wingetpos(hgui)
	netx:=(gpos.x<a_screenWidth&&gpos.x>0)?  gpos.x : a_screenWidth*.5-CURRENT_W*.5
	, nety:=(gpos.y<a_screenHeight&&gpos.y>0)?  gpos.y : a_screenHeight*.5-CURRENT_h*.5
}

MenuRButtUp(){
tt("RBUTTUP")
}
testlabel:
;tt(a_thishotkey)
Return,

MAIN(Path2Pic1) {
	Curr_i:= Xcrete("","Preparse","",Path2Pic1)
	Xcrete(Curr_i) ; Xcrete( Curr_i - 1) ; Xcrete( Curr_i + 1)
	Xcrete(Curr_i,"upd8")
	return,
}

Xcrete(i="",lab3l="",h_key="",inp4th="") {
	global
	static pbitmap
	if(!Xcret10n) {
		loop,parse,hks,`,
			hotkey,% a_loopfield,Labl_Keys,on
		Xcret10ninit:= True
	} critical
	if(lab3l) {
		goto,% lab3l
		return,
	} else,try {
		OPT_Benchmark? a_scriptStartTime:= a_tickCount : ()
		gui,pic: New,-DPIScale +ParentPwner  +ToolWindow +E0x80000 ;+AlwaysOnTop
		gui,pic: +LastFound -Caption -SysMenu +OwnDialogs
		hwnd_pic:= WinExist(), Curr_File:= pic_arr[oio:=i].CurrPath
		,pToken:= Gdip_Startup(), sdr:=(x10n="ico"?6:"") ; try,pBitmap:= Gdip_CreateBitmapFromFile(Curr_File,sdr)
		ndk:= pBitmap:= File_2_pBMP(Curr_File) ; faster than GdipCreateBitmapFromFile and does not lock file.
		(matrixapply=true? Gdip_BitmapApplyEffect(pBitmap,Gdip_CreateEffect(3, Matrix_,"",""),0,0,a_screenWidth,a_screenHeight))
		if(rotate) ;msgbox % Format("{:#x}",Gdip_GetImageFlags(ndk))
			switch,rotate {
				case,"ResetRot":Gdip_ImageRotateFlip(pBitmap,0), rotate:="0"
				case,"90"	:Gdip_ImageRotateFlip(pBitmap,1)
				case,"180"	:Gdip_ImageRotateFlip(pBitmap,2)
				case,"-90","270" :Gdip_ImageRotateFlip(pBitmap,3)
				case,"fliph":Gdip_ImageRotateFlip(pBitmap,4)
				case,"flipv":Gdip_ImageRotateFlip(pBitmap,6)
			}

		_Wo:= Gdip_GetImageWidth(pBitmap), _Ho:= Gdip_GetImageHeight(pBitmap)

		if(OPT_ShrinkFill||OPT_MaxFill) {
			rw:= (a_screenWidth /(_Wo)), rh:= (a_screenHeight/(_Ho))
			if(_Wo>a_screenWidth) {
				current_h:=_Ho*rw, current_W:=_Wo*rw
			} else,if(_Ho>a_screenHeight) {
				current_h:=_Ho*rh, current_W:=_Wo*rh
			} tt(_Wo "`n " _Ho "`n " current_w "`n " current_h )
		} else {
			current_w:=_Wo, current_h:=_Ho
		}	pImage:= Gdip_CreateBitmap(CURRENT_W,CURRENT_H)
		G2:= Gdip_GraphicsFromImage(pImage)
		Gdip_SetInterpolationMode(G2,1), Gdip_SetSmoothingMode(G2,1)

		(OP_dimlum:=(OPT_brightness? true : false)? matrix_:=MatrixBrightness(OPT_brightness))

		Gdip_DrawImage(G2,pBitmap,0,0,CURRENT_W,CURRENT_H,0,0,_Wo,_Ho,(matrix_?matrix_:""))

		if(x10n="ico")
			goto,DC_stuff
		else,if(OPT_MaxFill)
			goto,shrinkxpand
		else,if(CURRENT_W>a_screenWidth||CURRENT_H>a_screenHeight)
			goto,shrinkxpand
		else,goto,DC_stuff
		return,
;-----------------------------------------------------------------
		shrinkXpand:
		if(OPT_MaxFill) {
			rw:= (a_screenWidth /(CURRENT_W)), rh:= (a_screenHeight/(CURRENT_H))
			,CURRENT_H:= rw<rh? floor(rw*(CURRENT_H)) : a_screenHeight
			,CURRENT_W:= rw<rh? a_screenWidth : floor(rh*(CURRENT_W))
			,hi:= ("h" . round(CURRENT_H)), wi:= ("w" . round(CURRENT_W))
		}

		DC_stuff: ;Gdip_DrawImageFX(pGraphics, pBitmap, dX:="", dY:="", sX:="", sY:="", sW:="", sH:="", matrix:="", pEffect:="", ImageAttr:=0, hMatrix:=0, Unit:=2)
		if(copy) { ; Gdip_DrawImageFast(G2, pBitmap, 0, 0)
		;	pImage:= Gdip_CreateARGBBitmapFromHBITMAP(Gdip_CreateHBITMAPFromBitmap(pImage))
		;	Gdip_BitmapApplyEffect(pImage ,Gdip_CreateEffect(3,"" ,"",""),0,0,a_screenWidth,a_screenHeight)
		; 	Gdip_BitmapApplyEffect(pImage ,Gdip_CreateEffect(3, Matrix_Alpha2,"",""),0,0,a_screenWidth,a_screenHeight)
		; 	Gdip_SetBitmapToClipboard(pImage)
		;	Gdip_SetBitmapToClipboard(pImage,Gdip_CreateHBITMAPFromBitmap(pImage))
			pImage3:=Gdip_CreateARGBBitmapFromHBITMAP(pimage2:=Gdip_CreateHBITMAPFromBitmap(pImage))
			Gdip_SetBitmapToClipboard(pimage3), copy:=false ;msgbox % Gdip_GetImagePixelFormat(pBitmap,2)
		} if(getkeystate("escape","p"))
			exitapp
		mDC:=	Gdi_CreateCompatibleDC(0)
		,mBM:=	Gdi_CreateDIBSection((mDC),CURRENT_W,CURRENT_H,32) ;(OPT_greyscale? mBM:= GDI_GrayscaleBitmap(mBM2))
		,oBM:=	Gdi_SelectObject(mDC, mBM) ;pImage:=Gdip_BlurBitmap(pImage,8)
		,pG_:=	Gdip_CreateFromHDC(mDC) ;pImage2:= Gdip_CreateBitmapFromFile("C:\Script\AHK\GDI\images\topbar3.png")

		if(a_thislabel="DC_stuff")
			Gdip_DrawImageFast(pG_,pImage,0,0)
		else,try,Gdip_DrawImageRECTI(pG_,pImage,0,0,CURRENT_W,CURRENT_H)
		OPT_topmost? gui_zpos:= "+AlwaysOnTop" : gui_zpos:= ""
		,OPT_noactiv8:= false ;testing
		,OPT_noactiv8? gui_noactiv8:= " NA " : gui_noactiv8:= ""
		,OPT_posallCenter:= true ;testing
		,OPT_posallCenter? gui_pos := "Center" : ()
		gui,Pwner:-Caption %gui_zpos%
		return,

		inratio:
		loop,
			if((CURRENT_H*a_index)>a_screenHeight ) {
				multipliera:= a_index -1
				break,
			}
		loop,
			if((CURRENT_H*a_index)>a_screenWidth ) {
				multiplierb:= a_index -1
				break,
			} result:= (multipliera<multiplierb) ? multipliera : multiplierb
	,	old_H:= CURRENT_H, old_W:= CURRENT_W
	,	hi:= ("h" .	round(CURRENT_H*=result) ) ; hi:=  ("h" . round(CURRENT_H))
	,	wi:= ("w" .	round(CURRENT_W*=result) ) ; wi:=  ("w" . round(CURRENT_W))
	}
	return,

	Preparse:
	pic_arr:= {}, xcent:= (a_screenWidth *.5), ycent:= (a_screenHeight *.5)
	SplitPath,inp4th,Starting_file,Image_dir,x10n,Image_Title
	setWorkingDir,% Image_dir
	OPT_recurse:= "R",	Paths:= ""
	gui,	Pwner:New,,% "imgvi3w4"
	gui,	Pwner:+LastFound -Caption -DPIScale +ToolWindow +E0x80000 +HWNDhGui  ; hGui := WinExist()
	Loop,	Files,% Image_dir "\*.*",% OPT_recurse
	{	; Trim(A_LoopFileFullPath) "'"
		targetpath:= LTrim(A_LoopFileFullPath)
		if(targetpath:= RTrim(targetpath)) {
			SplitPath,A_LoopFileFullPath,,,xTnz0n
			switch,xTnz0n {
				case,fTypes[1],fTypes[2],fTypes[3],fTypes[4],fTypes[5],fTypes[6],fTypes[7],fTypes[8],fTypes[9]:
					pic_arr[ a_index ]:= ({"CurrPath" : A_LoopFileFullPath : "xtn" : xTnz0n })
					(A_LoopFileFullPath=inp4th? oio:= a_index)
			} Max_i:= a_index
		} else,msgbox,error
	} (!Max_i? msgb0x("Error!", "Error no max`n:("))
	return,oio

	upd8: ;if (!OPT_ShrinkFill) {
	if((_netnx>a_screenWidth)&&(_netny>a_screenHeight))
		_Netnx:=0, _Netny:=0
	gpos:= wingetpos(hgui)
	(netx? netxold2:= net_x:= netx), (nety?netyold2:= net_y:= nety)
	(!(_nx-gpos.x=0)? net_x:= gpos.x), (!(_ny-gpos.y=0)? nety:= gpos.y)
	_nxold:=_nx, _nyold:=_ny, CURRENT_W_old:= CURRENT_W, CURRENT_h_old:= CURRENT_H
	_nx:= round(xcent-(CURRENT_W*.5)), _ny:= round(ycent-(CURRENT_H*.5)) ;center alignment;
	(net_x<0||net_x=0? net_x:= 48),	(Nety<0||Nety=0? NetY:= 64)
	(NetY+CURRENT_H>a_screenHeight? nety:=a_screenHeight-CURRENT_H-20)
	(net_x+CURRENT_w>a_screenWidth? nety:=a_screenWidth-CURRENT_w-20)
	(OPT_movecenter? (_nx -=net_x, _ny -=Nety)
	. (((_nx>a_screenWidth-CURRENT_W)? _nx:=a_screenWidth-CURRENT_W)<0? _nx:=0)
	. (((_ny>a_screenHeight-CURRENT_h)? _ny:=a_screenHeight-CURRENT_h)? _nx:=0)
	: (  _nx :=net_x, _ny :=Nety)) ;}
	DllCall("UpdateLayeredWindow","Uint",hGui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
	 ,"Uint",mDC,"int64P",0,"Uint",0,"intP",0xFF<<16|1<<24,"Uint",2) ;msgbox % _nx " " _nY
	gui,Pwner: Show,%gui_noactiv8% x%_nx% y%_ny% w%CURRENT_w% h%CURRENT_H%
	SetForegroundWindow(hgui) ;(OPT_BENCHMARK? _:= (a_tickCount-a_scriptStartTime) . " Ms", TT(_))

	delete:
	GDI_SelectObject(mDC,oBM)
	Gdi_DeleteObject(mBM) ;Gdi_DeleteDC(mDC);
	Gdip_DeleteGraphics(g2)
	Gdip_DisposeImage(pImage)
	Gdip_DisposeImage(pbitmap)
	return,

	old_delete:
	gui,pic:destroy
	Gdip_Shutdown(pToken)
	return,

	Labl_KeysL:
	MouseGetPos,,,OWin,OControl ; 1|2|3
	((OWin=hGui)? hovered:= True : (hovered:= False))
	(!h_key? msgb0x("error"))
	(instr(h_key,"~")? h_key:= strreplace(h_key,"~") : (h_key:= h_key))
	iOLD2:= iOLD1, iOLD1:= oio
	ifwinNotActive,ahk_id %hGui%
		 if(!hovered)
			return,
	switch,h_key {
		case,"=" : OPT_MaxFill:=!OPT_MaxFill
			(OPT_MaxFill? (nety? (netyTemp:= nety,nety := 0) : (netyTemp?nety:= netyTemp))) ;keeps x offset when maximized
		case,"-" : OPT_ShrinkFill:=!OPT_ShrinkFill
			; switch,mag {
				; case,"7" : SzWin("x6")
				; case,"6" : SzWin("x5")
				; case,"5" : SzWin("x4")
				; case,"4" : SzWin("x3")
				; case,"3" : SzWin("x2")
		;	}
		case,"wheeldown" : refrec(curr_i+=1) ; case,"right","wheeldown" : critical
		;tt(hovered " " hGui " " OWin " " hwnd_pic, 10)
		;curr_i:= (oio<Max_i? oio += 1 : oio:= 1)
		;case,"^right","~^wheeldown","~^wheelright": curr_i:= refrec(5) ;curr_i:= (oio<Max_i? oio += 5 : oio:= 1)
		;case,"left","~wheelup","wheelup" : critical
		case,"wheelup" : refrec(curr_i-=1)
			  ;curr_i:= (oio>0? oio -= 1 : oio:= Max_i)
		;case,"^left","~^wheelup","~^wheelleft" : curr_i:= refrec(-5)
			;return,
		case,"delete" : ifwinnotActive,ahk_id %hGui%
			return,
			; FileRecycle,% pic_arr[oio].CurrPath
			; tt(pic_arr[oio].CurrPath "`nSent to the recycle bin",1300)
			; return,
		case,"#r" : reload,
	}	; switch,pic_arr[oio].xtn {
		; case,"ico"		:	tt("ico file",3000)
		; case,"gif"		:	tt("gif file",3000)
		; case,"default"	:	tt(pic_arr[oio].xtn " file.")	; }
	Xcrete(oio), Xcrete(oio,"upd8")
	(!(iold2=oio)? Xcrete(iOLD2,"old_delete"))
	return,
}

SzWin(sZ,hWn="",center="") {
	static MidX:= a_screenWidth *.5, MidY:= a_screenHeight *.5
	,HAg_Tsk:= a_screenHeight -54 ;(instr(sZ,"center"))? sZ:= strreplace(sZ,"center",""):()
	siZ:= sZ, (hWn=""?hWn:= WinExist("A")) ;(!(center="")? Center:= True)
	try,((!WActive:= wingetpos(hWn))? msgb0x("add")) ;winminimize,ahk_id %hWn% ;winrestore,ahk_id %hWn%
	WActive.w-=12, WActive.h-=46
	switch,sZ {
		case,"quad","x4": (((WActive.h*4)<HAg_Tsk)
			?	(CURRENT_W *=4, CURRENT_H *=4, mag++)
			:	retval:= "x3")
			(retval?SzWin(retval,hWn):0)
		case,"triple","x3": (((WActive.h*3)<HAg_Tsk)
			?	(CURRENT_W *=3, CURRENT_H *=3, mag++)
			:	retval:= "x2")
			(retval?SzWin(retval,hWn):0)
		case,"double","x2","2/1" : (((WActive.h*3)<HAg_Tsk)
			?	(CURRENT_W *=3, CURRENT_H *=3, mag++)
			:	retval:= "1/2")
			(retval?SzWin(retval,hWn):0)
		case,"halve","half","1/2": (CURRENT_W *=.5, CURRENT_H *=.5, mag--)
		case,"+10%" : win_move(hWn,WActive.X,WActive.Y,(WActive.W*1.1)+12,(WActive.H*1.1)+46,"")
		case,"-10%" : win_move(hWn,WActive.X,WActive.Y,(WActive.W*0.9)+12,(WActive.H*0.9)+46,"")
		case,"+50%" : win_move(hWn,WActive.X,WActive.Y,round(WActive.W*1.5)+12,round(WActive.H*1.5)+46,"")
		case,"-33%" : win_move(hWn,WActive.X,WActive.Y,round(WActive.W*0.777)+12,round(WActive.H*0.777)+46,"")
	}	ratio_Longest:= (WActive.W>WActive.H
		? "Landscape" . ratio_Longest:= WActive.H/WActive.W
	: "portrait" . ratio_Longest:= WActive.W/WActive.H)
	loop,{
		 ((Accuracy:= (raw:= a_index *(1/ratio_Long)) -(rounded:= round(raw)))
		, < 0.05? denominator:= a_index, msgb0x("demoninatoir: " a_index "`nacc: " Accuracy))
		if(denominator||(a_index>20))
			return,(Denomintator? Denomintator:0)
	}
}

WM_rBUTTONdown(wParam="",lParam="",umsg="",hwnd="") { 	;toggles maximise fill
	global STrigga,hgui, LbD:=""
	tt("rbd " hwnd_pic _s wParam _s Format("{:#x}",lParam ) _s umsg _s Format("{:#x}",hwnd))
	((hwnd!=hgui)? return())
	;if !STrigga {		GuiMenu()
		settimer,GuiMenu,-1
	return,
}	;}

WM_rBUTTONup(wParam="",lParam="",umsg="",hwnd="") { 	;toggles maximise fill
	return,

	global STrigga,hgui, LbD:=""
	tt( "rbu " hgui _s wParam _s Format("{:#x}",lParam ) _s umsg _s Format("{:#x}",hwnd))
	if(hwnd!=hgui)
		return
	if(!STrigga) {
		settimer,GuiMenu,-1
		return,
}	}

WM_LBUTTONDBLCLK(wParam,lParam,byref RECT,mDC) {
	global Curr_File
	Open_Containing(Curr_File)
	sleep,50
	exitapp
}

WM_RBUTTONDOWN2(byref wParam,byref lParam,byref RECT) {
	global hGui,rbutton_cooldown:=false
	settimer,rbutton_cooldown_reset,-670
	xs:= lParam &0xffff, ys:= lParam>>16
	DllCall("SetWindowBand","ptr",hGui,"ptr",0,"uint",15)
	;tt(a_lasterror)
	While,GetKeyState("rbutton","P") {
		if(!GetKeyState("rbutton","P"))
			return,
		DllCall("GetCursorPos","Uint",&RECT)
		vWinX:= NumGet(&RECT,0,"Int")-xs
		vWinY:= NumGet(&RECT,4,"Int")-ys
		win_move(hGui,vWinX,vWiny,"","","")
		sl33p()
}	}

; WM_NCLBUTTONDOWN(byref wParam="",byref lParam="") {
	; tt("GA")
; }

WM_rBUTTONup2(byref wParam="",byref lParam="") {
	global Curr_File,rbutton_cooldown
	OpenContaining(Curr_File)
	settimer,rbutton_cooldown_reset,-1
	(rbutton_cooldown="")? rbutton_cooldown:= false : ()
	send,{rbutton up}
}

WM_KEYUP(wParam,lParam) {
	global hWnd_Par
	switch,wParam {
		case,"37"	: curr_i:= refrec(-1) ;left arrow
		case,"39"	: curr_i:= refrec(1) ;r arrow
		case,"27 "	: settimer,guiclose,-1 ;esc
		case,"13"	: gui,pwn:submit,nohide ;enter
					  send,{tab} ;gosub,editx ;gosub,edity ;gosub,Timertest2
		default		: tt(wParam "`n" Format("{:#x}",lParam))  ; case,"":
	return,
}	}

refrec(byref _i="") {
	global
	return,((curr_i<1)? _i:= Max_i : ((curr_i>Max_i)? _i:= 1))
	, Xcrete(_i), sl33p(), Xcrete(oio,"upd8")
	, (!(iold2=oio)? Xcrete(iOLD2,"old_delete"))
}

Labl_Keys:
Xcrete(Curr_i,(a_thislabel . "L"),a_thishotkey)
return,

OPT_enact:
menu,Tray,icon,% "preserve position characteristics"
,% OPT_movecenter? "C:\Icon\256\ticAMIGA.ico" : "C:\Icon\48\na_48.ico",,48
return,

sl33p() {
	return,sSleep(10)
}

sSleep(stime=4) {
	DllCall("Winmm\timeBeginPeriod","UInt",3)
	DllCall("Sleep","UInt",stime)
	DllCall("Winmm\timeEndPeriod","UInt",3)
}

SetClipboardData(hBitmap) {
	DllCall("GetObject","Uint",hBitmap,"int",VarSetCapacity(oi,170,0),"Uint",&oi)
	hDBI :=	DllCall("GlobalAlloc","Uint",2,"Uint",80+NumGet(oi,88))
	pDBI :=	DllCall("GlobalLock","Uint",hDBI)
	DllCall("RtlMoveMemory","Uint",pDBI,"Uint",&oi+48,"Uint",80)
	DllCall("RtlMoveMemory","Uint",pDBI+80,"Uint",NumGet(oi,40),"Uint",NumGet(oi,88))
	DllCall("GlobalUnlock","Uint",hDBI)
	DllCall("OpenClipboard","Uint",0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData","Uint",8,"Uptr",hDBI)
	DllCall("CloseClipboard")
}

Copy_Image_Data:
copy:=true, Xcrete(oio), Xcrete(oio,"upd8")
return,

; Gdip_SetBitmapToClipboard
; pToken2	:= Gdip_Startup()
; pBitmap2:= Gdip_CreateBitmapFromFile(Curr_File)
; msgbox % pBitmap2
; hBitmap2:= Gdip_CreateHBITMAPFromBitmap(42,0)
; Gdip_DisposeImage(pBitmap2)
; Gdip_Shutdown(pToken2)
; SetClipboardData(hBitmap2)
; sleep 499
; DllCall("DeleteObject", "Uint", hBitmap2)
; sleep 499
; return

; pToken2	:= Gdip_Startup()
; msgbox % Gdip_GetImageFlags(pBitmap )
; Gdip_SetBitmapToClipboard(pBitmap )
; Gdip_Shutdown(pToken2)
; pImage3:=Gdip_CreateARGBBitmapFromHBITMAP(pimage2:=Gdip_CreateHBITMAPFromBitmap(pImage))
; return,

; gosub,copy_image_data
; pToken2	:= Gdip_Startup()
; msgbox % pBitmap
; hBmp	:= Gdip_CreateHBITMAPFromBitmap(pimage,0)
; Gdip_Shutdown(pToken2)
; Gdip_SetBitmapToClipboard(pimage3,pimage2)
; sleep 499
; DllCall("DeleteObject", "Uint", hBitmap)
; return,

~^c::
gosub,copy_image_data
return

RButton_cooldown_reset:
lbutton_cooldown_reset:
StringTrimRight,resetwhich,a_thislabel,6
(%resetwhich%):= False
return,

LButton_CDReset_3x:
rbutton_cooldown_reset_thrice:
StringTrimRight,resetwhich,a_thislabel,6
loop,3 {
	(%resetwhich%):= False
	settimer,% resetwhich . "_reset",off
	sleep,25
} return,

Reg_Read:
loop,parse,% "ShrinkFill,MaxFill,alignment,recurse,topmost,preserveoffsets,brightness",`,
	regread,  OPT_%a_loopfield%,% r3gk3y, %a_loopfield%
loop,parse,% "netx,nety",`,
	regread,%a_loopfield%,% r3gk3y, %a_loopfield%
return,

Reg_Write:
loop,parse,% Options:= "ShrinkFill,MaxFill,recurse,topmost,preserveoffsets,brightness",`,
	regwrite,% "REG_SZ",% r3gk3y,%a_loopfield%,% OPT_%a_loopfield%
loop,parse,% other:= "netx,nety",`,
	regwrite,% "REG_SZ",% r3gk3y,%a_loopfield%,% %a_loopfield%
return,

GuiClose:
GuiEscape:
sleep,30
exitapp,

Test:
opacity:= 255
DllCall("UpdateLayeredWindow","Uint",hGui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
, "Uint",mdc,"int64P",0,"Uint", 0,"intP",(opacity--)<<16|1<<24,"Uint",2)
win_move(hGui,_nx +1,_ny +1,"","","")
loop,60 {
	(opacity<10? opacity:=10)
	win_move(hGui,_nx+(a_index **2.5),_ny +a_index *2,"","","")
	DllCall("UpdateLayeredWindow","Uint",hGui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
	, "Uint",mdc,"int64P",0,"Uint",0,"intP",(opacity-=6.6)<<16|1<<24,"Uint",2)
} sleep,500
exitapp,

Binds:
#maxhotkeysPerInterval,1440
loop,parse,% keys:= "~wheelup,~wheeldown,~left,~right,~wheelleft,~wheelright,~=,~-,~#r",`,
	hotkey,%a_loopfield%,Labl_Keys
return,

MatrixBrightness(Bright_Percent="85") {
	cp:= 0.05*(pc:=(Bright_percent>1? Bright_percent/100 : Bright_percent))
	return,matrix_:="
	(LTrim Join Comments
	(	" pc "	| 0		| 0		| 0		| 0 	|
		0		|" pc "	| 0		| 0		| 0 	|
		0		| 0		|" pc "	| 0		| 0 	|
		0		| 0		| 0		| 1		| 0 	|
		" cp "	| " cp "| " cp "| 0		| 1 	|
	)"
}

SetForegroundWindow(hWnd) { ;https://msdn.microsoft.com/en-us/library/windows/desktop/ms633539(v=vs.85).aspx
	return,DllCall("SetForegroundWindow", "int", hWnd)
}

IsWindowVisible(hWnd) {
	return,DllCall("IsWindowVisible","Ptr",hWnd)
}

GuiActivate() {
	global HWnd_Pic,hgui,CURRENT_W,CURRENT_H
	gpos:=wingetpos(hgui)
	winanimate(hgui,"hide center",100)
	winset,alwaysontop,on
	winanimate(hgui,"activate center",200)
	win_move(hgui,gpos.x,gpos.y,CURRENT_W,CURRENT_H,0)
		winset,alwaysontop,off
	return,
	if(!IsWindowVisible(hwnd_pic))
			winMinimize,ahk_id %hwnd_pic%
		else,Try,winActivate,ahk_id %hwnd_pic%
}

MenHandla(Enum="") {
	(Enum=""? (A_Thismenuitem? Enum:= A_Thismenuitem : msgb0x("a_thislabel")))
	switch,Enum {
		case,"Preserve Position Characteristics": menu,Tray,icon
		,% (OPT_movecenter:= !OPT_movecenter)? "Move Center":(),% OPT_movecenter? "C:\Icon\256\ticAMIGA.ico":(),,48
		case,"Preserve offsets @ exit"  : menu,Tray,Icon,% "Preserve offsets @ exit"
		,% ((OPT_preserveoffsets:=!OPT_preserveoffsets)? "C:\Icon\256\ticAMIGA.ico": "C:\Icon\48\na_48.ico" ),,48
		case,"65303-65307","65407" : return,MenuPost(a_thislabel) ;PostMessage,0x0111,% (%a_thislabel%),,,% A_ScriptName " - AutoHotkey"
		case,"Open"        : MenuPost(65407)
		case,"Edit Script" : MenuPost(65304)
		case,"Pause"       : MenuPost(65306)
		case,"Suspend VKs" : MenuPost(65305)
		case,"Reload"      : MenuPost(65303)
		case,"Exit"        : MenuPost(65307)
		case,"Open containing" : p:= Open_Containing(ImagePath)
		case,"Copy path" : clipboard:= ImagePath
		case,"Cut " . Image_Title . "." . x10n : invokeverb(ImagePath,"cut")
		case,"Delete" : tt("  Sent-to Recycle-bin  ",1), filerecycle,%ImagePath%
		case,"greyscale" : matrixapply:=true, matrix_:=MatrixGreyScale, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"), matrixapply:=false
		case,"greyscale off" : matrixapply:=true, matrix_:=MatrixGreyScale, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"),greyscale:=true
		case,"greyscale on" : matrixapply:=false, matrix_:="", refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"),greyscale:=false
		case,"sepia" : matrix_:=GenerateColorMatrix(8), matrixapply:=true, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"),matrixapply:=false
		case,"sepia off" : matrixapply:=true, sepia:=true, matrix_:=GenerateColorMatrix(8), refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"),
		case,"sepia on" : matrixapply:=false,sepia:=false, matrix_:="",	refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8")
		case,"alpha2greyscale1" : matrix_:=Matrix_Alpha1, matrixapply:=true, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"),matrixapply:=false
		case,"alpha2greyscale1 off" : matrixapply:=true, alpha2greyscale1:=true, matrix_:=Matrix_Alpha1, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"),
		case,"alpha2greyscale2 on" : matrixapply:=false,alpha2greyscale2:=false, matrix_:="", refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8")
		case,"alpha2greyscale2" : matrix_:=Matrix_Alpha2, matrixapply:=true, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"),matrixapply:=false
		case,"alpha2greyscale2 off" : matrixapply:=true, alpha2greyscale2:=true, matrix_:=Matrix_Alpha2, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8")
		case,"alpha2greyscale2 on" : matrixapply:=false,alpha2greyscale2:=false, matrix_:="", refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8")
		case,"invert" : matrix_:=GenerateColorMatrix(6), matrixapply:=true, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"),matrixapply:=false
		case,"invert off" : matrixapply:=true, invert:=true, matrix_:=GenerateColorMatrix(6), refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8"),
		case,"invert on" : matrixapply:=false,invert:=false, matrix_:="", refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8")
		case,"rotate 90 clockwise" : (rotate=270? (r90cw:=false, r90ccw:=false, rotate:="resetrot") : (r90cw:=true, r90ccw:=false, rotate+=90))
									refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8") ;rotate:=""
		case,"rotate 90 anticlockwise"	: r90ccw:=true, r90cw:=false, rotate-=90, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8") ;rotate:=""
		case,"rotate 180" 			: rotate:=180, refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8")	;rotate:=""
		case,"flip h" 			: rotate:="fliph", refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8")	;rotate:=""
		case,"flip v" 		: rotate:="flipv", refrec(curr_i), Xcrete(oio),Xcrete(oio,"upd8")		;rotate:=""
		case,"Topmost" : settimer,ToglTopmost,-30
		case,"Move" : gosub,DoNothing
		case,"Pin" : gosub,DoNothing
	}	return,
}

TopmostSET(hwnd) {
	return,DllCall("SetWindowPos","uint",hWnd,"uint",-1,"int","","int","","int","","int","","uint",16388)
}

MenuPost(wMsgEnum="") {	;PostMessage,0x0111,% wMsgEnum,,,% A_ScriptName " - AutoHotkey"
	return,DllCall("PostMessage","Ptr",a_scripthwnd,"UInt",0x0111,"int",wMsgEnum,"int",0)
}

AHK_NOTIFYICON(wParam,lParam) {
	switch,lParam {	;0x0206:;WM_RBUTTONDBLCLK; 0x020B:;WM_XBUTTONDOWN 0x0202:;WM_LBUTTONUP
		case,0x122 : tt("Mein kampf")
		case,0x0203 : settimer,GuiActivate,-10
		case,0x0208 : fn:= func(MenuPost).bind(65303)
			settimer,% fn,-10
		case,0x0208 : tt("Reloading...","tray",1)
		case,0x0204 : settimer,MenuTrayShow,-10
		case,0x0205 : tt("sssssssssssssss") ;MenuTrayShow() ;WM_RBUTTONUP-0x0204	;return,1
	} return,
}

TOP_PreCheckInit: ;Pre-Toggle
(OPT_Topmost!=""? OPT_Topmost:=!OPT_Topmost)
ToglTopmost: ;DllCall("SetWindowBand","ptr",hGui,"ptr",0,"uint",15,"uint")
if(OPT_Topmost:=!OPT_Topmost) { ;uiband_set(hGui)
	WinSet,Top,,ahk_id %hgui%
	WinSet,AlwaysOnTop,On,ahk_id %hgui%
} else,WinSet,AlwaysOnTop,Off,ahk_id %hgui%
return, ;WinSet,Top,off,ahk_id %hgui%

File_2_pBMP(Image) { ;Faster than GdipCreateBitmapFromFile *doesn't lock file.;
	pStream:= FileGet(Image)
	DllCall("gdiplus\GdipCreateBitmapFromStream","ptr",pStream,"ptr*",pBitmap:= 0)
	ObjRelease(pStream)
	return,pBitmap
} FileGet(Image) {
	File:= FileOpen(Image, "r")
	hData:= DllCall("GlobalAlloc","uint",0x2,"uptr",File.Length,"ptr")
	pData:= DllCall("GlobalLock","ptr",hData,"ptr")
	File.RawRead(pData+0,File.Length)
	DllCall("GlobalUnlock","ptr",hData)
	File.Close()
	DllCall("ole32\CreateStreamOnHGlobal","ptr",hData,"int",True,"ptr*",pStream:=0,"uint")
	return,pStream
}

BitmapToPng(hBitmap, destPngFilePath) {
	static CLSID_WICImagingFactory  := "{CACAF262-9370-4615-A13B-9F5539DA4C0A}"
			, IID_IWICImagingFactory  := "{EC5EC8A9-C395-4314-9C77-54D7A935FF70}"
			, GUID_ContainerFormatPng := "{1B7CFAF4-713F-473C-BBCD-6137425FAEAF}"
			, WICBitmapUseAlpha := 0x00000000, GENERIC_WRITE := 0x40000000
			, WICBitmapEncoderNoCache := 0x00000002
	VarSetCapacity(GUID, 16, 0)
	DllCall("Ole32\CLSIDFromString", "WStr", GUID_ContainerFormatPng, "Ptr", &GUID)
	IWICImagingFactory := ComObjCreate(CLSID_WICImagingFactory, IID_IWICImagingFactory)
	; IWICImagingFactory::CreateBitmapFromHBITMAP
	DllCall(NumGet(NumGet(IWICImagingFactory + 0) + A_PtrSize*21), "Ptr", IWICImagingFactory, "Ptr", hBitmap, "Ptr", 0, "UInt", WICBitmapUseAlpha, "PtrP", IWICBitmap)
	; IWICImagingFactory::CreateStream
	DllCall(NumGet(NumGet(IWICImagingFactory + 0) + A_PtrSize*14), "Ptr", IWICImagingFactory, "PtrP", IWICStream)
	; IWICStream::InitializeFromFilename
	DllCall(NumGet(NumGet(IWICStream + 0) + A_PtrSize*15), "Ptr", IWICStream, "WStr", destPngFilePath, "UInt", GENERIC_WRITE)
	; IWICImagingFactory::CreateEncoder
	DllCall(NumGet(NumGet(IWICImagingFactory + 0) + A_PtrSize*8), "Ptr", IWICImagingFactory, "Ptr", &GUID, "Ptr", 0, "PtrP", IWICBitmapEncoder)
	; IWICBitmapEncoder::Initialize
	DllCall(NumGet(NumGet(IWICBitmapEncoder + 0) + A_PtrSize*3), "Ptr", IWICBitmapEncoder, "Ptr", IWICStream, "UInt", WICBitmapEncoderNoCache)
	; IWICBitmapEncoder::CreateNewFrame
	DllCall(NumGet(NumGet(IWICBitmapEncoder + 0) + A_PtrSize*10), "Ptr", IWICBitmapEncoder, "PtrP", IWICBitmapFrameEncode, "Ptr", 0)
	; IWICBitmapFrameEncode::Initialize
	DllCall(NumGet(NumGet(IWICBitmapFrameEncode + 0) + A_PtrSize*3), "Ptr", IWICBitmapFrameEncode, "Ptr", 0)
	; IWICBitmapFrameEncode::WriteSource
	DllCall(NumGet(NumGet(IWICBitmapFrameEncode + 0) + A_PtrSize*11), "Ptr", IWICBitmapFrameEncode, "Ptr", IWICBitmap, "Ptr", 0)
	; IWICBitmapFrameEncode::Commit
	DllCall(NumGet(NumGet(IWICBitmapFrameEncode + 0) + A_PtrSize*12), "Ptr", IWICBitmapFrameEncode)
	; IWICBitmapEncoder::Commit
	DllCall(NumGet(NumGet(IWICBitmapEncoder + 0) + A_PtrSize*11), "Ptr", IWICBitmapEncoder)
	for k, v in [IWICBitmapFrameEncode, IWICBitmapEncoder, IWICStream, IWICBitmap, IWICImagingFactory]
		ObjRelease(v)
}

onMsgs:
onExit,Leave_
onmessage(0x0404,"AHK_NOTIFYICON")
onmessage(0x0204,"WM_rBUTTONdown")
onmessage(0x0205,"WM_rBUTTONup")
onmessage(0x0201,"WM_LrBUTTONDOWN")
onmessage(0x0202,"WM_LrBUTTONUP")
onmessage(0x0526,"wmmwheel")
onmessage(0x0522,"wmmwheel")
onmessage(0x0101,"WM_KEYUP")
onmessage(0x0122,"MenuRButtUp")
onmessage(0x0047,"moved")
onmessage(0x0203,"WM_LBUTTONDBLCLK") ; onmessage(0x00A1,"WM_NCLBUTTONDOWN")
return,

GuiMenu() {
	global
	try,menu,new,deleteall
	menu,new,add,Topmost,MenHandla
	menu,new,icon,Topmost,% OPT_topmost? "C:\Icon\48\pin_48.ico" : "C:\Icon\48\move_48.ico",,48
	menu,NewSubMen_Pin,add,Pin to other window,MenHandla
	menu,NewSubMen_Pin,add,Pin to desktop,MenHandla
	menu,NewSubMen_Pin,add,Pin to desktop Perm,MenHandla
	menu,new,add,Open containing,MenHandla
	menu,new,icon,Open containing,% "C:\Icon\48\EXPLORER_48.ico",,48
	menu,new,add,Copy path,MenHandla
	menu,new,icon,Copy path,% "C:\Icon\48\copy248.ico",,48
	menu,new,add,% _:= "Cut " . quote(Image_Title . "." . x10n),MenHandla
	menu,new,icon,% _,% "C:\Icon\48\ss_48.ico",,48
	menu,new,add,Delete ,MenHandla
	menu,new,icon,Delete,% "C:\Icon\ICON54_1.ico",,48
	menu,new,add,Move,MenHandla
	menu,new,icon,Move,% "C:\Icon\48\move_48.ico",,48
	menu,new,add,Pin,:NewSubMen_Pin
	menu,new,add,Pin,MenHandla
	menu,new,icon,Pin,% "C:\Icon\48\pin_48.ico",,48
	menu,NewSubMen_colm,add,Greyscale,MenHandla
	menu,NewSubMen_colm,add,invert,MenHandla
	menu,NewSubMen_colm,add,sepia,MenHandla
	menu,NewSubMen_colm,add,alpha2greyscale1,MenHandla
	menu,NewSubMen_colm,add,alpha2greyscale2,MenHandla
	menu,new,add,Colour Management,:NewSubMen_colm
	menu,new,icon,Colour Management,% "C:\Icon\48_24\Gradcolorwheel4824.ico",,48
	menu,NewSubMen_rot,add,rotate 90 clockwise,MenHandla
	menu,NewSubMen_rot,add,rotate 90 anticlockwise,MenHandla
	menu,NewSubMen_rot,add,rotate 180,MenHandla
	menu,NewSubMen_rot,add,flip h,MenHandla
	menu,NewSubMen_rot,add,flip v,MenHandla
	menu,new,add,Rotation,:NewSubMen_rot
	menu,new,icon,Rotation,C:\Icon\48_24\86_24824.ico,,48
	menu,new,add,Exit,MenHandla
	menu,new,icon,Exit,C:\Icon\48\xray_(total-recall)_48 (2).ico,,48
	Menu,new,Show
}

MenuTrayShow() {
	global
	trayActiv:= True
	gosub,menus
	Menu,Tray,Show
	trayActiv:= False
}

menus:
menu,Tray,deleteall
menu,Tray,NoStandard
menu,Tray,icon,% "C:\Script\AHK\z_ConTxt\imag3view4.ico"
menu,Tray,Add,% "Open",MenHandla
menu,Tray,Icon,% "Open",% "C:\Icon\24\Gterminal_24_32.ico",,48
menu,Tray,Add,% "preserve position characteristics",MenHandla
menu,Tray,icon,% "Preserve Position Characteristics",% (OPT_movecenter? "C:\Icon\256\ticAMIGA.ico" : "C:\Icon\48\na_48.ico"),,48
menu,Tray,Add,% "Preserve offsets @ exit",MenHandla
menu,Tray,Icon,% "Preserve offsets @ exit",% (OPT_preserveoffsets? "C:\Icon\256\ticAMIGA.ico" : "C:\Icon\48\na_48.ico" ),,48
menu,Tray,add,Topmost,MenHandla
menu,Tray,icon,Topmost,% OPT_topmost? "C:\Icon\48\pin_48.ico" : "C:\Icon\48\move_48.ico",,48
if(!A_IsCompiled) {
	menu,Tray,Add,% "Edit Script",MenHandla
	menu,Tray,Icon,% "Edit Script",% "C:\Icon\24\explorer24.ico",,48
}
menu,Tray,add,% _:=(greyscale? "Greyscale on" : "Greyscale off"),MenHandla
menu,Tray,Icon,% _,% r_:=(greyscale? "C:\Icon\256\ticAMIGA.ico" : "C:\Icon\24\explorer24.ico"),,48
menu,Tray,add,% _:=(sepia? "sepia on" : "sepia off"),MenHandla
menu,Tray,Icon,% _,% r_:=(sepia? "C:\Icon\256\ticAMIGA.ico" : "C:\Icon\24\explorer24.ico"),,48
menu,Tray,add,% _:=(alpha2greyscale1? "alpha2greyscale1 on" : "alpha2greyscale1 off"),MenHandla
menu,Tray,Icon,% _,% r_:=(alpha2greyscale1? "C:\Icon\256\ticAMIGA.ico" : "C:\Icon\24\explorer24.ico"),,48
menu,Tray,add,% _:=(alpha2greyscale2? "alpha2greyscale2 on" : "alpha2greyscale2 off"),MenHandla
menu,Tray,Icon,% _,% r_:=(alpha2greyscale2? "C:\Icon\256\ticAMIGA.ico" : "C:\Icon\24\explorer24.ico"),,48
menu,Tray,add,% _:=(invert? "invert on" : "invert off"),MenHandla
menu,Tray,Icon,% _,% r_:=(invert? "C:\Icon\256\ticAMIGA.ico" : "C:\Icon\24\explorer24.ico"),,48
menu,Tray,Add,% "Reload",		MenHandla
menu,Tray,Icon,% "Reload",%		"C:\Icon\24\eaa.bmp",,48
menu,Tray,Add,% "Suspend VKs",	MenHandla
menu,Tray,Icon,% "Suspend VKs",% "C:\Icon\24\head_fk_a_24_c1.ico",,48
menu,Tray,Add,% "Pause",		MenHandla
menu,Tray,Icon,% "Pause",%		"C:\Icon\24\head_fk_a_24_c2b.ico",,48
menu,Tray,Add,% "Exit",			MenHandla
menu,Tray,Icon,% "Exit",%		"C:\Icon\24\head_fk_a_24_c2b.ico",,48
return,

Varz:
global hgui,Xcret10ninit,Image_Title,ImagePath,x10n,CURRENT_H,CURRENT_W,Pwner,OPT_allCenter,pic_arr,Options,hovered,OWin,OControl,hGui,hovered,RECT,mdc,lbutton_click_thresh,rbutton_cooldown,OPT_topmost,Starting_file,OutNameNoExt,_i_ndx_,Max_i,Curr_i,Curr_iOLD1,Curr_iOLD2,Options,pic0,pic1,pic2,xcent,ycent,hi,wi,OPT_recurse,OPT_MaxFill,OPT_ShrinkFill:=true,alignment,ren,hovered,keys,_nx:=0,_ny:=0,_Netnx:=0,_Netny:=0,netnxold,netnyold,netxt,netyTemp,netx,nety,OPT_Anchor,fTypes,keys,STrigga,_s:=" - ",OPT_preserveoffsets,exit,matrixapply,matrix_,OPT_brightness
, r3gk3y:="HKCU\SOFTWARE\_MW\image_view",ID_VIEW_VARIABLES:=65407,ID_TRAY_EDITSCRIPT:=65304,ID_TRAY_SUSPEND:=65305,ID_TRAY_PAUSE:=65306.ID_TRAY_EXIT:=65307,ID_TRAY_RELOADSCRIPT:=65303,ndk,copy
;, OPT_movecenter:= True ;testing
, greyscale, sepia, alpha2greyscale,invert,Matrix_Alpha1,Matrix_Alpha2,rotate:=0,r90cw,r90ccw,r180
, MatrixNegative:= "-1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|1|1|1|0|1"
, MatrixGreyScale:= "0.299|0.299|0.299|0|0|.587|.587|.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1"

Matrix_Alpha1:= " 0| 0 | 0 | 0 | 0 "
			. "| 0 | 0 | 0 | 0 | 0 "
			. "| 0 | 0 | 0 | 0 | 0 "
			. "|-.7| 0 |-.3| 25| 1 "
			. "|0.6|0.3|0.8|.25| 0 "

Matrix_Alpha2:= " 0| 0 | 0 | 0 | 0 "
			. "| 0 | 0 | 0 | 0 | 0 "
			. "| 0 | 0 | 0 | 0 | 0 "
			. "|-.5|-.5|-.5| 25| 1 "
			. "|.5 |.5 |.5 | 0 | 0 "

Matrix_Alpha3 :=( "1|0	|0	|0	|0|"
.				"0 	|1	|0	|0	|0|"
.				"0	|0	|1	|0	|0|"
.				"0	|0	|0	|1	|0|"
.				"0	|0	|0	|0	|1 ")

VarSetCapacity(RECT,16)

if(!ImagePath&&!FileExist(ImagePath:=A_AppData "\" ScriptName "\appifyerFrame.png"))
	ImagePath:= remoteResource("appifyerFrame.png", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Modern_AutoHotkey_Logo_%28no_text%29.svg/330px-Modern_AutoHotkey_Logo_%28no_text%29.svg.png")

DoNothing:
return,

Leave_:
gosub,reg_WRite
Gdip_shutdown(ptoken)
WinAnimate(hgui,"hide center",120)
try,{ gui,pic:	 hide
	  gui,Pwner: hide
	  gui,Pic:	 destroy
	  gui,Pwner: destroy
}
exitapp,
loop,4
	sleep,222