#NoEnv
#NoTrayIcon
#persistent
#SingleInstance,Force
#maxthreadsperhotkey 3
#IfTimeout,200 ;* DANGER *: Performance impact if set too low. *think about using this*.
#include %a_scriptdir%\GDI+_All.ahk
#include %a_scriptdir%\CLR.ahk
#include <imageput>
PiD:= DllCall("GetCurrentProcessId")
;(imgv_instance:= winexist("imgvi3w4 ahk_class AutoHotkeyGUI",,"ahk_pid " . PID)? exitapp())
; if (!instr(A_AhkPath,"UIA")&&!A_IsCompiled) {
	; run,%A_AhkPath%\..\AutoHotkeyU64_UIA.exe "%A_ScriptFullPath%" "%1%" 
	; exitApp, ;Setworkingdir,% (ahkexe:= splitpath(A_AhkPath)).dir ; }
ListLines,Off 
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,	2
SetTitleMatchMode	Slow
SetBatchLines,		-1
SetWinDelay,		-1
coordMode,	ToolTip,Screen
coordmode,	  Mouse,Screen
SetWorkingDir %A_ScriptDir%
global r_pid:= DllCall("GetCurrentProcessId")
AnimationMs:= 60
%0%? ImagePath:= A_Args[1] : ()
(A_PtrSize=8? DllCall("SetDllDirectory","str","libwebp.x64"))
if(winactive("ahk_class WorkerW") || winactive("ahk_Class CabinetWClass") || winactive("ahk_Class SideBar_HTMLHostWindow"))
	global Launched_from_Explorer:= True
gui,sat:new,+hwndsatwnd -caption +toolwindow
gui,sat:show,x-10 y-10 h1 w1

onexit,Leave_
onmessage(0x0404,"AHK_NOTIFYICON")
onmessage(0x0201,"WM_LrBUTTDOWN")
onmessage(0x0202,"WM_LrBUTTUP")
onmessage(0x0203,"WM_LBUTTONDBLCLK")
onmessage(0x0204,"WM_rBUTTONdown")
onmessage(0x0205,"WM_rBUTTONup")
onmessage(0x0526,"wmmwheel")
onmessage(0x0522,"wmmwheel")
;onmessage(0x0101,"WM_KEYUP")
onmessage(0x0122,"MenuRButtUp")
onmessage(0x0047,"moved")
OnMessage(0x215,"WM_CAPTURECHANGED")

opt_Anchor:= True ; anchor session to position last used.
fTypes:= [], fTypes:= ["png","jpg","jpeg","jfif","gif","bmp","ico","webp","xcf","tiff","cur","ani","bin"]
global hks:= "~wheelup,~wheeldown,~left,~right,~wheelleft,~wheelright,~=,~-,~#r,~r,~XButton1,~XButton2,~F21,~F22"
loop,parse,% "Varz,Reg_Read,Menus,Binds,opt_enact,Top_PreCheckInit",`,
	gosub(A_loopfield)
opt_brightness:= 100

hotkey,~Escape,GuiEscape,On ;loop,parse,% hk,`,;hotkey,% A_loopfield,bY,On

main(ImagePath)
global a_args
return,

~escape::
critical
exit:= True
exitapp,

Moved() {
if instr(a_priorkey,"button") {
	gPos:= wingetpos(hgui)
	netx:=(gPos.x<a_screenwidth&&gPos.x>0)? gPos.x : a_screenwidth*.5- CURRENT_W* .5
	, nety:=(gPos.y<a_screenheight&&gPos.y>0)? gPos.y : a_screenheight*.5- CURRENT_H* .5
	; tt(netx "`n " nety "`n " a_priorkey,10)
	}
}

MenuRButtUp(){
	tt("RBUTTUP")
}

Main(Path2Pic1) {
	XCrete("","Preparse","",Path2Pic1) ;XCrete(Curr_i- 1) ;XCrete(Curr_i+ 1)
	XCrete(curr_i), XCrete(curr_i,"upd8")
	return,
}

