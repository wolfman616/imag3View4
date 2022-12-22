#NoEnv 
#NoTrayIcon
#SingleInstance,Force
#IfTimeout,200 ;* DANGER *: Performance impact if set too low. *think about using this*.
PiD:= DllCall("GetCurrentProcessId")
;(imgv_instance:= winexist("imgvi3w4 ahk_class AutoHotkeyGUI",,"ahk_pid " . PID)? exitapp())
; if (!instr(A_AhkPath,"UIA")&&!A_IsCompiled) {
	; run,%A_AhkPath%\..\AutoHotkeyU64_UIA.exe "%A_ScriptFullPath%" "%1%"
	; exitApp,
; }
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
 %0% ? ImagePath:= A_Args[1] : ()
loop,parse,% "Varz,Reg_Read,Menus,Binds,opt_enact",`,
	gosub(A_loopfield)
onexit,Leave_
onmessage(0x0204,"WM_lRBUTTONDOWN")
onmessage(0x0205,"WM_lrBUTTONUP")
onmessage(0x0201,"WM_LrBUTTONDOWN")
onmessage(0x0202,"WM_LrBUTTONUP")
onmessage(0x0404,"AHK_NOTIFYICON")
onmessage(0x00A1,"WM_NCLBUTTONDOWN")
onmessage(0x0101,"WM_KEYUP")

opt_Anchor:= True ; anchor session to position last used.
ftypes:=[]
ftypes:= ["png","jpg","jpeg","jfif","gif","bmp","ico","xcf","tiff","cur","ani","webp"]

keys:= "~wheelup,~wheeldown,~left,~right,~wheelleft,~wheelright,~=,~-,~#r"

hotkey,~escape,guiescape,on
main(ImagePath)
return,

Main(Path2Pic1) {
	Curr_i:= Xcrete("","Preparse","",Path2Pic1)
	Xcrete(Curr_i) ; Xcrete( Curr_i - 1) ; Xcrete( Curr_i + 1)
	Xcrete(Curr_i,"upd8")
	return,
}

Xcrete(i="",lab3l="",h_key="",inp4th="") {
	global
	if !Xcret10n {
		keys:= "~wheelup,~wheeldown,~wheelleft,~wheelright,~=,~-,~#r"
		loop,parse,keys,`,
			hotkey,% a_loopfield,keys_labl,on
		Xcret10nnit:= True
	}
	if(lab3l) {
		goto,% lab3l
		return,
	} else,try {
		critical
		OPT_Benchmark? a_scriptStartTime:= a_tickCount : ()
		gui,pic: New,-DPIScale +ParentPwner +AlwaysOnTop +ToolWindow +E0x80000
		gui,pic: +LastFound -Caption -SysMenu +OwnDialogs
		hwnd_pic:= WinExist(), Curr_File:= pic_arr[oio:=i].CurrPath
		pToken:= Gdip_Startup(), sdr:=(x10n="ico"?6:"")
		try,pBitmap:= Gdip_CreateBitmapFromFile(Curr_File,sdr)
		opt_greyscale:= True
		
		CURRENT_W:=	Gdip_GetImageWidth( pBitmap)
	 	CURRENT_H:=	Gdip_GetImageHeight(pBitmap)
		(current_w=16? pBitmap:= Gdip_CreateBitmapFromFile(Curr_File,"",CURRENT_W:=CURRENT_H:=256))
		pImage:= Gdip_CreateBitmap(CURRENT_W *wscale:= 1
		, CURRENT_H *hscale:= 1) 

		G2:= Gdip_GraphicsFromImage(pImage)
		Gdip_DrawImage(G2,pBitmap,0,0,CURRENT_W *wscale
		,CURRENT_H *hscale,0,0,CURRENT_W,CURRENT_H)
		Gdip_SetInterpolationMode(G2,1)
		Gdip_SetSmoothingMode(G2,1)
		if (x10n="ico")
			goto,DC_stuff
		else,if opt_MaxFill || if opt_ShrinkFill
			goto,shrinkxpand
		else,if(CURRENT_W>a_screenwidth && CURRENT_H>a_screenheight)
			goto,shrinkxpand
		else,goto,DC_stuff
			return,
;-------------------------------------------------------------------
		shrinkXpand:
		rw:= (a_screenwidth /(CURRENT_W)), rh:= (a_screenheight/(CURRENT_H))
		CURRENT_H:= rw<rh? floor(rw*(CURRENT_H)) : a_screenheight
		CURRENT_W:= rw<rh? a_screenwidth : floor(rh*(CURRENT_W))
		hi:= ("h" . round(CURRENT_H)), wi:= ("w" . round(CURRENT_W))

		DC_stuff:
		mDC:=	Gdi_CreateCompatibleDC(0)
		mBM:=	Gdi_CreateDIBSection((mDC),CURRENT_W,CURRENT_H,32)
		;(opt_greyscale? mBM:= GDI_GrayscaleBitmap(mBM2))
		oBM:=	Gdi_SelectObject(mDC, mBM)
		pG_:=	Gdip_CreateFromHDC(mDC)
		try,Gdip_DrawImageRECTI(pG_,pImage,0,0,CURRENT_W,CURRENT_H)
		opt_zpostopmost:= true ;testing
		opt_zpostopmost? gui_zpos:= "+AlwaysOnTop" : gui_zpos:= ""
		opt_noactiv8:= false ;testing
		opt_noactiv8? gui_noactiv8:= "NA" : gui_noactiv8:= ""
		opt_posallCenter:= true ;testing
		opt_posallCenter? gui_pos := "Center" : ()
		gui,Pwner:-Caption %gui_zpos%
		return,

		inratio:
		loop,
			if((CURRENT_H*a_index)>a_screenheight ) {
				multipliera:= a_index -1
				break,
			}
		loop,
			if((CURRENT_H*a_index)>a_screenwidth ) {
				multiplierb:= a_index -1
				break,
			}
		result:= (multipliera<multiplierb) ? multipliera : multiplierb
		old_H:= CURRENT_H, old_W:= CURRENT_W
		hi:= ("h" .	round(CURRENT_H*=result) ) ; hi:=  ("h" . round(CURRENT_H))
		wi:= ("w" .	round(CURRENT_W*=result) ) ; wi:=  ("w" . round(CURRENT_W))
	}
	return,

	Preparse:
	pic_arr:= {}, xcent:= (a_screenwidth *.5), ycent:= (a_screenheight *.5)
	SplitPath,inp4th,Starting_file,Image_dir,x10n,Image_Title
	setWorkingDir,% Image_dir
	Recurse:= "R",	Paths:= ""
	gui,	Pwner:New,,% "imgvi3w4"
	gui,	Pwner:+LastFound -Caption -DPIScale +ToolWindow +E0x80000 +HWNDhGui  ; hGui := WinExist()
	Loop,	Files,% Image_dir "\*.*",% Recurse
	{	; Trim(A_LoopFileFullPath) "'"
		targetpath:= LTrim(A_LoopFileFullPath)
		if(targetpath:= RTrim(targetpath)) {
			SplitPath,A_LoopFileFullPath,,,xTnz0n
					switch,xTnz0n {
						case ftypes[1],ftypes[2],ftypes[3],ftypes[4],ftypes[5],ftypes[6],ftypes[7],ftypes[8],ftypes[9]:
							pic_arr[ a_index ]:= ({"CurrPath" : A_LoopFileFullPath : "xtn" : xTnz0n })
							 if(A_LoopFileFullPath=inp4th)
								  oio:= a_index
					}
				Max_i:= a_index
		} else,msgbox,error
	}
	(!Max_i? msgb0x("Error!", "Error no max`n:("))
	return,oio
	
	upd8:
	if((_netnx>a_screenwidth)&&(_netny>a_screenheight))
		_Netnx:=0, _Netny:=0
	gpos:= wingetpos(hgui)
	(netx? netxold2:= netx), (nety?netyold2:= nety)
	(!(_nx-gpos.x=0)? netx:= _nx-gpos.x)
	(!(_ny-gpos.y=0)? nety:= _ny-gpos.y)
	_nxold:=_nx, _nyold:=_ny, CURRENT_W_old:= CURRENT_W, CURRENT_h_old:= CURRENT_H
	_nx:= round(xcent-(CURRENT_W*0.5)), _ny:= round(ycent-(CURRENT_H*0.5)) ; center alignment
	if(opt_movecenter) {
		 _nx -=Netx
		(_nx>a_screenwidth-CURRENT_W)? _nx:=a_screenwidth-CURRENT_W
		(_nx<0? _nx:=0)
		_ny -=Nety
		(_ny>a_screenheight-CURRENT_h)? _ny:=a_screenheight-CURRENT_h
		(_ny<0? _ny:=0)
	}
	
	DllCall("UpdateLayeredWindow","Uint",hGui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
	,"Uint",mDC,"int64P",0,"Uint",0,"intP",0xFF<<16|1<<24,"Uint",2) ;msgbox % _nx " " _nY
	gui,Pwner: Show,%gui_noactiv8% x%_nx% y%_ny% w%CURRENT_w% h%CURRENT_H%
	;(OPT_BENCHMARK? _:= (a_tickCount-a_scriptStartTime) . " Ms", TT(_))

	delete:
	GDI_SelectObject(mDC,oBM)
	Gdi_DeleteObject(mBM) ; Gdi_DeleteDC(mDC)
	Gdip_DeleteGraphics(g2)
	Gdip_DisposeImage(pImage)
	Gdip_DisposeImage(pbitmap)
	return,

	old_delete:
	gui,pic:destroy
	Gdip_Shutdown(pToken)
	return,

	keys_lablL:
	MouseGetPos,,,OWin,OControl ; 1|2|3
	((OWin=hGui)? hovered:= True : (hovered:= False))
	(!h_key? msgb0x("error"))
	(instr(h_key,"~")? h_key:= strreplace(h_key,"~") : (h_key:= h_key))
	iOLD2:= iOLD1, iOLD1:= oio
	ifwinNotActive,ahk_id %hGui%
		&& if(!hovered)
			return,
		switch,h_key {
		case,"=" : opt_MaxFill:=!opt_MaxFill
			(opt_MaxFill? nety? (netyTemp:= nety,nety := 0) :
			, (netyTemp?nety:= netyTemp)) ;keeps x offset when maximized
		case,"-" : opt_ShrinkFill:=!opt_ShrinkFill
		                                                                                                                                                
			switch,mag {
				case,"7" : SizeWin("x6")
				case,"6" : SizeWin("x5")
				case,"5" : SizeWin("x4")
				case,"4" : SizeWin("x3")
				case,"3" : SizeWin("x2")
			}
			
		; case,"right","wheeldown" : critical
		case,"wheeldown" : refrec(curr_i+=1) ;curr_i:= (oio<Max_i? oio += 1 : oio:= 1)
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
	}
	; switch,pic_arr[oio].xtn {
		; case "ico"		:	tt("ico file",3000)
		; case "gif"		:	tt("gif file",3000)
		; case "default"	:	tt(pic_arr[oio].xtn " file.")
	; }
	Xcrete(oio)
	Xcrete(oio,"upd8")
	(!(iold2=oio)? Xcrete(iOLD2,"old_delete"))
	return,
}

