#include-once
#include<StructureConstants.au3>
#include"GDI\PrintConstants.au3"

Func _GDI_SIZEOF($tagStruct)
	Return DllStructGetSize(DllStructCreate($tagStruct,1))
EndFunc

;*********************************************************************************************
;*                               GDI Structures
;*********************************************************************************************

#Region Bitmap Structures
;   tagBITMAP
Global Const $tagBITMAP        =    'long     bmType;' & _
                                    'long     bmWidth;' & _
                                    'long     bmHeight;' & _
                                    'long     bmWidthBytes;' & _
                                    'ushort   bmPlanes;' & _
                                    'ushort   bmBitsPixel;'& _
                                    'ptr      bmBits;'

Global Const  $tagBITMAPCOREHEADER = _
  "DWORD   bcSize;" & _
  "USHORT  bcWidth;" & _
  "USHORT  bcHeight;" & _
  "USHORT  bcPlanes;" & _
  "USHORT  bcBitCount;"

Global Const $tagRGBTRIPLE = _
  "BYTE rgbtBlue;" & _
  "BYTE rgbtGreen;" & _
  "BYTE rgbtRed;"

Global Const $BITMAPCOREINFO = _
	$tagBITMAPCOREHEADER & _
	"byte bmciColors[" & _GDI_SIZEOF($tagRGBTRIPLE) & "]; "

Global Const $tagBITMAPFILEHEADER = _
  "USHORT  bfType;" & _
  "DWORD    bfSize;" & _
  "USHORT  bfReserved1;" & _
  "USHORT  bfReserved2;" & _
  "DWORD    bfOffBits;"

; tagBITMAPINFO in StructureConstants.au3

;   tagBITMAPINFOHEADER
Global Const $tagBITMAPINFOHEADER = "DWORD     biSize;" & _
                       "LONG     biWidth;" & _
                       "LONG     biHeight;" & _
                       "ushort     biPlanes;" & _
                       "ushort     biBitCount;" & _
                       "DWORD     biCompression;" & _
                       "DWORD     biSizeImage;" & _
                       "LONG     biXPelsPerMeter;" & _
                       "LONG     biYPelsPerMeter;" & _
                       "DWORD     biClrUsed;" & _
                       "DWORD     biClrImportant;"

; $tagBLENDFUNCTION in StructureConstants.au3


Global Const $FXPT2DOT30 = "LONG"
Global Const $tagCIEXYZ = "long ciexyzX; long ciexyzY; long ciexyzZ;"
Global Const $tagCIEXYZTRIPLE = _
  "LONG  ciexyzRed[3];" & _   ; CIEXYZ
  "LONG  ciexyzGreen[3];" & _ ; CIEXYZ
  "LONG  ciexyzBlue[3];"      ; CIEXYZ

Global Const $tagBITMAPV4HEADER = _
  "DWORD        bV4Size;" & _
  "LONG         bV4Width;" & _
  "LONG         bV4Height;" & _
  "USHORT         bV4Planes;" & _
  "USHORT         bV4BitCount;" & _
  "DWORD        bV4V4Compression;" & _
  "DWORD        bV4SizeImage;" & _
  "LONG         bV4XPelsPerMeter;" & _
  "LONG         bV4YPelsPerMeter;" & _
  "DWORD        bV4ClrUsed;" & _
  "DWORD        bV4ClrImportant;" & _
  "DWORD        bV4RedMask;" & _
  "DWORD        bV4GreenMask;" & _
  "DWORD        bV4BlueMask;" & _
  "DWORD        bV4AlphaMask;" & _
  "DWORD        bV4CSType;" & _
  "LONG bV4Endpoints[9];" & _ ; CIEXYZTRIPLE
  "DWORD        bV4GammaRed;" & _
  "DWORD        bV4GammaGreen;" & _
  "DWORD        bV4GammaBlue;"

