//
//  AppDelegate.m
//  IceCream for Mac
//
//  Created by Lucas Moreira on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
- (IBAction)startMovement:(id)sender {
    [labelInitialSpace setStringValue:[NSString stringWithFormat:@"%.2fm", [fieldInitialSpace floatValue]]];
    [labelFinalSpace setStringValue:[NSString stringWithFormat:@"%.2fm", [fieldFinalSpace floatValue]]];

    [iceCream setInitialSpace:[fieldInitialSpace floatValue]];
    [iceCream setFinalSpace:[fieldFinalSpace floatValue]];
    [iceCream setInitialVelocity:[fieldInitialVelocity floatValue]];
    [iceCream setAceleration:[fieldAceleration floatValue]];
    [iceCream startLoop];
    
    [buttonSimulate setEnabled:NO];
    [buttonPlayPause setEnabled:YES];
}

- (IBAction)resetMovement:(id)sender {
    [iceCream reset];
    [buttonPlayPause setTitle:@"Pause Movement"];
    [buttonSimulate setEnabled:YES];
}

- (IBAction)playOrStopMovement:(id)sender {
    if (![buttonPlayPause isEnabled]) return;
    
    if ([iceCream isSimulating]) {
        // Pause
        [iceCream stopLoop];
        [buttonPlayPause setTitle:@"Play Movement"];
        
    } else {
        // Play
        [iceCream startLoop];
        [buttonPlayPause setTitle:@"Pause Movement"];
    }
}

- (IBAction)about:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"About"];
    [alert setInformativeText:@"Open-source development\nby Lucas Moreira"];
    [alert addButtonWithTitle:@"Cancel"];
    
    NSInteger answer = [alert runModal];
    [alert release];
}

#pragma mark - IceCream Delegate

- (void)recalculatedForIceCream:(IceCream *)_iceCream position:(float)position velocity:(float)velocity time:(float)time {
    [labelCurrentPosition setStringValue:[NSString stringWithFormat:@"Current position: %.2fm", position]];
    [labelCurrentVelocity setStringValue:[NSString stringWithFormat:@"Current velocity: %.2fm/s", velocity]];
    [labelCurrentTime setStringValue:[NSString stringWithFormat:@"Time: %.1fs", time]];
    
    car.frame = CGRectMake(25 + (position * [iceCream metersPerPixel]), 436, CAR_WIDTH, CAR_HEIGHT);
}

- (void)simulationDidFinish:(IceCream *)_iceCream {
    // Finalizou o carrinho :P
    [buttonSimulate setEnabled:YES];
    [buttonPlayPause setEnabled:NO];
}

#pragma mark -

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 1.0)]; //RGB plus Alpha Channel
    [viewFields setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [viewFields setLayer:viewLayer];
    
    iceCream = [[IceCream alloc] initWithRoadWidth:ROAD_WIDTH carWidth:CAR_WIDTH];
    [iceCream setDelegate:self];
}

@end
