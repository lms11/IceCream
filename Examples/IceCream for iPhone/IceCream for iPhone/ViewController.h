//
//  ViewController.h
//  IceCream for iPhone
//
//  Created by Lucas Moreira on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimulationViewController.h"

@interface ViewController : UIViewController {
    SimulationViewController *simulationVC;
    
    IBOutlet UITextField *fieldAceleration;
    IBOutlet UITextField *fieldInitialSpace;
    IBOutlet UITextField *fieldInitialVelocity;
    IBOutlet UITextField *fieldFinalSpace;
}

- (IBAction)startMovement:(id)sender;
- (IBAction)about:(id)sender;

@end
