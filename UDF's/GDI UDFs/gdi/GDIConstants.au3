;*********************************************************************************************
;*                               GDI Constants
;*********************************************************************************************
#include-once
#include "GDI\Macros.au3"
#include <FontConstants.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#include "GDI\PrintConstants.au3"

Global Const $GDI_ERROR = 0xFFFF




;~ Global Const $PS_SOLID = 0
;~ Global Const $PS_DASH = 1
;~ Global Const $PS_DOT = 2
;~ Global Const $PS_DASHDOT = 3
;~ Global Const $PS_DASHDOTDOT = 4
;~ Global Const $PS_NULL = 5
;~ Global Const $PS_INSIDEFRAME = 6
Global Const $AD_COUNTERCLOCKWISE = 1
Global Const $AD_CLOCKWISE = 2



Global Const $HALFTONE = 4
Global Const $BLACKONWHITE = 1
Global Const $COLORONCOLOR = 3
Global Const $STRETCH_ANDSCANS = 1
Global Const $STRETCH_DELETESCANS = 3
Global Const $STRETCH_HALFTONE = 4
Global Const $STRETCH_ORSCANS = 2
Global Const $WHITEONBLACK = 2
; /* Region Constants */
;~ Global Const $ERROR = 0
;~ Global Const $NULLREGION = 1
;~ Global Const $COMPLEXREGION = 3
;~ Global Const $SIMPLEREGION = 2

; /* Polygon Filling Modes */
Global Const $ALTERNATE = 1
Global Const $WINDING = 2

; /* DrawText Modes */
;~ Global Const $DT_HIDEPREFIX = 0x100000   ; declared in WinAPI
;~ Global Const $DT_PATH_ELLIPSIS = 0x4000   ; declared in WinAPI
;~ Global Const $DT_NOFULLWIDTHCHARBREAK = 0x80000   ; declared in WinAPI
;~ Global Const $DT_PREFIXONLY = 0x200000   ; declared in WinAPI
;~ Global Const $DT_WORD_ELLIPSIS = 0x40000   ; declared in WinAPI

;~ Global Const $DT_EDITCONTROL =	8192   ; declared in WinAPI
;~ Global Const $DT_END_ELLIPSIS =	32768   ; declared in WinAPI
;~ Global Const $DT_MODIFYSTRING =	65536  ; declared in WinAPI
;~ Global Const $DT_RTLREADING =	131072  ; declared in WinAPI

; /* Metric Mapping Modes */
Global Const $MM_TEXT            = 1
Global Const $MM_LOMETRIC        = 2
Global Const $MM_HIMETRIC        = 3
Global Const $MM_LOENGLISH       = 4
Global Const $MM_HIENGLISH       = 5
Global Const $MM_TWIPS           = 6
Global Const $MM_ISOTROPIC       = 7
Global Const $MM_ANISOTROPIC     = 8
; /* gradient drawing modes */
Global Const $GRADIENT_FILL_RECT_H    =  0x00000000
Global Const $GRADIENT_FILL_RECT_V    =  0x00000001
Global Const $GRADIENT_FILL_TRIANGLE  =  0x00000002
Global Const $GRADIENT_FILL_OP_FLAG   =  0x000000FF


Global Const $GM_ADVANCED = 2
Global Const $GM_COMPATIBLE = 1

;~ $MM_ANISOTROPIC  ; declared in WinAPI
;~ $MM_HIENGLISH    ; declared in WinAPI
;~ $MM_HIMETRIC     ; declared in WinAPI
;~ $MM_ISOTROPIC; declared in WinAPI
;~ $MM_LOENGLISH    ; declared in WinAPI
;~ $MM_LOMETRIC     ; declared in WinAPI
;~ $MM_TEXT         ; declared in WinAPI
;~ $MM_TWIPS  ; declared in WinAPI

