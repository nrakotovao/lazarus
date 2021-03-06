{ $Id: $}
{                  --------------------------------------------
                  cocoa_extra.pp  -  Cocoa headers not available in FPC
                  --------------------------------------------

 This unit contains Cocoa headers which are not yet available in the latest FPC release

 *****************************************************************************
  This file is part of the Lazarus Component Library (LCL)

  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************
}
unit Cocoa_Extra;

{$mode objfpc}{$H+}
{$modeswitch objectivec1}

interface

uses
  // rtl+ftl
  Types, Classes, SysUtils,
  CGGeometry,
  // Libs
  MacOSAll, CocoaAll;

type
  NSImageScaling = NSUInteger;
const // NSImageScaling values
  NSImageScaleProportionallyDown = 0;
  NSImageScaleAxesIndependently = 1;
  NSImageScaleNone = 2;
  NSImageScaleProportionallyUpOrDown = 3;

type
  NSMenuFix = objccategory external (NSMenu)
    function itemAtIndex(index: NSInteger): NSMenuItem; message 'itemAtIndex:';
  end;

  NSEdgeInsets = packed record
    top     : CGFloat;
    left    : CGFloat;
    bottom  : CGFloat;
    right   : CGFloat;
  end;

  NSViewFix = objccategory external (NSView)
    // 10.7+
    function fittingSize: NSSize; message 'fittingSize';
    function alignmentRectInsets: NSEdgeInsets; message 'alignmentRectInsets';
    function alignmentRectForFrame(ns: NSRect): NSRect; message 'alignmentRectForFrame:';
    function frameForAlignmentRect(ns: NSRect): NSRect; message 'frameForAlignmentRect:';
  end;

  NSLayoutConstraint = objcclass external (NSObject)
    function isActive: Boolean; message 'isActive';
    procedure setActive(Active: Boolean); message 'setActive:';
  end;

  NSButtonSoundExtensionsCategory = objccategory external (NSButton)
    function intrinsicContentSize(): NSSize; message 'intrinsicContentSize';
    procedure setImageScaling(aScaling: NSImageScaling); message 'setImageScaling:';
  end;

  // The following dummy categories fix bugs in the Cocoa bindings available in FPC
  // Remove them when the FPC binding parser is fixed.
  // More details:
  // http://wiki.freepascal.org/FPC_PasCocoa/Differences#Sending_messages_to_id
  // http://wiki.lazarus.freepascal.org/FPC_PasCocoa#Category_declaration
  NSBitmapImageRepFix = objccategory external(NSBitmapImageRep)
    function initWithBitmapDataPlanes_pixelsWide_pixelsHigh__colorSpaceName_bytesPerRow_bitsPerPixel(planes: PPByte; width: NSInteger; height: NSInteger; bps: NSInteger; spp: NSInteger; alpha: Boolean; isPlanar_: Boolean; colorSpaceName_: NSString; rBytes: NSInteger; pBits: NSInteger): id; message 'initWithBitmapDataPlanes:pixelsWide:pixelsHigh:bitsPerSample:samplesPerPixel:hasAlpha:isPlanar:colorSpaceName:bytesPerRow:bitsPerPixel:';
    function initWithBitmapDataPlanes_pixelsWide_pixelsHigh__colorSpaceName_bitmapFormat_bytesPerRow_bitsPerPixel(planes: PPByte; width: NSInteger; height: NSInteger; bps: NSInteger; spp: NSInteger; alpha: Boolean; isPlanar_: Boolean; colorSpaceName_: NSString; bitmapFormat_: NSBitmapFormat; rBytes: NSInteger; pBits: NSInteger): id; message 'initWithBitmapDataPlanes:pixelsWide:pixelsHigh:bitsPerSample:samplesPerPixel:hasAlpha:isPlanar:colorSpaceName:bitmapFormat:bytesPerRow:bitsPerPixel:';
  end;

  NSGraphicsContextFix = objccategory external(NSGraphicsContext)
    procedure setImageInterpolation(interpolation: NSImageInterpolation); message 'setImageInterpolation:';
    procedure setShouldAntialias(antialias: Boolean); message 'setShouldAntialias:';
    // 10.10
    function CGContext: CGContextRef; message 'CGContext';
  end;

  NSEventFix = objccategory external (NSEvent)
    class function modifierFlags_: NSUInteger; message 'modifierFlags';
  end;

  NSWindowTabbingMode = NSInteger;

  NSWindowFix = objccategory external (NSWindow)
    // 10.4-10.7
    // userSpaceScaleFactor is declare in the latest CocoaAll
    //function userSpaceScaleFactor: CGFloat; message 'userSpaceScaleFactor'; //deprecated
    // 10.7+
    procedure toggleFullScreen(sender: id); message 'toggleFullScreen:';
    function backingScaleFactor: CGFloat; message 'backingScaleFactor';
    // 10.12
    procedure setTabbingMode(amode: NSWindowTabbingMode); message 'setTabbingMode:';
    function tabbingMode: NSWindowTabbingMode; message 'tabbingMode';
    class procedure setAllowsAutomaticWindowTabbing(aflag: Boolean); message 'setAllowsAutomaticWindowTabbing:';
    class function allowsAutomaticWindowTabbing: Boolean; message 'allowsAutomaticWindowTabbing';
  end;

  NSTableColumnFix = objccategory external (NSTableColumn)
    procedure setTitle(atitle: NSString); message 'setTitle:';
    function title: NSString; message 'title';
  end;

  NSUserInterfaceItemIdentifier = NSString;

  NSTableViewAnimationOptions = NSUInteger;

  NSTableViewFix = objccategory external (NSTableView)
    // 10.7
    function rowForView(AView: NSView): NSInteger; message 'rowForView:';
    function columnForView(AView: NSView): NSInteger; message 'columnForView:';
    function makeViewWithIdentifier_owner(identifier_: NSUserInterfaceItemIdentifier; owner: id): NSView ; message 'makeViewWithIdentifier:owner:';
    function viewAtColumn_row_makeIfNecessary(column, row: NSInteger; makeifNecessary: Boolean): NSview; message 'viewAtColumn:row:makeIfNecessary:';
    procedure insertRowsAtIndexes_withAnimation(indexes: NSIndexSet; withAnimation: NSTableViewAnimationOptions);
      message 'insertRowsAtIndexes:withAnimation:';
    procedure removeRowsAtIndexes_withAnimation(indexes: NSIndexSet; withAnimation: NSTableViewAnimationOptions);
      message 'removeRowsAtIndexes:withAnimation:';
  end;

  {// private since 10.5, doesn't seam to do anything in 10.10
  NSApplicationSetAppleMenu = objccategory external(NSApplication)
    procedure setAppleMenu(AMenu: NSMenu); message 'setAppleMenu:';
  end;}

  NSOperatingSystemVersion = record
    majorVersion: NSInteger;
    minorVersion: NSInteger;
    patchVersion: NSInteger;
  end;