sizewin(sZ,hWn="",center="") {
	static MidX:= a_screenwidth *.5, MidY:= a_screenheight *.5
	,HAg_Tsk:= A_screenheight -54
	siZ:= sZ, (hWn=""?hWn:= WinExist("A"))	;(instr(sZ,"center"))? sZ:= strreplace(sZ,"center",""):()
	;(!(center="")? Center:= True)
	try,WActive:= wingetpos(hWn)
	if(!WActive)
		msgb0x("add")
;	winminimize,ahk_id %hWn%
;	winrestore,ahk_id %hWn%
	WActive.w-=12, WActive.h-=46
	switch,sZ {
		case,"quad","x4": (((WActive.h*4)<HAg_Tsk)
			?	(CURRENT_W *=4, CURRENT_H *=4, mag++)
			:	retval:= "x3")
			(retval?sizewin(retval,hWn):0)
			
		case,"triple","x3": (((WActive.h*3)<HAg_Tsk)
			?	(CURRENT_W *=3, CURRENT_H *=3, mag++)
			:	retval:= "x2")
			(retval?sizewin(retval,hWn):0)
		case,"double","x2","2/1" : (((WActive.h*3)<HAg_Tsk)
			?	(CURRENT_W *=3, CURRENT_H *=3, mag++)
			:	retval:= "1/2")
			(retval?sizewin(retval,hWn):0)
		case,"halve","half","1/2": (CURRENT_W *=0.5, CURRENT_H *=0.5, mag--)
		case,"+10%" : win_move(hWn,WActive.X,WActive.Y,(WActive.W*1.1)+12,(WActive.H*1.1)+46,"")
		case,"-10%" : win_move(hWn,WActive.X,WActive.Y,(WActive.W*0.9)+12,(WActive.H*0.9)+46,"")
		case,"+50%" : win_move(hWn,WActive.X,WActive.Y,round(WActive.W*1.5)+12,round(WActive.H*1.5)+46,"")
		case,"-33%" : win_move(hWn,WActive.X,WActive.Y,round(WActive.W*0.777)+12,round(WActive.H*0.777)+46,"")
	}
	ratio_Longest:= (WActive.W>WActive.H
	? "Landscape" . ratio_Longest:= WActive.H/WActive.W
	: "portrait" . ratio_Longest:= WActive.W/WActive.H)
	loop,{
		 ((Accuracy:= (raw:= a_index *(1/ratio_Long)) -(rounded:= round(raw)))
		, < 0.05? denominator:= a_index, msgb0x("demoninatoir: " a_index "`nacc: " Accuracy))
		if(denominator||(a_index>20))
			return,(Denomintator? Denomintator:0)
	}	
}
WM_lrBUTTONDOWN(wParam,lParam,byref RECT,mDC) {
	global lbutton_cooldown, lbd, STrigga:= true	; tt("LB: D")
	xs:= lParam &0xffff,	ys:= lParam>>16
	pToken00:= Gdip_Startup() ; msgbox % mDC
	   mDC00:= Gdi_CreateCompatibleDC(0)
	DllCall("gdi32.dll\SetStretchBltMode","Uint",mDC,"int",1)
	DllCall("gdi32.dll\StretchBlt","UInt",mDC00,"Int",0,"Int",0,"Int"
	, CURRENT_W,"Int",CURRENT_h,"UInt",mDC%oio%,"UInt",0 ;SRCCOPY=0x00CC0020
	, "UInt",0,"Int",0.5*CURRENT_W,"Int",CURRENT_h,"UInt",0x00CC0020)
	DllCall("UpdateLayeredWindow","Uint",hGui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
	, "Uint",mDC00,"int64P",0,"Uint",0,"intP",0xFF<<16|1<<24,"Uint",2)
	settimer,disgrace,-40
	timer("lbutton_cooldown_reset",-400)
	While(LbD:= GetKeyState("lbutton","P")||lbd:= GetKeyState("lbutton","P")) {
		DllCall("GetCursorPos","Uint",&RECT)
		sl33p()
		win_move(hgui,(NumGet(&RECT,0,"Int")-xs),(NumGet(&RECT,4,"Int") -ys),CURRENT_W,CURRENT_H,0x4001) ; DllCall("MoveWindow",  "Uint",hwnd1,"int",vWinX,"int",vWiny,"int",rw,"int",rh,"Int",2) #
		if(STrigga)
			settimer,grace,-400
		if(!lbd){
			settimer,WM_lrBUTTONup,-150
			return,0
	}	}
	grace:
	disgrace:
	(instr(a_thislabel,"dis")? STrigga:= false : STrigga:= true)
	return,
}