Global Const $MWT_IDENTITY = 1
Global Const $MWT_LEFTMULTIPLY = 2
Global Const $MWT_RIGHTMULTIPLY = 3
Global Const $MWT_MAX  = $MWT_RIGHTMULTIPLY
Global Const $MWT_MIN = $MWT_IDENTITY

Global Const $BI_RGB =0
Global Const $DIB_PAL_COLORS = 1
Global Const $DIB_PAL_INDICES = 2
Global Const $DIB_PAL_LOGINDICES = 4
Global Const $DIB_PAL_PHYSINDICES = 2
Global Const $DIB_RGB_COLORS = 0


Global Const $AC_SRC_OVER=0
Global Const $AC_SRC_ALPHA=1

Global Const $CBM_INIT = 0x4

;~ Global Const $CLR_DEFAULT = 0xFF000000
Global Const $CLR_HILIGHT = $CLR_DEFAULT
If Not IsDeclared('CLR_INVALID') Then Global Const $CLR_INVALID = 0xFFFF
;~ Global Const $CLR_NONE = 0xFFFFFFFF

;-- Font Constants ------
#Region Font Constants
Global Const $FR_PRIVATE = 0x10
Global Const $FR_NOT_ENUM = 0x20
#EndRegion Font Constants
; -----------------------

;-- Clipping Constants --
#Region Clipping Constants
Global Const $SYSRGN = 4
#EndRegion Clipping Constants
;------------------------

;-- Colors Constants ----
#Region Color Constants
Global Const $SYSPAL_ERROR = 0
Global Const $SYSPAL_NOSTATIC256 = 3
Global Const $SYSPAL_NOSTATIC = 2
Global Const $SYSPAL_STATIC = 1

#EndRegion Color Constants
;------------------------

;-- DC Constants ----
#Region DC Constants
Global Const $VP_COMMAND_GET = 0x1
Global Const $VP_COMMAND_SET = 0x2
Global Const $VP_CP_CMD_ACTIVATE = 0x1
Global Const $VP_CP_CMD_CHANGE = 0x4
Global Const $VP_CP_CMD_DEACTIVATE = 0x2
Global Const $VP_CP_TYPE_APS_TRIGGER = 0x1
Global Const $VP_CP_TYPE_MACROVISION = 0x2
Global Const $VP_FLAGS_BRIGHTNESS = 0x40
Global Const $VP_FLAGS_CONTRAST = 0x80
Global Const $VP_FLAGS_COPYPROTECT = 0x100
Global Const $VP_FLAGS_FLICKER = 0x4
Global Const $VP_FLAGS_MAX_UNSCALED = 0x10
Global Const $VP_FLAGS_OVERSCAN = 0x8
Global Const $VP_FLAGS_POSITION = 0x20
Global Const $VP_FLAGS_TV_MODE = 0x1
Global Const $VP_FLAGS_TV_STANDARD = 0x2
Global Const $VP_MODE_TV_PLAYBACK = 0x2
Global Const $VP_MODE_WIN_GRAPHICS = 0x1
Global Const $VP_TV_STANDARD_NTSC_433 = 0x10000
Global Const $VP_TV_STANDARD_NTSC_M = 0x1
Global Const $VP_TV_STANDARD_NTSC_M_J = 0x2
Global Const $VP_TV_STANDARD_PAL_60 = 0x40000
Global Const $VP_TV_STANDARD_PAL_B = 0x4
Global Const $VP_TV_STANDARD_PAL_D = 0x8
Global Const $VP_TV_STANDARD_PAL_G = 0x20000
Global Const $VP_TV_STANDARD_PAL_H = 0x10
Global Const $VP_TV_STANDARD_PAL_I = 0x20
Global Const $VP_TV_STANDARD_PAL_M = 0x40
Global Const $VP_TV_STANDARD_PAL_N = 0x80
Global Const $VP_TV_STANDARD_SECAM_B = 0x100
Global Const $VP_TV_STANDARD_SECAM_D = 0x200
Global Const $VP_TV_STANDARD_SECAM_G = 0x400
Global Const $VP_TV_STANDARD_SECAM_H = 0x800
Global Const $VP_TV_STANDARD_SECAM_K = 0x1000
Global Const $VP_TV_STANDARD_SECAM_K1 = 0x2000
Global Const $VP_TV_STANDARD_SECAM_L = 0x4000
Global Const $VP_TV_STANDARD_SECAM_L1 = 0x80000
Global Const $VP_TV_STANDARD_WIN_VGA = 0x8000