const
  // defined in NSApplication.h
  NSAppKitVersionNumber10_5 = 949;
  NSAppKitVersionNumber10_6 = 1038;
  NSAppKitVersionNumber10_7 = 1138;
  NSAppKitVersionNumber10_8 = 1187;
  NSAppKitVersionNumber10_9 = 1265;
  NSAppKitVersionNumber10_10 = 1343;
  NSAppKitVersionNumber10_11 = 1404;
  NSAppKitVersionNumber10_12 = 1504;


const
  //kCGBaseWindowLevelKey = 0;
  //kCGMinimumWindowLevelKey = 1;
  //kCGDesktopWindowLevelKey = 2;
  //kCGBackstopMenuLevelKey = 3;
  NSNormalWindowLevel = 4;
  NSFloatingWindowLevel = 5;
  NSSubmenuWindowLevel = 6;
  NSTornOffMenuWindowLevel = 6;
  //kCGDockWindowLevelKey = 7; deprecated
  NSMainMenuWindowLevel = 8;
  NSStatusWindowLevel = 9;
  NSModalPanelWindowLevel = 10;
  NSPopUpMenuWindowLevel = 11;
  NSScreenSaverWindowLevel = 12;
  //kCGScreenSaverWindowLevelKey = 13;
  //kCGMaximumWindowLevelKey = 14;
  //kCGOverlayWindowLevelKey = 15;
  //kCGHelpWindowLevelKey = 16;
  //kCGUtilityWindowLevelKey = 17;
  //kCGDesktopIconWindowLevelKey = 18;
  //kCGCursorWindowLevelKey = 19;
  //kCGAssistiveTechHighWindowLevelKey = 20;
  //kCGNumberOfWindowLevelKeys = 21;	{ Must be last. }

const
  NSWindowCollectionBehaviorFullScreenPrimary = 1 shl 7;  // 10.7
  NSWindowCollectionBehaviorFullScreenAuxiliary = 1 shl 8;  // 10.7
  NSWindowCollectionBehaviorFullScreenAllowsTiling = 1 shl 11; // 10.11
  NSWindowCollectionBehaviorFullScreenDisallowsTiling = 1 shl 12; // 10.11

  NSWindowTabbingModeAutomatic  = 0; // The system automatically prefers to tab this window when appropriate
  NSWindowTabbingModePreferred  = 1; // The window explicitly should prefer to tab when shown
  NSWindowTabbingModeDisallowed = 2; // The window explicitly should not prefer to tab when shown

const
  NSKeyCodeTab  = 48;

{ NSTableView Animation Options }

const
  { Use to not apply any animation effect (the default).
     Specifying any animation from the effect groups below
     negates this effect.  }
  NSTableViewAnimationEffectNone = $0;

  { Row animation Effect (optional). The effect can be combined
    with other any NSTableViewRowAnimationSlide* option.
   }
  NSTableViewAnimationEffectFade = $1; // Fades in new rows.
  NSTableViewAnimationEffectGap  = $2; // Creates a gap for newly inserted rows. This is useful for drag and drop animations that animate to a newly opened gap and should be used in -tableView:acceptDrop:row:dropOperation:.

  {Row Animation Sliding (optional). Currently only one option from this group may be specified at a time.
   }
  NSTableViewAnimationSlideUp    = $10; // Animates a row in or out by sliding upward.
  NSTableViewAnimationSlideDown  = $20; // Animates a row in or out by sliding downward.
  NSTableViewAnimationSlideLeft  = $30; // Animates a row in by sliding from the left. Animates a row out by sliding towards the left.
  NSTableViewAnimationSlideRight = $40; // Animates a row in by sliding from the right. Animates a row out by sliding towards the right.

implementation

end.