WM_lrBUTTONup(wParam="",lParam="") { 	;toggles maximise fill
	global STrigga, LbD:=""
	if !STrigga {
		settimer,GuiMenu,-1
		return,
}	}

WM_LBUTTONDBLCLK(wParam,lParam,byref RECT,mDC) {
	global lbutton_cooldown_reset,oio,Curr_File
	if !lbutton_cooldown_reset {
		opt_MaxFill:=!opt_MaxFill, main(Curr_File)
		return,
	}
	opt_MaxFill:=!opt_MaxFill, main(Curr_File), tt("LB: U")
}

WM_RBUTTONDOWN(byref wParam,byref lParam,byref RECT) {
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

WM_NCLBUTTONDOWN(byref wParam="",byref lParam="") {
	;tt("GA")
}

WM_rBUTTONup(byref wParam="",byref lParam="") {
	global Curr_File,rbutton_cooldown
	OpenContaining(Curr_File)
	settimer,rbutton_cooldown_reset,-1
	(rbutton_cooldown="")? rbutton_cooldown:= false : ()
		send,{rbutton up}
}

WM_KEYUP(wParam,lParam) {
	global hWnd_Par
	switch,wParam {
		case "37"	: curr_i:= refrec(-1) ;left arrow
						
		case "39"	: curr_i:= refrec(1) ;r arrow
		case "27 "	: settimer,guiclose,-1 ;esc
		case "13"	: gui,par:submit,nohide ;enter
						send,{tab} ;gosub,editx ;gosub,edity ;gosub,Timertest2
		;default		: ;tt(wParam "`n" Format("{1:#x}",lParam))  ; case "":
}	}

refrec(byref _i="") {
	global
	((curr_i<1)? _i:= Max_i : ((curr_i>Max_i)? _i:= 1))
	,Xcrete(_i),sl33p(), Xcrete(oio,"upd8") 
	,(!(iold2=oio)?Xcrete(iOLD2,"old_delete"))
}

keys_labl:
Xcrete(Curr_i,(a_thislabel . "L"),a_thishotkey)
return,

opt_enact:
if opt_movecenter
	menu,Tray,icon,% "preserve position characteristics",% "C:\Icon\256\ticAMIGA.ico" 
else,menu,Tray,icon,% "preserve position characteristics",% ""
return,

CreateHBITMAPFromBitmap(pBitmap, Background:=0xffffffff) {
; background should be zero, to not alter alpha channel of the image
	hBitmap := 0
	If !pBitmap
	{
		gdipLastError := 2
		Return
	}

	gdipLastError := DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "UPtr", pBitmap, "UPtr*", hBitmap, "int", 0)
	return hBitmap
}