; the DM_... cosntants are already defined.

Global Const $CDS_FULLSCREEN = 0x4
Global Const $CDS_GLOBAL = 0x8
Global Const $CDS_NORESET = 0x10000000
Global Const $CDS_RESET = 0x40000000
Global Const $CDS_SET_PRIMARY = 0x10
Global Const $CDS_TEST = 0x2
Global Const $CDS_UPDATEREGISTRY = 0x1
Global Const $CDS_VIDEOPARAMETERS = 0x20

Global Const $DISP_CHANGE_BADFLAGS = -4
Global Const $DISP_CHANGE_BADMODE = -2
Global Const $DISP_CHANGE_BADPARAM = -5
Global Const $DISP_CHANGE_FAILED = -1
Global Const $DISP_CHANGE_NOTUPDATED = -3
Global Const $DISP_CHANGE_RESTART = 1
Global Const $DISP_CHANGE_SUCCESSFUL = 0

Global Const $OBJ_BITMAP = 7
Global Const $OBJ_BRUSH = 2
Global Const $OBJ_COLORSPACE = 14
Global Const $OBJ_DC = 3
Global Const $OBJ_ENHMETADC = 12
Global Const $OBJ_ENHMETAFILE = 13
Global Const $OBJ_EXTPEN = 11
Global Const $OBJ_FONT = 6
Global Const $OBJ_MEMDC = 10
Global Const $OBJ_METADC = 4
Global Const $OBJ_METAFILE = 9
Global Const $OBJ_PAL = 5
Global Const $OBJ_PEN = 1
Global Const $OBJ_REGION = 8

Global Const $EDS_RAWMODE = 1

Global Const $ENUM_CURRENT_SETTINGS = (-1)
Global Const $ENUM_REGISTRY_SETTINGS = (-2)

Global Const $DISPLAY_DEVICE_ACTIVE           = 0x00000001
;~ Global Const $DISPLAY_DEVICE_ATTACHED_TO_DESKTOP = $DISPLAY_DEVICE_ACTIVE
;~ Global Const $DISPLAY_DEVICE_MULTI_DRIVER     = 0x00000002
;~ Global Const $DISPLAY_DEVICE_PRIMARY_DEVICE   = 0x00000004
;~ Global Const $DISPLAY_DEVICE_MIRRORING_DRIVER = 0x00000008
;~ Global Const $DISPLAY_DEVICE_VGA_COMPATIBLE   = 0x00000010
;~ Global Const $DISPLAY_DEVICE_REMOVABLE        = 0x00000020
;~ Global Const $DISPLAY_DEVICE_MODESPRUNED      = 0x08000000



#EndRegion DC Constants
;------------------------

