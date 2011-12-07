//
//  ViewController.h
//  IceCream for iPad
//
//  Created by Lucas Moreira on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IceCream.h"

#define ROAD_WIDTH  924.0   // Width of road in pixels
#define CAR_WIDTH   129.0   // Width of car  in pixels
#define CAR_HEIGHT  49.0    // Height of car in pixels

@interface ViewController : UIViewController <IceCreamDelegate> {
    IceCream *iceCream;
    
    IBOutlet UIImageView *car;
    IBOutlet UILabel *labelInitialSpace;
    IBOutlet UILabel *labelFinalSpace;
    IBOutlet UIView *viewFields;
    IBOutlet UILabel *labelCurrentPosition;
    IBOutlet UILabel *labelCurrentTime;
    IBOutlet UILabel *labelCurrentVelocity;
    IBOutlet UITextField *fieldAceleration;
    IBOutlet UITextField *fieldInitialSpace;
    IBOutlet UITextField *fieldInitialVelocity;
    IBOutlet UITextField *fieldFinalSpace;
    IBOutlet UIButton *buttonSimulate;
    IBOutlet UIButton *buttonPlayPause;
}

- (IBAction)startMovement:(id)sender;
- (IBAction)resetMovement:(id)sender;
- (IBAction)playOrStopMovement:(id)sender;

- (void)keyboardAppear:(NSNotification *)notification;
- (void)keyboardDisappear:(NSNotification *)notification;

@end