SetClipboardData(nFormat, hBitmap) {
	DllCall("GetObject", "Uint", hBitmap, "int", VarSetCapacity(oi,84,0), "Uint", &oi)
	hDBI :=	DllCall("GlobalAlloc", "Uint", 2, "Uint", 40+NumGet(oi,44))
	pDBI :=	DllCall("GlobalLock", "Uint", hDBI)
	DllCall("RtlMoveMemory", "Uint", pDBI, "Uint", &oi+24, "Uint", 40)
	DllCall("RtlMoveMemory", "Uint", pDBI+40, "Uint", NumGet(oi,20), "Uint", NumGet(oi,44))
	DllCall("GlobalUnlock", "Uint", hDBI)
	DllCall("OpenClipboard", "Uint", 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "Uint", nFormat, "Uint", hDBI)
	DllCall("CloseClipboard")
}

rbutton_cooldown_reset:
lbutton_cooldown_reset:
StringTrimRight,resetwhich,a_thislabel,6
(%resetwhich%):= False
return,

lbutton_cooldown_reset_thrice:
rbutton_cooldown_reset_thrice:
StringTrimRight,resetwhich,a_thislabel,6
loop,3 {
	(%resetwhich%):= False
	settimer,% resetwhich . "_reset",off
	sleep,25
}
return,