Global Const $tagBITMAPV5HEADER = _
  "DWORD        bV5Size;" & _
  "LONG         bV5Width;" & _
  "LONG         bV5Height;" & _
  "USHORT         bV5Planes;" & _
  "USHORT         bV5BitCount;" & _
  "DWORD        bV5Compression;" & _
  "DWORD        bV5SizeImage;" & _
  "LONG         bV5XPelsPerMeter;" & _
  "LONG         bV5YPelsPerMeter;" & _
  "DWORD        bV5ClrUsed;" & _
  "DWORD        bV5ClrImportant;" & _
  "DWORD        bV5RedMask;" & _
  "DWORD        bV5GreenMask;" & _
  "DWORD        bV5BlueMask;" & _
  "DWORD        bV5AlphaMask;" & _
  "DWORD        bV5CSType;" & _
  "byte bV5Endpoints[36];" & _ ; CIEXYZTRIPLE
  "DWORD        bV5GammaRed;" & _
  "DWORD        bV5GammaGreen;" & _
  "DWORD        bV5GammaBlue;" & _
  "DWORD        bV5Intent;" & _
  "DWORD        bV5ProfileData;" & _
  "DWORD        bV5ProfileSize;" & _
  "DWORD        bV5Reserved;"

Global Const $tagCOLORADJUSTMENT = _
  "USHORT  caSize;" & _
  "USHORT  caFlags;" & _
  "USHORT  caIlluminantIndex;" & _
  "USHORT  caRedGamma;" & _
  "USHORT  caGreenGamma;" & _
  "USHORT  caBlueGamma;" & _
  "USHORT  caReferenceBlack;" & _
  "USHORT  caReferenceWhite;" & _
  "SHORT caContrast;" & _
  "SHORT caBrightness;" & _
  "SHORT caColorfulness;" & _
  "SHORT caRedGreenTint;"

;   tagGRADIENT_RECT
Global Const $tagGRADIENT_RECT = 'ulong UpperLeft;' & _
                                 'ulong LowerRight;'
;   tagTRIVERTEX
Global Const $tagGRADIENT_TRIANGLE = 'ulong Vertex1;' & _
                                     'ulong Vertex2;' & _
                                     'ulong Vertex3;'

Global Const $tagRGBQUAD = _
  "BYTE rgbBlue;" & _
  "BYTE rgbGreen;" & _
  "BYTE rgbRed;" & _
  "BYTE rgbReserved;"

; $tagSIZE In StructureConstants.au3

;   tagTRIVERTEX
Global Const $tagTRIVERTEX = 'long   x;' & _
                             'long   y;' & _
                             'ushort Red;' & _
                             'ushort Green;' & _
                             'ushort Blue;' & _
                             'ushort Alpha;'

#EndRegion Bitmap Structures

#Region Color Structs
Global Const $tagPALETTEENTRY = _
  "BYTE peRed;" & _
  "BYTE peGreen;" & _
  "BYTE peBlue;" & _
  "BYTE peFlags;"

Global Const $tagLOGPALETTE = _
  "USHORT         palVersion;" & _
  "USHORT         palNumEntries;" & _
  $tagPALETTEENTRY ;PALETTEENTRY palPalEntry[1];

#EndRegion Color Structs


#Region Brush Structures
Global Const $tagLOGBRUSH = _
  "UINT     lbStyle;" & _
  "DWORD    lbColor;" & _
  "LONG     lbHatch;"

Global Const $tagLOGBRUSH32 =  _
  "UINT     lbStyle;" & _
  "DWORD    lbColor;" & _
  "LONG     lbHatch;"

#EndRegion Brush structures

#Region Font and Text Structures

;   tagDRAWTEXTPARAMS
Global Const $tagDRAWTEXTPARAMS = _
			"UINT cbSize; " & _
			"int  iTabLength; " & _
			"int  iLeftMargin; " & _
			"int  iRightMargin; " & _
			"UINT uiLengthDrawn; "

#EndRegion Font and Text Structures

#Region DeviceContext Structures
; $tagDISPLAY_DEVICE in StructureConstants.au3

Global Const $tagDISPLAY_DEVICEW =   "DWORD cb;" & _
  "WCHAR DeviceName[32];" & _
  "WCHAR DeviceString[128];" & _
  "DWORD StateFlags;" & _
  "WCHAR DeviceID[128];" & _
  "WCHAR DeviceKey[128];"