XCrete(i="",lab3l="",H_Key="",inp4th="") {
	global	;if i;msgbox %i%
	static pbitmap
	if(!Xcret10n) {
		loop,parse,hks,`,
			hotkey,% a_loopfield,keys_labl,on
		Xcret10nnit:= True
	} if(lab3l) {
		goto,% lab3l
		return,
	} else,try {
		if(winactive("ahk_class WorkerW") || winactive(" ahk_Class CabinetWClass"))
			winactivate, ahk_id %satwnd%
		if Launched {
			 	dllcall("AnimateWindow","uint",hgui,"uint",AnimationMs,"uint",_:= (iOld>i)? 0x50002: 0x50001)
		} OPT_Benchmark? a_scriptStartTime:= a_tickCount : ()
		gui,Pwner:New,,% "imgvi3w4"
		gui,Pwner:+LastFound -Caption -DPIScale +ToolWindow +E0x80000 +HWNDhGui  ; hGui := WinExist()
	;	gui,pic: New,-DPIScale +ParentPwner  +ToolWindow +E0x80000 ;+AlwaysOnTop
		;gui,pic: +LastFound -Caption -SysMenu +OwnDialogs
		hwnd_pic:= WinExist()
		pic_arr[i].CurrPath? Curr_File:= pic_arr[i].CurrPath : Curr_File:= a_args[1] ;oio++
		pToken:= Gdip_Startup(), sdr:=(x10n="ico"?6:"") ; try,pBitmap:= Gdip_CreateBitmapFromFile(Curr_File,sdr)

		if(x10n="webp") {
			clipboard:= StrmString := stdOutStreamTT(rs:="identify -format " . quote("%wx%h") . " " .  quote(Curr_File),"")
			if(success:= regexmatch(StrmString,"([\d]+)x([\d]+)",res))
				w:=res1, h:=res2
			pBitmap:= Gdip_CreateBitmapFromHBITMAP(Webp_FileToHbitmap(Curr_File))
			run,%rs%
		} else,ndk:= pBitmap:= File_2_pBMP(Curr_File) ; faster than GdipCreateBitmapFromFile and does not lock file.
		;msgbox % Format("{:#x}",Gdip_GetImageFlags(ndk))
		(MatrixApply=True? Gdip_BitmapApplyEffect(pBitmap,Gdip_CreateEffect(3, Matrix_,"",""),0,0,a_screenwidth,a_screenheight))
		if(rotate)
			switch,rotate {
				case,"resetrot":Gdip_ImageRotateFlip(pBitmap,0)
					rotate:="0"
				case,"90"	:Gdip_ImageRotateFlip(pBitmap,1)
				case,"180"	:Gdip_ImageRotateFlip(pBitmap,2)
				case,"-90","270" :Gdip_ImageRotateFlip(pBitmap,3)
				case,"fliph":Gdip_ImageRotateFlip(pBitmap,4)
				case,"flipv":Gdip_ImageRotateFlip(pBitmap,6)
			}
		if(x10n="webp") {
			CURRENT_Wo:= res1, CURRENT_Ho:= res2
		} else {
			CURRENT_Wo:= Gdip_GetImageWidth(pBitmap), CURRENT_Ho:= Gdip_GetImageHeight(pBitmap)
		} if(opt_ShrinkFill||opt_MaxFill) {
			rw:= (a_screenwidth /(CURRENT_Wo))
			rh:= (a_screenheight/(CURRENT_Ho))
			if(current_Wo>a_screenwidth) {
				current_h:=current_ho*rw
				 current_W:=current_Wo*rw
			} else,if(current_ho>a_screenheight) {
				current_h:=current_ho*rh
				 current_W:=current_Wo*rh
			} else {
			current_h:=current_ho
				 current_W:=current_Wo
			}
			; tt(current_wo "`n " current_ho "`n " current_w "`n " current_h )
		} else,current_w:=current_wo, current_h:=current_ho ;msgbox % current_w " " current_h
		pImage:= Gdip_CreateBitmap(CURRENT_W, CURRENT_H)
		G2:= Gdip_GraphicsFromImage(pImage)
		Gdip_SetInterpolationMode(G2,1)
		Gdip_SetSmoothingMode(G2,1)

		op_dimlum:= True

		(op_dimlum? matrix_:=MatrixBrightness(opt_brightness))

		Gdip_DrawImage(G2,pBitmap,0,0,CURRENT_W,CURRENT_H,0,0,CURRENT_Wo,CURRENT_Ho,(matrix_?matrix_:""))
		if(x10n="ico")
			goto,DC_stuff
		else,if(opt_MaxFill)
			goto,shrinkxpand
		else,if(CURRENT_W>a_screenwidth || CURRENT_H>a_screenheight)
			goto,shrinkxpand
		else,goto,DC_stuff
			return,
;-----------------------------------------------------------------
		shrinkXpand:
		if(opt_MaxFill) {
			rw:= (a_screenwidth /(CURRENT_W)), rh:= (a_screenheight/(CURRENT_H))
			, CURRENT_H:= rw<rh? floor(rw*(CURRENT_H)) : a_screenheight
			, CURRENT_W:= rw<rh? a_screenwidth : floor(rh*(CURRENT_W))
			, hi:= ("h" . round(CURRENT_H)), wi:= ("w" . round(CURRENT_W))
		} DC_stuff: ;Gdip_DrawImageFX(pGraphics, pBitmap, dX:="", dY:="", sX:="", sY:="", sW:="", sH:="", matrix:="", pEffect:="", ImageAttr:=0, hMatrix:=0, Unit:=2)
		if(copy) { ; Gdip_DrawImageFast(G2, pBitmap, 0, 0)
		;	pImage:= Gdip_CreateARGBBitmapFromHBITMAP(Gdip_CreateHBITMAPFromBitmap(pImage))
		;	Gdip_BitmapApplyEffect(pImage ,Gdip_CreateEffect(3,"" ,"",""),0,0,a_screenwidth,a_screenheight)
		; 	Gdip_BitmapApplyEffect(pImage ,Gdip_CreateEffect(3, alphamatrix2,"",""),0,0,a_screenwidth,a_screenheight)
		; 	Gdip_SetBitmapToClipboard(pImage)
		;	Gdip_SetBitmapToClipboard(pImage,Gdip_CreateHBITMAPFromBitmap(pImage))
			pImage3:=Gdip_CreateARGBBitmapFromHBITMAP(pimage2:=Gdip_CreateHBITMAPFromBitmap(pImage))
			Gdip_SetBitmapToClipboard(pimage3) ;msgbox % Gdip_GetImagePixelFormat(pBitmap,2)
			copy:= False
		} if(getkeystate("escape","p"))
			exitapp,
		  mDC:=	Gdi_CreateCompatibleDC(0)
		, mBM:=	Gdi_CreateDIBSection((mDC),CURRENT_W,CURRENT_H,32) ;(opt_greyscale? mBM:= GDI_GrayscaleBitmap(mBM2))
		, oBM:=	Gdi_SelectObject(mDC, mBM)
		, pG_:=	Gdip_CreateFromHDC(mDC) ;pImage:=Gdip_BlurBitmap(pImage,8) ; pImage2:= Gdip_CreateBitmapFromFile("C:\Script\AHK\GDI\images\topbar3.png")
		if(a_thislabel="DC_stuff")
			Gdip_DrawImageFast(pG_,pImage,0,0)
		else,try,Gdip_DrawImageRECTI(pG_,pImage,0,0,CURRENT_W,CURRENT_H)
		opt_topmost? gui_zpos:= "+AlwaysOnTop" : gui_zpos:= ""
		,opt_noactiv8:= false ;testing
		,opt_noactiv8? gui_noactiv8:= " NA " : gui_noactiv8:= ""
		,opt_posallCenter:= true ;testing
		,opt_posallCenter? gui_pos := "Center" : ()
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
	,	old_H:= CURRENT_H, old_W:= CURRENT_W
	,	hi:= ("h" .	round(CURRENT_H*=result) ) ; hi:=  ("h" . round(CURRENT_H))
	,	wi:= ("w" .	round(CURRENT_W*=result) ) ; wi:=  ("w" . round(CURRENT_W))
	} return,

	PreParse:
	pic_arr:= {}, XCent:= (a_screenwidth *.5), YCent:= (a_screenheight *.5)
	SplitPath,inp4th,Starting_file,Image_Dir,x10n,Image_Title
	setWorkingDir,% Image_dir
	opt_recurse:= "R",	Paths:= "", poo:=func("poopoo").bind(inp4th)
	settimer,% poo ,-10
	return,

	upd8: ;if(!opt_ShrinkFill) {
	if((_netnx>a_screenwidth||_netnx<0)&&(_netny>a_screenheight||_netny<0))
		_Netnx:=0, _Netny:=0
	gPos:= wingetpos(hgui)
	(netx? netxold2:= net_x:= netx), (nety?netyold2:= net_y:= nety)
	(!(_nx-gPos.x=0)? net_x:= gPos.x), (!(_ny-gPos.y=0)? nety:= gPos.y)
	_nxold:=_nx, _nyold:=_ny, CURRENT_W_old:= CURRENT_W, CURRENT_h_old:= CURRENT_H
	_nx:= round(XCent-(CURRENT_W*.5)), _ny:= round(YCent-(CURRENT_H*.5)) ; center alignment
	(net_x<0||net_x=0?net_x:=48), (Nety<0||Nety=0?NetY:=64)
	((NetY+CURRENT_H>a_screenheight)? (nety:=a_screenheight-CURRENT_H-20))
	((net_x+CURRENT_w>a_screenwidth)? (nety:=a_screenwidth-CURRENT_w-20))
	;(opt_movecenter? (_nx -=net_x, _ny -=Nety)
	 ((_nx>a_screenwidth-CURRENT_W)? (_nx:=a_screenwidth-CURRENT_W)<0? (_nx:=0) : ( _nx :=netx))
	 ((_ny>a_screenheight-CURRENT_h)?( _ny:=a_screenheight-CURRENT_h)? (_nx:=0) : (_ny :=Nety))
	DllCall("UpdateLayeredWindow","Uint",hGui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
	 ,"Uint",mDC,"int64P",0,"Uint",0,"intP",0xFF<<16|1<<24,"Uint",2) ;msgbox % _nx " " _nY
	if(x10n="webp")
		gui,Pwner: Show,%gui_noactiv8% x%_nx% y%_ny% w%res1% h%res2%
	else,{
		gui,Pwner: Show,%gui_noactiv8% x%_nx% y%_ny% w%CURRENT_W% h%CURRENT_h% na hide
	}

	if(Launched) {
		dllcall("AnimateWindow","uint",hgui,"uint",AnimationMs,"uint",_:= (iOld>i)? 0x20002: 0x20001)
	} else,if(Launched_from_Explorer) {
		if(CURRENT_W=a_screenwidth)&&(CURRENT_H=A_ScreenHeight)
			X_M:= Y_M:= 0
		else {
			mousegetpos,x_m,y_m
			((X_M- (CURRENT_W/2))<0)? x_m:= 40 : ((x_m+CURRENT_W>A_ScreenWidth) ? x_m:= A_ScreenWidth-340 -CURRENT_W: X_M-=(CURRENT_W/2)) ;340 takes into account sidebar.exe
			((Y_M -(CURRENT_H/2))<0)? y_m:= 66 : ((y_m+CURRENT_H>A_ScreenHeight)? y_m:= A_ScreenHeight-40 -CURRENT_H: Y_m-=(CURRENT_H/2))  ;70 takes into account top taskbar
		}

		winset,ExStyle,+0x08000000
		win_move(hgui,x_m,y_m)
		Launched := True
		SetForegroundWindow(hgui) ;(OPT_BENCHMARK? _:= (a_tickCount-a_scriptStartTime) . " Ms", TT(_))
		WinAnimate(hgui,"activate center",AnimationMs*2)
	}	iOld:= i

	Delete:
	GDI_SelectObject(mDC,oBM)
	Gdi_DeleteObject(mBM) ; Gdi_DeleteDC(mDC)
	Gdip_DeleteGraphics(g2)
	Gdip_DisposeImage(pImage)
	Gdip_DisposeImage(pbitmap)
	return,

	Old_Delete:
	gui,pic:destroy
	Gdip_Shutdown(pToken)
	return,

	Keys_LablL:
	MouseGetPos,,,OWin,OControl ; 1|2|3
	((OWin=hGui)? Hovered:= True : (Hovered:= False))
	(!H_Key? msgb0x("error"))
	(instr(H_Key,"~")? H_Key:= strreplace(H_Key,"~") : (H_Key:= H_Key))
	iOld2:= iOld1, iOld1:= oio
	ifwinNotActive,ahk_id %hGui%
		 if(!Hovered)
			return,
	switch,H_Key {
		case,"=" : opt_MaxFill:=!opt_MaxFill
			(opt_MaxFill? (nety? (netyTemp:= nety,nety := 0) : (netyTemp? nety:= netyTemp))) ;keeps x offset when maximized
		case,"-" : opt_ShrinkFill:=!opt_ShrinkFill
			; switch,mag {
				; case,"7" : SizeWin("x6")
				; case,"6" : SizeWin("x5")
				; case,"5" : SizeWin("x4")
				; case,"4" : SizeWin("x3")
				; case,"3" : SizeWin("x2") ;	}
		case,"wheeldown" : curr_i:= (oio>0? oio += 1 : oio)
			refrec(curr_i+=1) ; case,"right","wheeldown" : critical
			;tt(Hovered " " hGui " " OWin " " hwnd_pic, 10)
			;curr_i:= (oio<Max_i? oio += 1 : oio:= 1)
		;case,"^right","~^wheeldown","~^wheelright": curr_i:= refrec(5) ;curr_i:= (oio<Max_i? oio += 5 : oio:= 1)
		;case,"left","~wheelup","wheelup" : critical
		case,"wheelup" : curr_i:= (oio>0? oio -= 1 : oio)
			 refrec(curr_i-=1)
		;case,"^left","~^wheelup","~^wheelleft" : curr_i:= refrec(-5)
			;return,
		case,"delete" : ifwinnotActive,ahk_id %hGui%
			return, ; FileRecycle,% pic_arr[oio].CurrPath ; return, ; tt(pic_arr[oio].CurrPath "`nSent to the recycle bin",1300)
		case,"#r" : reload,
	}	; switch,pic_arr[oio].xtn {
			; case,"ico"		:	tt("ico file",3000)
			; case,"gif"		:	tt("gif file",3000)
			; case,"default"	:	tt(pic_arr[oio].xtn " file.")	; }
	XCrete(oio), XCrete(oio,"upd8")
	(!(iOld2=oio)? XCrete(iOld2,"old_delete"))
	return,
}

sizewin(sZ,hWn="",center="") {
	static MidX:= a_screenwidth *.5, MidY:= a_screenheight *.5
	,HAg_Tsk:= A_screenheight -54
	siZ:= sZ, (hWn=""?hWn:= WinExist("A")) ;(instr(sZ,"center"))? sZ:= strreplace(sZ,"center",""):()	;(!(center="")? Center:= True)
	try,((!WActive:= wingetpos(hWn))? msgb0x("add")) ;winminimize,ahk_id %hWn%;winrestore,ahk_id %hWn%
	WActive.w-=12, WActive.h-=46
	switch,sZ {
		case,"quad","x4": (((WActive.h*4)<HAg_Tsk)
			?	(CURRENT_W *=4, CURRENT_H *=4, mag++)
			:	retval:= "x3")
			(retval?sizewin(retval,hWn):0)
		case,"triple","x3": (((WActive.h*3)<HAg_Tsk)
			?	(CURRENT_W *=3, CURRENT_H *=3, mag++)
			:	retval:= "x2")
			(retval? sizewin(retval,hWn):0)
		case,"double","x2","2/1" : (((WActive.h*3)<HAg_Tsk)
			?	(CURRENT_W *=3, CURRENT_H *=3, mag++)
			:	retval:= "1/2")
			(retval?sizewin(retval,hWn):0)
		case,"halve","half","1/2": (CURRENT_W *=.5, CURRENT_H *=.5, mag--)
		case,"+10%" : win_move(hWn,WActive.X,WActive.Y,(WActive.W*1.1)+12,(WActive.H*1.1)+46,"")
		case,"-10%" : win_move(hWn,WActive.X,WActive.Y,(WActive.W*0.9)+12,(WActive.H*0.9)+46,"")
		case,"+50%" : win_move(hWn,WActive.X,WActive.Y,round(WActive.W*1.5)+12,round(WActive.H*1.5)+46,"")
		case,"-33%" : win_move(hWn,WActive.X,WActive.Y,round(WActive.W*0.777)+12,round(WActive.H*0.777)+46,"")
	} ratio_Longest:= (WActive.W>WActive.H
	? "Landscape" . ratio_Longest:= WActive.H/WActive.W
	: "portrait" . ratio_Longest:= WActive.W/WActive.H)
	loop,{
		 ((Accuracy:= (raw:= a_index *(1/ratio_Long)) -(rounded:= round(raw)))
		, < 0.05? denominator:= a_index, msgb0x("demoninatoir: " a_index "`nacc: " Accuracy))
		if(denominator||(a_index>20))
			return,(Denomintator? Denomintator:0)
	}
}

WM_LrBUTTDOWN() {
	global	;xs:= lParam &0xffff, ys:= lParam>>16
	coordmode,Mouse,Screen
	mousegetpos,xs,ys
	PostMessage,0xA1,2 ; WM_NCLBUTTONDOWN
	return,1
	;return,xs,ys
}

WM_LrBUTTUP() {
global 
coordmode, Mouse,Screen
	;xf:= lParam &0xffff, yf:= lParam>>16,
	mousegetpos,xf,yf
	msgbox % xs " " ys
	if(xf>xs+24 || xf<xs-24)||(yf>ys+24 || yf<ys-24)
		return,-1
	else,tt("clicked")
}

poopoo(Curr_F="") {
	global
	static fTyp
	if !fTyp
	fTyp:= [], fTyp:= ["png","jpg","jpeg","jfif","gif","bmp","ico","xcf","tiff","cur","ani","bin"]
	oo:=0 ;msgbox % opt_recurse " " Image_dir " " fTyp[2]
	Loop,Files,% Image_dir "\*.*",%  opt_recurse
	{	; Trim(A_LoopFileFullPath) "'"
		if(targetpath:= RTrim((targetpath:= LTrim(A_LoopFileFullPath)))) {
			; msgbox % A_LoopFileFullPath "`n" Curr_F
			SplitPath,A_LoopFileFullPath,,,xTnz0n
			switch,xTnz0n {
				case,fTyp[1],fTyp[2],fTyp[3],fTyp[4],fTyp[5],fTyp[6],fTyp[7],fTyp[8],fTyp[9]:
					pic_arr.push({"CurrPath" : A_LoopFileFullPath : "xtn" : xTnz0n })
					oo++
			}
			Max_i:= a_index
		} else,msgbox,error
		if(A_LoopFileFullPath=Curr_F)
			oio:= oo
	} (!Max_i? msgb0x("Error!", "Error no max`n:("))
	return,pic_arr
}

WM_rBUTTONdown(wParam="",lParam="",umsg="",hwnd="") { ;toggles maximise fill
	global STrigga,hgui, LbD:=""
	tt("rbd " hwnd_pic _s wParam _s Format("{:#x}",lParam ) _s umsg _s Format("{:#x}",hwnd))
	((hwnd!=hgui)? return())
	;if !STrigga {		GuiMenu()
		settimer,GuiMenu,-1
	return,
}	;}

WM_rBUTTONup(wParam="",lParam="",umsg="",hwnd="") { ;toggles maximise fill
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
	OpenContaining(Curr_File)
	sleep,50
	exitapp
}

WM_RBUTTONDOWN2(byref wParam,byref lParam,byref RECT) {
	global hGui,rbutton_cooldown:=false
	settimer,rbutton_cooldown_reset,-670
	xs:= lParam &0xffff, ys:= lParam>>16
	DllCall("SetWindowBand","ptr",hGui,"ptr",0,"uint",15) ;tt(a_lasterror)
	while,GetKeyState("rbutton","P") {
		if(!GetKeyState("rbutton","P"))
			return,
		DllCall("GetCursorPos","Uint",&RECT)
		vWinX:= NumGet(&RECT,0,"Int")-xs
		vWinY:= NumGet(&RECT,4,"Int")-ys
		win_move(hGui,vWinX,vWiny,"","","")
		sl33p()
}	}



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
	return
}	}