reg_read:
loop,parse,% "opt_ShrinkFill,opt_MaxFill,alignment,recurse",`,
	regread, %a_loopfield%,% r3gk3y,  %a_loopfield%
return,

reg_WRite:
alignment:="center"
loop,parse,% Options:= "opt_ShrinkFill,opt_MaxFill,alignment,recurse",`,
	regwrite,% "REG_SZ",% r3gk3y,%a_loopfield%,% %a_loopfield%
return,

~escape::
GuiEscape:
GuiClose:
exitapp,

GDI_GrayscaleBitmap( hBM ) {               ; Converts GDI bitmap to 256 color GreyScale

; www.autohotkey.com/community/viewtopic.php?t=88996    By SKAN,  Created : 19-Jul-2012

 Static RGBQUAD256  



 If ! VarSetCapacity( RGBQUAD256 ) {

      VarSetCapacity( RGBQUAD256, 256*4, 0 ),  Color := 0

      Loop 255

           Numput( Color := Color + 0x010101, RGBQUAD256, A_Index*4, "UInt" )

 }


 VarSetCapacity( BM,24,0 ),  DllCall( "GetObject", UInt,hBM, UInt,24, UInt,&BM )

 W := NumGet( BM,4 ), H := NumGet( BM,8 )

 hdcSrc := DllCall( "CreateCompatibleDC", UInt,0 )

 hbmPrS := DllCall( "SelectObject", UInt,hdcSrc, UInt,hBM )



 dBM := DllCall( "CopyImage", UInt

      , DllCall( "CreateBitmap", Int,2, Int,2, UInt,1, UInt,8, UInt,0 )

      , UInt,0, Int,W, Int,H, UInt,0x2008, UInt )



 hdcDst  := DllCall( "CreateCompatibleDC", UInt,0 )

 hbmPrD  := DllCall( "SelectObject", UInt,hdcDst, UInt,dBM )

 DllCall( "SetDIBColorTable", UInt,hdcDst, UInt,0, UInt,256, UInt,&RGBQUAD256 )



 DllCall( "BitBlt", UInt,hdcDst, Int,0, Int,0, Int,W, Int,H

                  , UInt,hdcSrc, Int,0, Int,0, UInt,0x00CC0020 )



 DllCall( "SelectObject", UInt,hdcSrc, UInt,hbmPrS )

 DllCall( "DeleteDC",     UInt,hdcSrc )

 DllCall( "SelectObject", UInt,hdcSrc, UInt,hbmPrD )

 DllCall( "DeleteDC",     UInt,hdcDst )



Return dBM

}

