//
//  SimulationViewController.h
//  IceCream for iPhone
//
//  Created by Lucas Moreira on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IceCream.h"

#define ROAD_WIDTH  440.0   // Width of road in pixels
#define CAR_WIDTH   63.0    // Width of car  in pixels
#define CAR_HEIGHT  25.0    // Height of car in pixels

@interface SimulationViewController : UIViewController <IceCreamDelegate> {
    IceCream *iceCream;
    
    IBOutlet UIImageView *car;
    IBOutlet UILabel *labelInitialSpace;
    IBOutlet UILabel *labelFinalSpace;
    IBOutlet UILabel *labelCurrentPosition;
    IBOutlet UILabel *labelCurrentTime;
    IBOutlet UILabel *labelCurrentVelocity;
    IBOutlet UIBarButtonItem *buttonSimulate;
    IBOutlet UIBarButtonItem *buttonPlayPause;
    
    float initialSpace, finalSpace, initialVelocity, aceleration;
}

@property (assign) float initialSpace, finalSpace, initialVelocity, aceleration;

- (IBAction)startMovement:(id)sender;
- (IBAction)resetMovement:(id)sender;
- (IBAction)playOrStopMovement:(id)sender;
- (IBAction)back:(id)sender;

@end