Global Const $tagVIDEOPARAMETERS = _
  "byte  guid[" & _GDI_SIZEOF($tagGUID) & "]; " & _
  "ULONG dwOffset; " & _
  "ULONG dwCommand; " & _
  "ULONG dwFlags; " & _
  "ULONG dwMode; " & _
  "ULONG dwTVStandard; " & _
  "ULONG dwAvailableModes; " & _
  "ULONG dwAvailableTVStandard; " & _
  "ULONG dwFlickerFilter; " & _
  "ULONG dwOverScanX; " & _
  "ULONG dwOverScanY; " & _
  "ULONG dwMaxUnscaledX; " & _
  "ULONG dwMaxUnscaledY; " & _
  "ULONG dwPositionX; " & _
  "ULONG dwPositionY; " & _
  "ULONG dwBrightness; " & _
  "ULONG dwContrast; " & _
  "ULONG dwCPType; " & _
  "ULONG dwCPCommand; " & _
  "ULONG dwCPStandard; " & _
  "ULONG dwCPKey; " & _
  "ULONG bCP_APSTriggerBits; " & _
  "UBYTE bOEMCopyProtection[256];"

#EndRegion DeviceCOntext

#Region Pen Structures

Global Const $tagLOGPEN = _
  "UINT     lopnStyle;" & _
  "INT    lopnWidth[2];" & _
  "DWORD lopnColor;"

#EndRegion Pen Structures

#Region Printing Structures

Global Const $tagDOCINFO = _
		"int     cbSize; " & _
		"ptr lpszDocName; " & _  ; LPCTSTR
		"ptr lpszOutput; " & _   ; LPCTSTR
		"ptr lpszDatatype; " & _ ; LPCTSTR
		"DWORD   fwType; "

Global $Printer_devicemode = _
		"WCHAR  dmDeviceName[32]; " & _
		"ushort   dmSpecVersion; " & _
		"ushort   dmDriverVersion; " & _
		"ushort   dmSize; " & _
		"ushort   dmDriverExtra; " & _
		"DWORD  dmFields; " & _
		"short dmOrientation;" & _
		"short dmPaperSize;" & _
		"short dmPaperLength;" & _
		"short dmPaperWidth;" & _
		"short dmScale; " & _
		"short dmCopies; " & _
		"short dmDefaultSource; " & _
		"short dmPrintQuality; " & _
		"short  dmColor; " & _
		"short  dmDuplex; " & _
		"short  dmYResolution; " & _
		"short  dmTTOption; " & _
		"short  dmCollate; " & _
		"WCHAR  dmFormName[32]; " & _
		"ushort  dmLogPixels; " & _
		"DWORD  dmBitsPerPel; " & _
		"DWORD  dmPelsWidth; " & _
		"DWORD  dmPelsHeight; " & _
		"DWORD  dmDisplayFlags; " & _ ;DWORD  dmNup;
		"DWORD  dmDisplayFrequency; "
If @OSTYPE = "WIN32_NT" Then
	$Printer_devicemode &= "DWORD  dmICMMethod;" & _
			"DWORD  dmICMIntent;" & _
			"DWORD  dmMediaType;" & _
			"DWORD  dmDitherType;" & _
			"DWORD  dmReserved1;" & _
			"DWORD  dmReserved2;" & _ ;#if (WINVER >= 0x0500) || (_WIN32_WINNT >= 0x0400)
			"DWORD  dmPanningWidth;" & _
			"DWORD  dmPanningHeight;"
;~ #endif
EndIf
;~ } DEVMODE;
Global Const $tagDEVMODE = $Printer_devicemode

Global Const $tagPD = "align 1;" & _
		"DWORD lStructSize;" & _
		"hwnd hwndOwner;" & _
		"hwnd hDevMode;" & _
		"hwnd hDevNames;" & _
		"hwnd hDC;" & _
		"DWORD Flags;" & _
		"ushort nFromPage;" & _
		"ushort nToPage;" & _
		"ushort nMinPage;" & _
		"ushort nMaxPage;" & _
		"ushort nCopies;" & _
		"hwnd hInstance;" & _
		"dword lCustData;" & _
		"ptr lpfnPrintHook;" & _
		"ptr lpfnSetupHook;" & _
		"ptr lpPrintTemplateName;" & _
		"ptr lpSetupTemplateName;" & _
		"hwnd hPrintTemplate;" & _
		"hwnd hSetupTemplate"