;/* Device Parameters for GetDeviceCaps() */
Global Const $DRIVERVERSION = 0     ;/* Device driver version                    */
Global Const $TECHNOLOGY    = 2     ;/* Device classification                    */
Global Const $HORZSIZE      = 4     ;/* Horizontal size in millimeters           */
Global Const $VERTSIZE      = 6     ;/* Vertical size in millimeters             */
Global Const $HORZRES       = 8     ;/* Horizontal width in pixels               */
Global Const $VERTRES       = 10    ;/* Vertical height in pixels                */
Global Const $BITSPIXEL     = 12    ;/* Number of bits per pixel                 */
Global Const $PLANES        = 14    ;/* Number of planes                         */
Global Const $NUMBRUSHES    = 16    ;/* Number of brushes the device has         */
Global Const $NUMPENS       = 18    ;/* Number of pens the device has            */
Global Const $NUMMARKERS    = 20    ;/* Number of markers the device has         */
Global Const $NUMFONTS      = 22    ;/* Number of fonts the device has           */
Global Const $NUMCOLORS     = 24    ;/* Number of colors the device supports     */
Global Const $PDEVICESIZE   = 26    ;/* Size required for device descriptor      */
Global Const $CURVECAPS     = 28    ;/* Curve capabilities                       */
Global Const $LINECAPS      = 30    ;/* Line capabilities                        */
Global Const $POLYGONALCAPS = 32    ;/* Polygonal capabilities                   */
Global Const $TEXTCAPS      = 34    ;/* Text capabilities                        */
Global Const $CLIPCAPS      = 36    ;/* Clipping capabilities                    */
Global Const $RASTERCAPS    = 38    ;/* Bitblt capabilities                      */
Global Const $ASPECTX       = 40    ;/* Length of the X leg                      */
Global Const $ASPECTY       = 42    ;/* Length of the Y leg                      */
Global Const $ASPECTXY      = 44    ;/* Length of the hypotenuse                 */

;~ Global Const $LOGPIXELSX    = 88    ;/* Logical pixels/inch in X                 */
;~ Global Const $LOGPIXELSY    = 90    ;/* Logical pixels/inch in Y                 */

Global Const $SIZEPALETTE  = 104    ;/* Number of entries in physical palette    */
Global Const $NUMRESERVED  = 106    ;/* Number of reserved entries in palette    */
Global Const $COLORRES     = 108    ;/* Actual color resolution                  */

;~ // Printing related DeviceCaps. These replace the appropriate Escapes

Global Const $PHYSICALWIDTH   = 110 ;/* Physical Width in device units           */
Global Const $PHYSICALHEIGHT  = 111 ;/* Physical Height in device units          */
Global Const $PHYSICALOFFSETX = 112 ;/* Physical Printable Area x margin         */
Global Const $PHYSICALOFFSETY = 113 ;/* Physical Printable Area y margin         */
Global Const $SCALINGFACTORX  = 114 ;/* Scaling factor x                         */
Global Const $SCALINGFACTORY  = 115 ;/* Scaling factor y                         */

;~ // Display driver specific

Global Const $VREFRESH        = 116  ;/* Current vertical refresh rate of the    */
                             ;/* display device (for displays only) in Hz*/
Global Const $DESKTOPVERTRES  = 117  ;/* Horizontal width of entire desktop in   */
                             ;/* pixels                                  */
Global Const $DESKTOPHORZRES  = 118  ;/* Vertical height of entire desktop in    */
                             ;/* pixels                                  */
Global Const $BLTALIGNMENT    = 119  ;/* Preferred blt alignment                 */

;#if(WINVER >= 0x0500)
Global Const $SHADEBLENDCAPS  = 120  ;/* Shading and blending caps               */
Global Const $COLORMGMTCAPS   = 121  ;/* Color Management caps                   */
;#endif ;/* WINVER >= 0x0500 */

;#ifndef NOGDICAPMASKS

;/* Device Capability Masks: */

;/* Device Technologies */
Global Const $DT_PLOTTER          = 0   ;/* Vector plotter                   */
Global Const $DT_RASDISPLAY       = 1   ;/* Raster display                   */
Global Const $DT_RASPRINTER       = 2   ;/* Raster printer                   */
Global Const $DT_RASCAMERA        = 3   ;/* Raster camera                    */
Global Const $DT_CHARSTREAM       = 4   ;/* Character-stream, PLP            */
Global Const $DT_METAFILE         = 5   ;/* Metafile, VDM                    */
Global Const $DT_DISPFILE         = 6   ;/* Display-file                     */

