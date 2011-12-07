//
//  SimulationViewController.m
//  IceCream for iPhone
//
//  Created by Lucas Moreira on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SimulationViewController.h"

@implementation SimulationViewController
@synthesize initialSpace, finalSpace, initialVelocity, aceleration;

- (IBAction)startMovement:(id)sender {
    labelInitialSpace.text = [NSString stringWithFormat:@"%.2fm", initialSpace];
    labelFinalSpace.text = [NSString stringWithFormat:@"%.2fm", finalSpace];    
    
    [iceCream setInitialSpace:initialSpace];
    [iceCream setFinalSpace:finalSpace];
    [iceCream setInitialVelocity:initialVelocity];
    [iceCream setAceleration:aceleration];
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

- (IBAction)back:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - IceCream Delegate

- (void)recalculatedForIceCream:(IceCream *)_iceCream position:(float)position velocity:(float)velocity time:(float)time {
    labelCurrentPosition.text = [NSString stringWithFormat:@"Current position: %.2fm", position];
    labelCurrentVelocity.text = [NSString stringWithFormat:@"Current velocity: %.2fm/s", velocity];
    labelCurrentTime.text = [NSString stringWithFormat:@"Time: %.1fs", time];
    
    car.frame = CGRectMake(20 + (position * [iceCream metersPerPixel]), 78, CAR_WIDTH, CAR_HEIGHT);
}

- (void)simulationDidFinish:(IceCream *)_iceCream {
    // Finalizou o carrinho :P
    [buttonSimulate setEnabled:YES];
    [buttonPlayPause setEnabled:NO];
}

#pragma mark - 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    iceCream = [[IceCream alloc] initWithRoadWidth:ROAD_WIDTH carWidth:CAR_WIDTH];
    [iceCream setDelegate:self];
}

// New movement
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self startMovement:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