opacity:= 255
DllCall("UpdateLayeredWindow","Uint",hGui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
, "Uint",mdc,"int64P",0,"Uint", 0,"intP",(opacity--)<<16|1<<24,"Uint",2)
win_move(hGui,_nx +1,_ny +1,"","","")
loop,60 {
	(opacity<10? opacity:=10)
	win_move(hGui,_nx+(a_index **2.5),_ny +a_index *2,"","","")
	DllCall("UpdateLayeredWindow","Uint",hGui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
	, "Uint",mdc,"int64P",0,"Uint",0,"intP",(opacity-=6.6)<<16|1<<24,"Uint",2)
}
sleep,500
exitapp,

binds:
#maxhotkeysPerInterval,1440
keys:= "~wheelup,~wheeldown,~left,~right,~wheelleft,~wheelright,~=,~-,~#r"
loop,parse,keys,`,
	hotkey,%a_loopfield%,keys_labl
return,

AHK_NOTIFYICON(wParam,lParam) {
	switch,lParam {	;0x0206:;WM_RBUTTONDBLCLK; 0x020B:;WM_XBUTTONDOWN 0x0202:;WM_LBUTTONUP
		case 0x0203 : return,MenuPost(65407)	;WM_LBUTTONDBLCLK-0x0203
			tt("Loading...","tray",1)
		case 0x0208 : return,MenuPost(65303)	;WM_LBUTTONDBLCLK-0x0203
		case 0x0201 : keywait,LBUTTON
					  return,GuiActivate()
		case 0x0204 : tt("Reloading...","tray",1), return,MenuTrayShow() ;WM_RBUTTONUP-0x0204
			
}	}

IsWindowVisible(hWnd) {
	return,DllCall("IsWindowVisible","Ptr",hWnd)
}

GuiActivate() {
	global HWnd_Pic
	if IsWindowVisible(hwnd_pic)
		winMinimize,ahk_id %hwnd_pic%
	else,Try,winActivate,ahk_id %hwnd_pic%
}

; ID_TRAY_RELOADSCRIPT:
; ID_TRAY_RELOADSCRIPT:= 65303
; ID_TRAY_EDITSCRIPT:
; ID_TRAY_EDITSCRIPT:= 65304
; ID_VIEW_VARIABLES:
; ID_VIEW_VARIABLES:= 65407
; ID_TRAY_SUSPEND:
; ID_TRAY_SUSPEND:= 65305
; ID_TRAY_PAUSE:
; ID_TRAY_PAUSE:= 65306
; ID_TRAY_EXIT:
; ID_TRAY_EXIT:= 65307
; PostMessage,0x0111,% (%a_thislabel%),,,% A_ScriptName " - AutoHotkey"
; return, ;PostMessage,65307,%open%,,,% A_ScriptName " - AutoHotkey"

MenHandla(Enum="") {
	(Enum=""? (A_Thismenuitem? Enum:= A_Thismenuitem : msgb0x("a_thislabel")))
	switch,Enum {
		case "Preserve Position Characteristics": opt_movecenter:= !opt_movecenter
			menu,Tray,icon,% opt_movecenter? "Move Center":(),% opt_movecenter? "C:\Icon\256\ticAMIGA.ico":()
			return,
		case "65303-65307","65407" : return,MenuPost(a_thislabel) ;PostMessage,0x0111,% (%a_thislabel%),,,% A_ScriptName " - AutoHotkey"
			
		case "Open"       : return,MenuPost(65407)
		case "Edit Script": return,MenuPost(65304)
		case "Pause"      : return,MenuPost(65306)
		case "Suspend VKs": return,MenuPost(65305)
		case "Reload"     : return,MenuPost(65303)
		case "Exit"       : return,MenuPost(65307)
	}
}

MenuPost(winmessagenum) {
	PostMessage,0x0111,% winmessagenum,,,% A_ScriptName " - AutoHotkey"
}

GuiMenu() {
	menu,new,add,testmenu,donothing
	menu,new,show
}

MenuTrayShow() {
	Menu,Tray,Show
}

menus:
menu,Tray,NoStandard
menu,Tray,icon,% "C:\Script\AHK\z_ConTxt\imag3view4.ico"
menu,Tray,Add,% "Open",MenHandla
menu,Tray,Icon,% "Open",% "C:\Icon\24\Gterminal_24_32.ico"
menu,Tray,Add,% "preserve position characteristics",MenHandla
if(opt_movecenter)
	menu,Tray,icon,% "Preserve Position Characteristics",% "C:\Icon\256\ticAMIGA.ico"
if(!A_IsCompiled) {
	menu,Tray,Add,% "Edit Script",MenHandla
	menu,Tray,Icon,% "Edit Script",% "C:\Icon\24\explorer24.ico"
}
menu,Tray,Add,% "Reload",		MenHandla
menu,Tray,Icon,% "Reload",%		"C:\Icon\24\eaa.bmp"
menu,Tray,Add,% "Suspend VKs",	MenHandla
menu,Tray,Icon,% "Suspend VKs",% "C:\Icon\24\head_fk_a_24_c1.ico"
menu,Tray,Add,% "Pause",		MenHandla
menu,Tray,Icon,% "Pause",%		"C:\Icon\24\head_fk_a_24_c2b.ico"
menu,Tray,Add,% "Exit",			MenHandla
menu,Tray,Icon,% "Exit",%		"C:\Icon\24\head_fk_a_24_c2b.ico"
return,

Varz:
global hgui,Xcret10nnit,Image_Title,ImagePath,x10n,CURRENT_H,CURRENT_W,Pwner,opt_allCenter,pic_arr,Options,Curr_i,hovered,OWin,OControl,hGui,hovered,RECT,mdc,lbutton_click_thresh,rbutton_cooldown,turds,Curr_i,Starting_file,OutNameNoExt,_i_ndx_,Max_i,Curr_iOLD1,Curr_iOLD2,Options,pic0,pic1,pic2,xcent,ycent,repent,hi,wi,Recurse,opt_MaxFill,opt_ShrinkFill,alignment,ren,hovered,keys,_nx:=0,_ny:=0,_Netnx:=0,_Netny:=0,netnxold,netnyold,netxt,netyTemp,netx,nety,opt_Anchor,ftypes,keys,STrigga
, r3gk3y:="HKCU\SOFTWARE\_MW\image_view",ID_VIEW_VARIABLES:=65407,ID_TRAY_EDITSCRIPT:=65304,ID_TRAY_SUSPEND:=65305,ID_TRAY_PAUSE:=65306.ID_TRAY_EXIT:=65307,ID_TRAY_RELOADSCRIPT:=65303
, opt_movecenter:= True ;testing
, opt_greyscale:= True ;testing

VarSetCapacity(RECT,16)
if !ImagePath && If (!FileExist(ImagePath:=A_AppData "\" ScriptName "\appifyerFrame.png")) 
	ImagePath := remoteResource("appifyerFrame.png", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Modern_AutoHotkey_Logo_%28no_text%29.svg/330px-Modern_AutoHotkey_Logo_%28no_text%29.svg.png")

donothing:
return,

leave_:
gui,pic:	hide
gui,Pwner:	hide
gui,Pic:	destroy
gui,Pwner:	destroy
gosub,reg_WRite
exitapp,
loop,4
	sleep,500