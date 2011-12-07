//
//  AppDelegate.h
//  IceCream for Mac
//
//  Created by Lucas Moreira on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "IceCream.h"

#define ROAD_WIDTH  850.0   // Width of road in pixels
#define CAR_WIDTH   126.0   // Width of car  in pixels
#define CAR_HEIGHT  49.0    // Height of car in pixels

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IceCream *iceCream;
    
    IBOutlet NSImageView *car;
    IBOutlet NSTextField *labelInitialSpace;
    IBOutlet NSTextField *labelFinalSpace;
    IBOutlet NSView *viewFields;
    IBOutlet NSTextField *labelCurrentPosition;
    IBOutlet NSTextField *labelCurrentTime;
    IBOutlet NSTextField *labelCurrentVelocity;
    IBOutlet NSTextField *fieldAceleration;
    IBOutlet NSTextField *fieldInitialSpace;
    IBOutlet NSTextField *fieldInitialVelocity;
    IBOutlet NSTextField *fieldFinalSpace;
    IBOutlet NSButton *buttonSimulate;
    IBOutlet NSButton *buttonPlayPause;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)startMovement:(id)sender;
- (IBAction)resetMovement:(id)sender;
- (IBAction)playOrStopMovement:(id)sender;
- (IBAction)about:(id)sender;

@end