;/* Curve Capabilities */
Global Const $CC_NONE             = 0   ;/* Curves not supported             */
Global Const $CC_CIRCLES          = 1   ;/* Can do circles                   */
Global Const $CC_PIE              = 2   ;/* Can do pie wedges                */
Global Const $CC_CHORD            = 4   ;/* Can do chord arcs                */
Global Const $CC_ELLIPSES         = 8   ;/* Can do ellipese                  */
Global Const $CC_WIDE             = 16  ;/* Can do wide lines                */
Global Const $CC_STYLED           = 32  ;/* Can do styled lines              */
Global Const $CC_WIDESTYLED       = 64  ;/* Can do wide styled lines         */
Global Const $CC_INTERIORS        = 128 ;/* Can do interiors                 */
Global Const $CC_ROUNDRECT        = 256 ;/*                                  */

;/* Line Capabilities */
Global Const $LC_NONE             = 0   ;/* Lines not supported              */
Global Const $LC_POLYLINE         = 2   ;/* Can do polylines                 */
Global Const $LC_MARKER           = 4   ;/* Can do markers                   */
Global Const $LC_POLYMARKER       = 8   ;/* Can do polymarkers               */
Global Const $LC_WIDE             = 16  ;/* Can do wide lines                */
Global Const $LC_STYLED           = 32  ;/* Can do styled lines              */
Global Const $LC_WIDESTYLED       = 64  ;/* Can do wide styled lines         */
Global Const $LC_INTERIORS        = 128 ;/* Can do interiors                 */

;/* Polygonal Capabilities */
Global Const $PC_NONE             = 0   ;/* Polygonals not supported         */
Global Const $PC_POLYGON          = 1   ;/* Can do polygons                  */
Global Const $PC_RECTANGLE        = 2   ;/* Can do rectangles                */
Global Const $PC_WINDPOLYGON      = 4   ;/* Can do winding polygons          */
Global Const $PC_TRAPEZOID        = 4   ;/* Can do trapezoids                */
Global Const $PC_SCANLINE         = 8   ;/* Can do scanlines                 */
Global Const $PC_WIDE             = 16  ;/* Can do wide borders              */
Global Const $PC_STYLED           = 32  ;/* Can do styled borders            */
Global Const $PC_WIDESTYLED       = 64  ;/* Can do wide styled borders       */
Global Const $PC_INTERIORS        = 128 ;/* Can do interiors                 */
Global Const $PC_POLYPOLYGON      = 256 ;/* Can do polypolygons              */
Global Const $PC_PATHS            = 512 ;/* Can do paths                     */

;/* Clipping Capabilities */
Global Const $CP_NONE             = 0   ;/* No clipping of output            */
Global Const $CP_RECTANGLE        = 1   ;/* Output clipped to rects          */
Global Const $CP_REGION           = 2   ;/* obsolete                         */

;/* Text Capabilities */
Global Const $TC_OP_CHARACTER     = 0x00000001  ;/* Can do OutputPrecision   CHARACTER      */
Global Const $TC_OP_STROKE        = 0x00000002  ;/* Can do OutputPrecision   STROKE         */
Global Const $TC_CP_STROKE        = 0x00000004  ;/* Can do ClipPrecision     STROKE         */
Global Const $TC_CR_90            = 0x00000008  ;/* Can do CharRotAbility    90             */
Global Const $TC_CR_ANY           = 0x00000010  ;/* Can do CharRotAbility    ANY            */
Global Const $TC_SF_X_YINDEP      = 0x00000020  ;/* Can do ScaleFreedom      X_YINDEPENDENT */
Global Const $TC_SA_DOUBLE        = 0x00000040  ;/* Can do ScaleAbility      DOUBLE         */
Global Const $TC_SA_INTEGER       = 0x00000080  ;/* Can do ScaleAbility      INTEGER        */
Global Const $TC_SA_CONTIN        = 0x00000100  ;/* Can do ScaleAbility      CONTINUOUS     */
Global Const $TC_EA_DOUBLE        = 0x00000200  ;/* Can do EmboldenAbility   DOUBLE         */
Global Const $TC_IA_ABLE          = 0x00000400  ;/* Can do ItalisizeAbility  ABLE           */
Global Const $TC_UA_ABLE          = 0x00000800  ;/* Can do UnderlineAbility  ABLE           */
Global Const $TC_SO_ABLE          = 0x00001000  ;/* Can do StrikeOutAbility  ABLE           */
Global Const $TC_RA_ABLE          = 0x00002000  ;/* Can do RasterFontAble    ABLE           */
Global Const $TC_VA_ABLE          = 0x00004000  ;/* Can do VectorFontAble    ABLE           */
Global Const $TC_RESERVED         = 0x00008000
Global Const $TC_SCROLLBLT        = 0x00010000  ;/* Don't do text scroll with blt           */