;~     "DWORD lStructSize;" & _
;~     "HWND hwndOwner;" & _
;~     "HGLOBAL hDevMode;" & _
;~     "HGLOBAL hDevNames;" & _
;~     "HDC hDC;" & _
;~     "DWORD Flags;" & _
;~     "WORD nFromPage;" & _
;~     "WORD nToPage;" & _
;~     "WORD nMinPage;" & _
;~     "WORD nMaxPage;" & _
;~     "WORD nCopies;" & _
;~     "HINSTANCE hInstance;" & _
;~     "LPARAM lCustData;" & _
;~     "LPPRINTHOOKPROC lpfnPrintHook;" & _
;~     "LPSETUPHOOKPROC lpfnSetupHook;" & _
;~     "LPCTSTR lpPrintTemplateName;" & _
;~     "LPCTSTR lpSetupTemplateName;" & _
;~     "HGLOBAL hPrintTemplate;" & _
;~     "HGLOBAL hSetupTemplate;"

Global Const $tagPDEX = "align 1;" & _
		"DWORD lStructSize;" & _
		"hwnd hwndOwner;" & _
		"hwnd hDevMode;" & _
		"hwnd hDevNames;" & _
		"hwnd hDC;" & _
		"DWORD Flags;" & _
		"DWORD Flags2;" & _
		"DWORD ExclusionFlags;" & _
		"DWORD nPageRanges;" & _
		"DWORD nMaxPageRanges;" & _
		"ptr lpPageRanges;" & _
		"DWORD nMinPage;" & _
		"DWORD nMaxPage;" & _
		"DWORD nCopies;" & _
		"hwnd hInstance;" & _
		"ptr lpPrintTemplateName;" & _
		"ptr lpCallback;" & _
		"DWORD nPropertyPages;" & _
		"ptr lphPropertyPages;" & _
		"DWORD nStartPage;" & _
		"DWORD dwResultAction;"
Global Const $tagPRINTPAGERANGE = "DWORD nFromPage; DWORD nToPage;"
#EndRegion Printing Structures

Global Const $tagPAINTSTRUCT            =    'hwnd hDC;' & _
                                    'int  fErase;' & _
                                    'long rcPaint[4];' & _
                                    'int  fRestore;' & _
                                    'int  fIncUpdate;' & _
                                    'byte rgbReserved[32];'


Global Const $XFORM = _
		"FLOAT eM11; " & _
		"FLOAT eM12; " & _
		"FLOAT eM21; " & _
		"FLOAT eM22; " & _
		"FLOAT eDx; " & _
		"FLOAT eDy; "

Global Const $tagLOGFONTA = "int Height;int Width;int Escapement;int Orientation;int Weight;byte Italic;byte Underline;byte Strikeout;byte CharSet;byte OutPrecision;byte ClipPrecision;byte Quality;byte PitchAndFamily;char FaceName[32];"
Global Const $tagLOGFONTW = "int Height;int Width;int Escapement;int Orientation;int Weight;byte Italic;byte Underline;byte Strikeout;byte CharSet;byte OutPrecision;byte ClipPrecision;byte Quality;byte PitchAndFamily;wchar FaceName[32];"
Global Const $tagENUMLOGFONTEXA = $tagLOGFONTA & _
				"CHAR  elfFullName[64];" & _ ;LF_FULLFACESIZE
				"CHAR  elfStyle[32];" & _ ; LF_FACESIZE
				"CHAR  elfScript[32];" ; LF_FACESIZE
Global Const $tagENUMLOGFONTEXW = $tagLOGFONTW & _
				"WCHAR  elfFullName[64];" & _ ;LF_FULLFACESIZE
				"WCHAR  elfStyle[32];" & _ ; LF_FACESIZE
				"WCHAR  elfScript[32];" ; LF_FACESIZE
Global Const $tagENUMLOGFONTEX =$tagENUMLOGFONTEXW

Global Const $tagDESIGNVECTOR = "DWORD dvReserved; DWORD dvNumAxes; LONG  dvValues[16]; " ; 16 = MM_MAX_NUMAXES
Global Const $tagENUMLOGFONTEXDVW = $tagENUMLOGFONTEXW & $tagDESIGNVECTOR
Global Const $tagENUMLOGFONTEXDVA = $tagENUMLOGFONTEXA & $tagDESIGNVECTOR
Global Const $tagENUMLOGFONTEXDV = $tagENUMLOGFONTEXDVW