refrec(byref _i="") {
	global
	((curr_i<1)? _i:= Max_i : ((curr_i>Max_i)? _i:= 1))
	,XCrete(_i),sl33p(), XCrete(oio,"upd8")
	,(!(iOld2=oio)?XCrete(iOld2,"old_delete"))
}

keys_labl:
XCrete(Curr_i,(a_thislabel . "L"),a_thishotkey)
return,

opt_enact:
if(opt_movecenter)
	menu,Tray,icon,% "preserve position characteristics",% "HICON:* " b64_2_hicon(amigtick),,48 ;"C:\Icon\256\ticAMIGA.ico",,48
else,menu,Tray,icon,% "preserve position characteristics",% "HICON:* " b64_2_hicon(na48),,48 ; ,% "C:\Icon\48\na_48.ico"
return,

sl33p() {
	sSleep(10)
}

sSleep(stime=4) {
	DllCall("Winmm\timeBeginPeriod","UInt",3)
	DllCall("Sleep","UInt",stime)
	DllCall("Winmm\timeEndPeriod","UInt",3)
}

SetClipboardData(hBitmap) {
	DllCall("GetObject","UPtr",hBitmap,"int",VarSetCapacity(oi, A_PtrSize=8? 104 : 84,0),"UPtr",&oi)
	; hDBI := DllCall("GlobalAlloc", "uint", 2, "UPtr", 40+NumGet(oi, off1, "UInt"), "UPtr")
	 pDBI:= DllCall("GlobalLock","UPtr",hDBI,"UPtr")
	; DllCall("RtlMoveMemory", "UPtr", pDBI, "UPtr", &oi+off2, "UPtr", 40)
	; DllCall("RtlMoveMemory", "UPtr", pDBI+40, "UPtr", NumGet(oi, off2 - A_PtrSize, "UPtr"), "UPtr", NumGet(oi, off1, "UInt"))
	; DllCall("GlobalUnlock", "UPtr", hDBI)
	; DeleteObject(hBitmap)
	; r3 := DllCall("SetClipboardData", "uint", 8, "UPtr", hDBI) ; CF_DIB = 8
	; DllCall("CloseClipboard")
	; DllCall("GlobalFree", "UPtr", hDBI)
 	; DllCall("GetObject", "Uint", hBitmap, "int", VarSetCapacity(oi,170,0), "Uint", &oi)
	hDBI:= DllCall("GlobalAlloc","Uint",2,"Uint",80+NumGet(oi,88))
;	pDBI:= DllCall("GlobalLock","Uint",hDBI)
	DllCall("RtlMoveMemory","Uint",pDBI,"Uint", &oi+48,"Uint",80)
	DllCall("RtlMoveMemory","Uint",pDBI+80,"Uint",NumGet(oi,40),"Uint",NumGet(oi,88))
	DllCall("GlobalUnlock","UPtr",hDBI)
	DllCall("OpenClipboard","Uint",0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData","Uint",8,"Uptr",hDBI)
	DllCall("CloseClipboard")
}

Copy_Image_Data:
imageputclipboard(Curr_File)
return,

~^c::
winget,pid,pid,a
if(r_pid=pid)
	gosub,copy_image_data
return,

pToken2:= Gdip_Startup()

msgbox,% Gdip_GetImageFlags(pBitmap )
Gdip_SetBitmapToClipboard(pBitmap )
Gdip_Shutdown(pToken2)
Gdip_CreateARGBHBITMAPFromBitmap(Gdip_CreateBitmapFromFile(Curr_File))
pImage3:=Gdip_CreateARGBBitmapFromHBITMAP(pimage2:=Gdip_CreateHBITMAPFromBitmap(pImage))
return,
gosub,copy_image_data
pToken2	:= Gdip_Startup()
msgbox,% pBitmap
hBmp	:= Gdip_CreateHBITMAPFromBitmap(pimage,0)
Gdip_Shutdown(pToken2)
Gdip_SetBitmapToClipboard(pimage3,pimage3)
sleep,499
DllCall("DeleteObject","Uint",hBitmap)
return,

RButton_CoolDown_Reset:
LButton_CoolDown_Reset:
StringTrimRight,resetwhich,a_thislabel,6
(%resetwhich%):= False
return,

LButton_CoolDown_Reset_Thrice:
RButton_CoolDown_Reset_Thrice:
StringTrimRight,ResetWhich,a_thislabel,6
loop,3 {
	(%ResetWhich%):= False
	settimer,% ResetWhich . "_reset",off
	sleep,25
} return,

Reg_Read:
loop,parse,% "ShrinkFill,MaxFill,alignment,recurse,topmost,preserveoffsets,brightness",`,
	regread,  opt_%a_loopfield%,% r3gk3y, %a_loopfield%
loop,parse,% "netx,nety",`,
	regread,%a_loopfield%,% r3gk3y, %a_loopfield%
	if(!netx || netx>a_screenwidth || netx<1)
		netx:=60
	if(!nety || nety>a_screenheight || nety<1)
		nety:=60
return,

Reg_WRite:
loop,parse,% Options:= "ShrinkFill,MaxFill,recurse,topmost,preserveoffsets,brightness",`,
	regwrite,% "REG_SZ",% r3gk3y,%a_loopfield%,% opt_%a_loopfield%
loop,parse,% other:= "netx,nety",`,
	regwrite,% "REG_SZ",% r3gk3y,%a_loopfield%,% %a_loopfield%
return,

GuiEscape:
GuiClose:
sleep,300
exitapp,

test:
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

MatrixBrightness(Bright_Percent="100") {
	cp:= 0.01*(pc:=(Bright_percent>1? Bright_percent/100 : Bright_percent))
	return,matrix_:="
		(LTrim Join Comments
		(	" pc "	| 0		| 0		| 0		| 0 	|
			0		|" pc "	| 0		| 0		| 0 	|
			0		| 0		|" pc "	| 0		| 0 	|
			0		| 0		| 0		| 1		| 0 	|
			" cp "	| " cp "| " cp "| 0		| 1 	|
		)"
}

IsWindowVisible(hWnd) {
	return,DllCall("IsWindowVisible","Ptr",hWnd)
}

GuiActivate() {
	global HWnd_Pic,hgui,CURRENT_W,CURRENT_H
	gPos:=wingetpos(hgui)
	winanimate(hgui,"hide center",100)
	winset,alwaysontop,on
	winanimate(hgui,"activate center",200)
	win_move(hgui,gPos.x,gPos.y,CURRENT_W,CURRENT_H,0)
		winset,alwaysontop,off
	return,
	if(!IsWindowVisible(hwnd_pic))
		winMinimize,ahk_id %hwnd_pic%
	else,if winactive,ahk_id %hwnd_pic%
		return
	else,Try,winActivate,ahk_id %hwnd_pic%
}

SetForegroundWindow(hWnd) { ;https://msdn.microsoft.com/en-us/library/windows/desktop/ms633539(v=vs.85).aspx
	return,DllCall("SetForegroundWindow", "int", hWnd)
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

; MenuPost(winmessagenum) {
	; global ;msgbox % winmessagenum
	; PostMessage,0x0111,%winmessagenum%,,,%A_ScriptName% - AutoHotkey
; }

TopmostSET(hwnd) {
	return,DllCall("SetWindowPos","uint",hWnd,"uint",-1,"int","","int","","int","","int","","uint",16388)
}

MenuPost(wMsgEnum="") {	;PostMessage,0x0111,% wMsgEnum,,,% A_ScriptName " - AutoHotkey"
	return,DllCall("PostMessage","Ptr",a_scripthwnd,"UInt",0x0111,"int",wMsgEnum,"int",0)
}

AHK_NOTIFYICON(wParam,lParam) {
	switch,lParam {	;0x0206:;WM_RBUTTONDBLCLK; 0x020B:;WM_XBUTTONDOWN 0x0202:;WM_LBUTTONUP
		case,0x0122 : tt("Main")
		case,0x0203 : settimer,GuiActivate,-10
		case,0x0208 : fn:= func(MenuPost).bind(65303)
			settimer,% fn,-10
		case,0x0208 : tt("Reloading...","tray",1)
		case,0x0204 : settimer,MenuTrayShow,-10
		case,0x0205 : tt("sssssssssssssss") ;MenuTrayShow() ;WM_RBUTTONUP-0x0204	;return,1
	}
}

Top_PreCheckInit:
if(opt_Topmost!="") ;pretoggle to save coding more
	opt_Topmost:=!opt_Topmost
ToglTopmost:
if(opt_Topmost:=!opt_Topmost) { ;DllCall("SetWindowBand","ptr",hGui,"ptr",0,"uint",15)
	uiband_set(hGui)
	WinSet,Top,,ahk_id %hgui%
	WinSet,AlwaysOnTop,On,ahk_id %hgui%
} else { ;WinSet,Top,off,ahk_id %hgui%
	WinSet,AlwaysOnTop,Off,ahk_id %hgui%
}
return,

MENSpunction() {
	global
	trayActiv:= True
	Menu,Tray,Show
	trayActiv:= False
}

File_2_pBMP(Image) { ;Faster than GdipCreateBitmapFromFile and does not lock the file. ;
	pStream:= FileGet(Image)
	DllCall("gdiplus\GdipCreateBitmapFromStream","ptr",pStream,"ptr*",pBitmap:=0)
	ObjRelease(pStream)
	return,pBitmap
}

FileGet(Image) {
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
	static CLSID_WICImagingFactory:= "{CACAF262-9370-4615-A13B-9F5539DA4C0A}"
			, IID_IWICImagingFactory:= "{EC5EC8A9-C395-4314-9C77-54D7A935FF70}"
			, GUID_ContainerFormatPng:= "{1B7CFAF4-713F-473C-BBCD-6137425FAEAF}"
			, WICBitmapUseAlpha:= 0x00000000, GENERIC_WRITE:= 0x40000000
			, WICBitmapEncoderNoCache:= 0x00000002
	VarSetCapacity(GUID,16,0)
	DllCall("Ole32\CLSIDFromString","WStr",GUID_ContainerFormatPng,"Ptr",&GUID)
	IWICImagingFactory:= ComObjCreate(CLSID_WICImagingFactory, IID_IWICImagingFactory)
	; IWICImagingFactory::CreateBitmapFromHBITMAP
	DllCall(NumGet(NumGet(IWICImagingFactory+ 0)+ A_PtrSize*21),"Ptr",IWICImagingFactory,"Ptr",hBitmap,"Ptr",0,"UInt", WICBitmapUseAlpha,"PtrP",IWICBitmap)
	; IWICImagingFactory::CreateStream
	DllCall(NumGet(NumGet(IWICImagingFactory+ 0) + A_PtrSize*14),"Ptr",IWICImagingFactory,"PtrP",IWICStream)
	; IWICStream::InitializeFromFilename
	DllCall(NumGet(NumGet(IWICStream+ 0)+ A_PtrSize*15),"Ptr",IWICStream,"WStr",destPngFilePath,"UInt",GENERIC_WRITE)
	; IWICImagingFactory::CreateEncoder
	DllCall(NumGet(NumGet(IWICImagingFactory+ 0)+ A_PtrSize*8),"Ptr",IWICImagingFactory,"Ptr",&GUID,"Ptr",0,"PtrP",IWICBitmapEncoder)
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

WM_CAPTURECHANGED() {
	gosub,CurCheck
}

CurCheck:
if(CurChanged) {
	mousegetpos,,,hwnd,cwnd,2
	if(hwnd=hgui) {
		settimer,curcheck,-100
		return,
	} CurChanged:=false
DllCall("SystemParametersInfo","uInt",0x57,"uInt",0,"uInt",0,"uInt",0) ;RestoreCursor()
} return,


; AHK_NOTIFYICON(wParam, lParam) {	; 0x201: ; WM_LBUTTONDOWN   ; 0x202:; WM_LBUTTONUP
	; Thread,Priority,0 || ;Thread,Priority,7 ; 0x020B:; WM_XBUTTONDOWN
	; switch,lParam {
		;case,0x0200 : refresh_uptime_(True)	 ; WM_MOUSEmove
		;	return,% Refresh_uptime_(True)
		; case,0x204 : return,% MENSpunction() ; WM_RBUTTONDN
	;		MENSpunction()
			; return,
		; case,0x203 : TT("Loading...") ; Timer("ID_VIEW_VARIABLES",-1);	WM_LBUTTONDBLCLK
			;;p ;'/08880*-*PostMessage,0x0111,%ID_VIEW_VARIABLES%,,,% (A_ScriptName " - AutoHotkey")
; MenuPost(65407)
			; winget,h,id,WinEvent.ahk - AutoHotkey
		; case,0x205 : return,(trayActiv?MENSpunction()) ;WM_RBUTTONUP
	;	case,0x0208:;	WM_MBUTTONUP	;;Timer("ID_TRAY_RELOADSCRIPT",-1); TT("Reloading... 1 sec",900); sleep,900; reload			; return
	; }/-+	; return,
; }

Webp_URLToHbitmap(URL) {
	whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("GET", URL, true)
	whr.Send()
	whr.WaitForResponse()
	asm := Clr_LoadLibrary("Imazen.WebP.dll")
	SimpleDecoder := asm.CreateInstance("Imazen.WebP.SimpleDecoder")
	bitmap := SimpleDecoder.DecodeFromBytes(whr.responseBody, whr.responseBody.MaxIndex()+1)
	return bitmap.GetHbitmap()
}

Webp_FileToHbitmap(WebpFile) {
	bytes := File_To_SafeArray(WebpFile)
	asm := Clr_LoadLibrary("Imazen.WebP.dll")
	SimpleDecoder := asm.CreateInstance("Imazen.WebP.SimpleDecoder")
	bitmap := SimpleDecoder.DecodeFromBytes(bytes, bytes.MaxIndex()+1)
	return bitmap.GetHbitmap()
}

File_To_SafeArray(FileName) {
	f := FileOpen(FileName, "r")
	safeArr := ComObjArray(0x11, f.length) ; Create SAFEARRAY = VT_ARRAY|VT_UI1
	pvData := NumGet(ComObjValue(safeArr) + 12 + (A_PtrSize==8 ? 4 : 0)) ; get pvData memeber
	f.RawRead(pvData + 0, f.length) ; read raw data
	f.Close()
	return safeArr
}

none:
return,

MenHandla(Enum="") {
	(Enum=""? (A_Thismenuitem? Enum:= A_Thismenuitem : msgb0x("a_thislabel")))
	switch,Enum {
		case,"Preserve Position Characteristics": menu,Tray,icon
		,% (opt_movecenter:= !opt_movecenter)? "Move Center":(),% opt_movecenter? "HICON:* " b64_2_hicon(amigtick),,48
		case,"Preserve offsets @ exit"  : menu,Tray,Icon,% "Preserve offsets @ exit"
		,% ((opt_preserveoffsets:=!opt_preserveoffsets)? "HICON:* " b64_2_hicon(amigtick): "HICON:* " b64_2_hicon(na48),,48 ),,48
		case,"65303-65307","65407" : return,MenuPost(a_thislabel) ;PostMessage,0x0111,% (%a_thislabel%),,,% A_ScriptName " - AutoHotkey"
		case,"Open"        : MenuPost(65407)
		case,"Edit Script" : MenuPost(65304)
		case,"Pause"       : MenuPost(65306)
		case,"Suspend VKs" : MenuPost(65305)
		case,"Reload"      : MenuPost(65303)
		case,"Exit"        : MenuPost(65307)
		case,"Open containing" : p:= Open_Containing(ImagePath)
		case,"Copy path" : clipboard:= ImagePath
		case,"Cut " . Image_Title . "." . x10n:invokeverb(ImagePath,"cut")
		case,"Delete" : filerecycle,% ImagePath
			tt("deleted",1)
		case,"Move" : gosub,none
		case,"greyscale" : MatrixApply:=true, matrix_:=MatrixGreyScale,	refrec(curr_i)
			XCrete(oio),XCrete(oio,"upd8"),MatrixApply:=false,
		case,"greyscale off" : MatrixApply:=true, matrix_:=MatrixGreyScale,	refrec(curr_i)
			XCrete(oio),XCrete(oio,"upd8"),greyscale:=true
		case,"greyscale on" : MatrixApply:=false, matrix_:="",	refrec(curr_i)
			XCrete(oio),XCrete(oio,"upd8"),greyscale:=false
		case,"sepia" : matrix_:=GenerateColorMatrix(8)
			MatrixApply:=true, refrec(curr_i)
			XCrete(oio),XCrete(oio,"upd8"),MatrixApply:=false
		case,"sepia off" : MatrixApply:=true,  sepia:=true
			matrix_:=GenerateColorMatrix(8)
			refrec(curr_i)
			XCrete(oio),XCrete(oio,"upd8"),
		case,"sepia on" : MatrixApply:=false,sepia:=false, matrix_:="",	refrec(curr_i)
			XCrete(curr_i),XCrete(curr_i,"upd8")
		case,"alpha2greyscale1" : matrix_:=alphamatrix1
			MatrixApply:=true, refrec(curr_i)
			XCrete(curr_i),XCrete(curr_i,"upd8"),MatrixApply:=false
		case,"alpha2greyscale1 off" : MatrixApply:=true,  alpha2greyscale1:=true
			matrix_:=alphamatrix1
			refrec(curr_i)
			XCrete(curr_i),XCrete(curr_i,"upd8"),
		case,"alpha2greyscale2 on" : MatrixApply:=false,alpha2greyscale2:=false, matrix_:="",	refrec(curr_i)
			XCrete(curr_i),XCrete(curr_i,"upd8")
		case,"alpha2greyscale2 off" : MatrixApply:=true,  alpha2greyscale2:=true
			matrix_:=alphamatrix2
			refrec(curr_i), XCrete(curr_i),XCrete(curr_i,"upd8")
		case,"alpha2greyscale2 on" : MatrixApply:=false,alpha2greyscale2:=false, matrix_:="",	refrec(curr_i)
			XCrete(oio),XCrete(oio,"upd8")
		case,"alpha2greyscale2" : matrix_:=alphamatrix2
			MatrixApply:=true, refrec(curr_i)
		case,"invert" : matrix_:=GenerateColorMatrix(6)
			MatrixApply:=true, refrec(curr_i)
			XCrete(oio),XCrete(oio,"upd8"),MatrixApply:=false
		case,"invert off" : MatrixApply:=true,  invert:=true
			matrix_:=GenerateColorMatrix(6)
			refrec(curr_i), XCrete(oio),XCrete(oio,"upd8"),
		case,"invert on" : MatrixApply:=false,invert:=false, matrix_:="",	refrec(curr_i)
			XCrete(oio),XCrete(oio,"upd8")
		case,"rotate 90 clockwise" : if(rotate=270) {
				r90cw:=false, r90ccw:=false,
				rotate:="resetrot"
			} else {
				r90cw:=true, r90ccw:=false, rotate+=90
			}
			refrec(curr_i), XCrete(oio),XCrete(oio,"upd8")			;rotate:=""
		case,"rotate 90 anticlockwise"	: r90ccw:=true, r90cw:=false, rotate-=90
			refrec(curr_i), XCrete(oio),XCrete(oio,"upd8")			;rotate:=""
		case,"rotate 180" 				: rotate:=180
			refrec(curr_i), XCrete(oio),XCrete(oio,"upd8")			;rotate:=""
		case,"flip h" 					: rotate:="fliph"
			refrec(curr_i), XCrete(oio),XCrete(oio,"upd8")			;rotate:=""
		case,"flip v" 					: rotate:="flipv"
			refrec(curr_i), XCrete(oio),XCrete(oio,"upd8")			;rotate:=""
		case,"Topmost" : settimer,ToglTopmost,-30
		case,"Pin" : gosub,none
		case,",Bring-out Gimp" : run,% "C:\Program Files\GIMP 2\bin\gimp-2.10.exe " ImagePath
	}
	return,
}

GuiMenu() {
	global
	try,menu,new,deleteall
	menu,new,add,Topmost,MenHandla
	menu,new,icon,Topmost,% "HICON:* " opt_topmost? b64_2_hicon(pin48) : b64_2_hicon(move48),,48
	menu,NewSubMen_Pin,add,Pin to other window,MenHandla
	menu,NewSubMen_Pin,add,Pin to desktop,MenHandla
	menu,NewSubMen_Pin,add,Pin to desktop Perm,MenHandla
	menu,new,add,Bring-out Gimp,MenHandla
	menu,new,icon,Bring-out Gimp,% "C:\Icon\48\gimp48.ico",,48
	menu,new,add,Open containing,MenHandla
	menu,new,icon,Open containing,% "C:\Icon\48\EXPLORER_48.ico",,48
	menu,new,add,Copy path,MenHandla
	menu,new,icon,Copy path,% "C:\Icon\48\copy248.ico",,48
	menu,new,add,% _:= "Cut " . quote(Image_Title . "." . x10n),MenHandla
	menu,new,icon,% _,% "C:\Icon\48\ss_48.ico",,48
	menu,new,add,Delete ,MenHandla
	menu,new,icon,Delete,% "C:\Icon\ICON54_1.ico",,48
	menu,new,add,Move,MenHandla 
	menu,new,icon,Move,% "HICON:* " b64_2_hicon(move48),,48
	menu,new,add,Pin,:NewSubMen_Pin
	menu,new,add,Pin,MenHandla
	menu,new,icon,Pin,% "HICON:* " b64_2_hicon(pin48),,48
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
	tt("!ans")
	gosub,menus
	Menu,Tray,Show
	return
}
menus:
menu,Tray,deleteall
menu,Tray,NoStandard
menu,Tray,icon,% "C:\Script\AHK\z_ConTxt\imag3view4.ico"
menu,tray,icon

menu,Tray,Add,% "Open",MenHandla
menu,Tray,Icon,% "Open",% "C:\Icon\24\Gterminal_24_32.ico",,48
menu,Tray,Add,% "preserve position characteristics",MenHandla
menu,Tray,icon,% "Preserve Position Characteristics",% "HICON:* " (opt_movecenter? b64_2_hicon(amigtick) : b64_2_hicon(amigtick)),,48
menu,Tray,Add,% "Preserve offsets @ exit",MenHandla
menu,Tray,Icon,% "Preserve offsets @ exit",% (opt_preserveoffsets? "HICON:* " . b64_2_hicon(amigtick) : "HICON:* " b64_2_hicon(na48) ),,48
menu,Tray,add,Topmost,MenHandla
menu,Tray,icon,Topmost,%  "HICON:* " (opt_topmost? b64_2_hicon(pin48) : b64_2_hicon(move48)),,48
if(!A_IsCompiled) {
	menu,Tray,Add,% "Edit Script",MenHandla
	menu,Tray,Icon,% "Edit Script",% "C:\Icon\24\explorer24.ico",,48
}
menu,Tray,add,% _:=(greyscale? "Greyscale on" : "Greyscale off"),MenHandla
menu,Tray,Icon,% _,% r_:=(greyscale? "HICON:* " . b64_2_hicon(amigtick) : "C:\Icon\24\explorer24.ico"),,48
menu,Tray,add,% _:=(sepia? "sepia on" : "sepia off"),MenHandla
menu,Tray,Icon,% _,% r_:=(sepia? "HICON:* " . b64_2_hicon(amigtick) : "C:\Icon\24\explorer24.ico"),,48
menu,Tray,add,% _:=(alpha2greyscale1? "alpha2greyscale1 on" : "alpha2greyscale1 off"),MenHandla
menu,Tray,Icon,% _,% r_:=(alpha2greyscale1? "HICON:* " . b64_2_hicon(amigtick) : "C:\Icon\24\explorer24.ico"),,48
menu,Tray,add,% _:=(alpha2greyscale2? "alpha2greyscale2 on" : "alpha2greyscale2 off"),MenHandla
menu,Tray,Icon,% _,% r_:=(alpha2greyscale2? "HICON:* " . b64_2_hicon(amigtick) : "C:\Icon\24\explorer24.ico"),,48
menu,Tray,add,% _:=(invert? "invert on" : "invert off"),MenHandla
menu,Tray,Icon,% _,% r_:=(invert? "HICON:* " . b64_2_hicon(amigtick) : "C:\Icon\24\explorer24.ico"),,48

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
global hgui, Xcret10nnit, Image_Title, ImagePath, x10n, CURRENT_H, CURRENT_W, Pwner, pic_arr, Options, Hovered, OWin, OControl, hGui, Hovered, RECT, mdc, lbutton_click_thresh, rbutton_cooldown, Starting_file, OutNameNoExt, _i_ndx_, Max_i, Curr_i, Curr_iOld1, Curr_iOld2, Options, pic0, pic1, pic2, XCent, YCent, hi, wi, OPT_Recurse, OPT_topmost, OPT_MaxFill, OPT_preserveoffsets, OPT_brightness, OPT_Anchor, OPT_allCenter, OPT_ShrinkFill:=true, alignment, ren, Hovered, keys, _nx:=0, _ny:=0, _Netnx:=0, _Netny:=0, netnxold, netnyold, netxt, netyTemp, netx, nety, fTypes, keys, STrigga, _s:= " - ", exit, MatrixApply, matrix_, Image_dir, Curr_File, inp4th, oio, fucknugget, CurChanged, xs, ys, Launched, satwnd, iOld, AnimationMs, amigtick,na48

, r3gk3y:="HKCU\SOFTWARE\_MW\image_view", ID_VIEW_VARIABLES:=65407, ID_TRAY_EDITSCRIPT:=65304, ID_TRAY_SUSPEND:=65305, ID_TRAY_PAUSE:=65306.ID_TRAY_EXIT:=65307, ID_TRAY_RELOADSCRIPT:=65303, ndk, copy ;,  opt_movecenter:= True ;testing

, greyscale, sepia, alpha2greyscale, invert, alphamatrix1, alphamatrix2, rotate:= 0, r90cw, r90ccw, r180
,MatrixNegative:= "-1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|1|1|1|0|1"
,MatrixGreyScale:= "0.299|0.299|0.299|0|0|.587|.587|.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1"
alphamatrix1:= " 0 | 0 | 0 | 0 | 0 "
			. "| 0 | 0 | 0 | 0 | 0 "
			. "| 0 | 0 | 0 | 0 | 0 "
			. "|-.7| 0 |-.3| 25| 1 "
			. "|0.6|0.3|0.8|.25| 0 "
alphamatrix2:= " 0 | 0 | 0 | 0 | 0 "
			. "| 0 | 0 | 0 | 0 | 0 "
			. "| 0 | 0 | 0 | 0 | 0 "
			. "|-.5|-.5|-.5| 25| 1 "
			. "|.5|.5|.5| 0 | 0 "

alphamatrix3 :=( "1	|0	|0	|0	|0|"	;'``''getAncestors()
.				"0 	|1	|0	|0	|0|"	;``''`
.				"0	|0	|1	|0	|0|"	;`''`'A_ScripthWnd
.				"0	|0	|0	|1	|0|"	;''`'`
.				"0	|0	|0	|0	|1 " )

VarSetCapacity(RECT,16)
if(!ImagePath&&!FileExist(ImagePath:=A_AppData "\" ScriptName "\appifyerFrame.png"))
	ImagePath:= remoteResource("appifyerFrame.png", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Modern_AutoHotkey_Logo_%28no_text%29.svg/330px-Modern_AutoHotkey_Logo_%28no_text%29.svg.png")
gosub b64vars
donothing:
return,


Leave_:
dllcall("AnimateWindow","uint",hgui,"uint",AnimationMs*3,"uint",_:= (iOld>i)? 0x50002: 0x50009)
menu,tray,noicon

Gdip_shutdown(ptoken)
gosub,reg_WRite
 	sleep,500 
try { gui,pic:	hide
	gui,Pwner:	hide
	gui,Pic:	destroy
	gui,Pwner:	destroy
}
exitapp,
loop,4
	sleep,500
b64vars:
amigtick:="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"
na48:="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"
pin48:="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"
pin48.="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"

pin48.="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UABQAKAAIABAABAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAIAAAAEAAEACwACABcABQArAA4ASQAdAHgANQC/AFgA/wB5AP8AeQD/AHkA/wB5AP8AeQD/AHkA/wB5AP8AeQD/AHkA/wB5AP8AeQD/AHkA/wB5AP8AeQDBAFoAhAA7AFgAJQA5ABUAIwAKABMABAAJAAIABAABAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAQAAQAKAAIAFwAFACsADwBKAB4AeAA1ALoAVgD/AHkA/wB5AP8AeQD/AHkA/wB5AP8AeQD/AHkA/wB5AP8AeQD/AHkA/wB5APgAdQCxAFIAewA3AFMAIgA2ABQAIQAJABIABAAIAAIAAwABAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//////////////////////////////////////////////////////////////////A/////////wA////////+AA////////wAB///////+AAB///////4AAD/j/////AAAH4D////8AAAOAH////wAAAAAP////AAAAAAf///8AAAAAA////wAAAAAD////gAAAAAH///+AAAAAAf///4AAAAAA////wAAAAAD////gAAAAAP////AAAAAAf///8AAAAAB////4AAAAAD////wAAAAAH////gAAAAAP////AAAAAAP///8AAAAAAP///wAAAAAAf//+AAAAAAAf//4AAAAAAA///AAAAAAAB//8AAAAAAAH//gAAAAAAAP/+AAAAAAAAf/4AAAAAAAB//wAAAAAAAH//AAAAAAAAf/+AAAAAAAB//8AAAAAAAP//4AAAAAAA///wAAAAAAH///wAAAAAA////wAAAAAD////4AAAAAf////4AAAAD/////wAAAAf/////gAAAD//////AAAAf/////8AAAD//////4AAAf//////gAAD///////AAAf//////+AAD///////4AAf///////wAD////////gA/////////gH/////////B///////////////////////////////////8"
move48:="AAABAAEAMDAAAAEAIACoJQAAFgAAACgAAAAwAAAAYAAAAAEAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//0AA//9AAX//QABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD//QEC0bdTOKuCXpPFs0Mm//0BAv///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD//QAF4s9LXYxLavmmgVW4271aJv/9AAL///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD//QAG79RdZJ1Ef/99OFb+v4lpuOzAbSb//QAC////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD//QAG7tVdZKpIiP9xL07/hjxe/s+NebfuwnEm//0AAv///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD//QAG8tVcZL9Tk/+GOFv/ZCpE/5dEa/7WkIC28cN0Jv/9AAL///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP/9AAH//QAG+thiZNlkoP+2TXn/hThZ/301VP+0UX3+6JiLtvjHcyX//QAC////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP/9AAT//QAI//0ACP/9AAj//QAI//0ACP/9AAj//QAI//0ACP/9AAn//QAO/OBcaeN9pv/iZZT/yFWF/7dNev+3TXn/2mWU/vGgjbT81m0l//0AAv///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A//0ABf3ifnX96XWQ++t1lf3tcZX+7nCV/u9vlf7wb5X+8G+V/vBvlf7wb5X+8G2W/utoteqdpP/yeJz/73Sb/+pumf/kaZb/52mY/+6Anv73w4q0/+9kJP/9AAL///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A//0AC/zhj/v54ZP/+d+T//rdk//625P/+tiT//rWk//605T/+s+V//rKlf/5xJf/8rad/+6Cmv/ubZz/8XWc//F5nv/xe57/83yc//R+nP/xm53++dWFsv/uZCT//QAC////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A//0ADPnnkv/74ZD//deO//3Ikf/7vJP/+rOU//mqlf/4oZf/9peY//WNmf/zgpr/8Hab/+tnm//qZ5v/7Gqc/+5unP/tcp3/7nWb/+93mv/teZj/7KKY/vXMhbH73Wcj//0AAgAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A//0ADODXvP/u3K//+NKb//e6m//zn53/7Yqf/+d+oP/meaD/5nWg/+ZzoP/ncp//5nOd/990m//Uc5r/z3CY/85tkv/FaIv/vGOE/7Zge/+xXHT/sGBy/7h0ev7KoHSx5Nd4Iv/9AAH///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A//0ADO3v8P/p5dj/6dm6/+fNs//iwbH/27ay/9i2tv/burj/4MC5/+PGuf/pzbP/69C2/+XQwf/f0Mj/3tDG/+DQuv/dzLP/2ces/9zFm//fwoz/3r6G/9i8kP/cybb+8+3Ppv/9AAb///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A//0ADP789f/05Mz/8teq/+/Op//pyKr/6Mqr/+7Yr//057H/+PCu//r0rv/7+KL//Pel//zzsv/77rn/+uq0//vlp//526T/9c+l//XEnf/2uJf/8a2V/+Gzof/n0sb/8enZy//9AAf///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A//0ADP353f/43rX/+9eW//vSlv/5z5r/+tSZ//zklP/985L//faS//3ylf/97ZP//eaU//zdm//406D/9cuc//TClv/wtJP/5KGR/9mNjf/Peof/yHyG/9ywo//eyaz/tLCg5f/9AAL///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A//0ADP32t//52qz//Nag//zVoP/81Kb//dWm//7dnf/+6pX//e6V//7mlP/+2pL//c+T//vClv/yt5b/5q6Q/9uih//PlX//vYZ0/614af+ue2j/16iL/+PDmf+vqJPyoqGZMgAAAAD///8A/1OgONR0RP/RcEb/1GJN/9lTVf/dTGL/5UZu/+w+fP/uQYH/7kx4/+5Zb//sbmL/7IFS/+yURv/tnUX/3EF4/9w+dP/cPnT/3D50/9w+dP/cPnT/3T9z//74mv/96Zf//eeU//7nlf/+5J///+Gs///eq///3aL//t6e//7cmf/+1pT//tCS//y/kP/yq4n/4J58/82Qbv+7gmP/rnha/7J8WP/Zo3T/5LOJ/66lj/KhoZgy////AAAAAAD///8A/02dQb2XEP+bcgH/pF4Z/7JOMf/DRUP/2D1U/+0ydv/3OX3/8Uls/+xgV//ofUb/5Jgy/+CzDf/32hb/5yhg/9MGE//GBhP/xgYT/8YGE//GBhP/1QcT//fLlv/30ZH/99GR//jQkf/4z5X/+Myf//jJov/4wp3/+LqW//izkP/2rYz/9q6I//3Ghv/4sIb/5Zh5/8+Jav+6eVz/uXpW/92kaP/0o4r/vpOX/6CglzL///8A////AAAAAAD///8A/02dQb6YEP+JXwD/lVkQ/6ZRM/+5Skv/zEZh/94/ff/mRYH/41Z0/+BlZP/be1X/1ZFC/9y0Hf/75Rv/6DNt/7AHFv8vBxD/IAcQ/yAH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B/8HBwf/EgcM/4cHFP/mCy7/lE5l/////wD///8A////AAAAAAD///8A/02dQeW+EP+/kQ7/xoND/9R4Xv/kc3v/+nSh//9v0P//g9z//6PN//+0uv//w6P//9SE///xVv/++zL/6DNt/7AHFv8WBw7/BwcH/wcHB/8HBwf/BwcH/wcHB/8HBwf/BwcH/wcHB/8HBwf/BwcH/wcHB/8HBwf/BwcH/wcHB/8HBwf/BwcH/wcHB/8HBwf/BwcH/wcHB/8HBwf/EgcM/4cHFP/mCy7/lE5l/////wD///8A////AAAAAAD///8A/02dQenBEP/FlxH/zIdG/9t9Yv/yfYb//4Ct//992///j+f//6fS//+3vf//xab//9aG///yVv/++zL/6DNt/7AHFv8WBw7/CAcH/wgHB/8IBwf/CAcH/wgHB/8IBwf/CAcH/wgHB/8IBwf/CAcH/wgHB/8IBwf/CAcH/wgHB/8IBwf/CAcH/wgHB/8IBwf/CAcH/wgHB/8IBwf/EgcM/4cHFP/mCy7/lE5l/////wD///8A////AAAAAAD///8A/02dQezFEP/JmxX/1o9H/+6KZv/+ipL//4u6//+L4v//l+n//6jW//+5vv//yqL//9qE///yVv/++zL/6DNt/7AHFv8gBxD/GAcP/xgHD/8YBw//GAcP/xgHD/8YBw//GAcP/xgHD/8YBw//GAcP/xgHD/8YBw//GAcP/xgHD/8YBw//GAcP/xgHD/8YBw//GAcP/xgHD/8YBw//GAcP/4cHFP/mCy7/lE5l/////wD///8A////AAAAAAD///8A/02dQfDJEP/arBP/7Z88//6ZYv//lJj//5DJ//+G8f//jPP//6TZ//+9uv//0pf//+Vq///3Qf/++ij/5yhg/8sFE/+3BRL/twUS/7cFEv+3BRL/twUS/7cFEv+3BRL/twUS/7cFEv+3BRL/twUS/7cFEv+3BRL/twUS/7cFEv+3BRL/twUS/7cFEv+3BRL/twUS/7cFEv+3BRL/twUS/78FEv/mCy7/lE5l/////wD///8A////AAAAAAD///8A/1OgQPinQP/4pET/+5tc//uUf//7jKD/+4a///t11P/7edT/+4/F//uksP/7t5j/+8N5//vFTv/6wUT/6D17/+g5dP/oOXT/6Dl0/+g5dP/oOXT/6Dl0/+g5dP/oOXT/6Dl0/+g5dP/oOXT/6Dl0/+g5dP/oOXT/6Dl0/+g5dP/oOXT/6Dl0/+g5dP/oOXT/6Dl0/+g5dP/oOXT/6Dl0/+g5dP/oO3j/lE5l/////wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AAAAAAD/////x/8AAP////+D/wAA/////4H/AAD/////gP8AAP////+AfwAA/////4A/AAD/////AB8AAP///gAADwAA///8AAAHAAD///wAAAMAAP///AAAAQAA///8AAAAAAD///wAAAAAAP///AAAAAAA///8AAAAAAD///wAAAEAAIAAAAAAAwAAgAAAAAAHAACAAAAAAA8AAIAAAAAADwAAgAAAAAAPAACAAAAAAA8AAIAAAAAADwAAgAAAAAAPAACAAAAAAA8AAIAAAAAADwAAgAAAAAAPAACAAAAAAA8AAIAAAAAADwAAgAAAAAAPAACAAAAAAA8AAIAAAAAADwAAgAAAAAAPAAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAA"

return,