;#endif ;/* NOGDICAPMASKS */

;/* Raster Capabilities */
Global Const $RC_NONE             = 0
Global Const $RC_BITBLT           = 1       ;/* Can do standard BLT.             */
Global Const $RC_BANDING          = 2       ;/* Device requires banding support  */
Global Const $RC_SCALING          = 4       ;/* Device requires scaling support  */
Global Const $RC_BITMAP64         = 8       ;/* Device can support >64K bitmap   */
Global Const $RC_GDI20_OUTPUT     = 0x0010      ;/* has 2.0 output calls         */
Global Const $RC_GDI20_STATE      = 0x0020
Global Const $RC_SAVEBITMAP       = 0x0040
Global Const $RC_DI_BITMAP        = 0x0080      ;/* supports DIB to memory       */
Global Const $RC_PALETTE          = 0x0100      ;/* supports a palette           */
Global Const $RC_DIBTODEV         = 0x0200      ;/* supports DIBitsToDevice      */
Global Const $RC_BIGFONT          = 0x0400      ;/* supports >64K fonts          */
Global Const $RC_STRETCHBLT       = 0x0800      ;/* supports StretchBlt          */
Global Const $RC_FLOODFILL        = 0x1000      ;/* supports FloodFill           */
Global Const $RC_STRETCHDIB       = 0x2000      ;/* supports StretchDIBits       */
Global Const $RC_OP_DX_OUTPUT     = 0x4000
Global Const $RC_DEVBITS          = 0x8000

;#if(WINVER >= 0x0500)

;/* Shading and blending caps */
Global Const $SB_NONE             = 0x00000000
Global Const $SB_CONST_ALPHA      = 0x00000001
Global Const $SB_PIXEL_ALPHA      = 0x00000002
Global Const $SB_PREMULT_ALPHA    = 0x00000004

Global Const $SB_GRAD_RECT        = 0x00000010
Global Const $SB_GRAD_TRI         = 0x00000020

;/* Color Management caps */
Global Const $CM_NONE             = 0x00000000
Global Const $CM_DEVICE_ICM       = 0x00000001
Global Const $CM_GAMMA_RAMP       = 0x00000002
Global Const $CM_CMYK_COLOR       = 0x00000004

;#endif ;/* WINVER >= 0x0500 */


;/* DIB color table identifiers */

;~ Global Const $DIB_RGB_COLORS      = 0 ;/* color table in RGBs */
;~ Global Const $DIB_PAL_COLORS      = 1 ;/* color table in palette indices */

;/* constants for Get/SetSystemPaletteUse() */

;~ Global Const $SYSPAL_ERROR    = 0
;~ Global Const $SYSPAL_STATIC   = 1
;~ Global Const $SYSPAL_NOSTATIC = 2
;~ Global Const $SYSPAL_NOSTATIC256 = 3

;/* constants for CreateDIBitmap */
;~ Global Const $CBM_INIT        = 0x04   ;/* initialize bitmap */

Global Const $STAMP_DESIGNVECTOR = 0x80000000 + Asc( 'd' ) + ( Asc( 'v' ) * (2^8) );
