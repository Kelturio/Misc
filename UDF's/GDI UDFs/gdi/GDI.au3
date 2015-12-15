;#BETA
#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.13 (beta)
 Author:         Prog@ndy

 Script Function:
	includes all GDI-functions

#ce ----------------------------------------------------------------------------
#include "GDIBase.au3"
;############################################################################

#include "GDI\Bitmaps.au3"
#include "GDI\Brushes.au3"
#include "GDI\Clipping.au3"
#include "GDI\Colors.au3"
#include "GDI\Transformations.au3"
#include "GDI\DeviceContexts.au3"
#include "GDI\FilledShapes.au3"
#include "GDI\FontsText.au3"
#include "GDI\LinesCurves.au3"
#include "GDI\Metafiles.au3"
#include "GDI\Monitors.au3"
#include "GDI\PaintingDrawing.au3"
#include "GDI\Paths.au3"
#include "GDI\Pens.au3"
#include "GDI\Printing.au3"
#include "GDI\Rectangles.au3"
#include "GDI\Regions.au3"

#Region TODO
#cs
	-> merge all functions from WinApi.au3
	-> change to unicode in all funcs with strings
#ce
#EndRegion TODO
;######################################################################################