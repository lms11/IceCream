//
//  ViewController.m
//  IceCream for iPad
//
//  Created by Lucas Moreira on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (IBAction)startMovement:(id)sender {
    labelInitialSpace.text = [NSString stringWithFormat:@"%.2fm", [fieldInitialSpace.text floatValue]];
    labelFinalSpace.text = [NSString stringWithFormat:@"%.2fm", [fieldFinalSpace.text floatValue]];    
    
    [iceCream setInitialSpace:[fieldInitialSpace.text floatValue]];
    [iceCream setFinalSpace:[fieldFinalSpace.text floatValue]];
    [iceCream setInitialVelocity:[fieldInitialVelocity.text floatValue]];
    [iceCream setAceleration:[fieldAceleration.text floatValue]];
    [iceCream startLoop];
    
    [buttonSimulate setEnabled:NO];
    [buttonPlayPause setEnabled:YES];
}

- (IBAction)resetMovement:(id)sender {
    [iceCream reset];
    [buttonPlayPause setTitle:@"Pause Movement" forState:UIControlStateNormal];
    [buttonSimulate setEnabled:YES];
}

- (IBAction)playOrStopMovement:(id)sender {
    if (![buttonPlayPause isEnabled]) return;
    
    if ([iceCream isSimulating]) {
        // Pause
        [iceCream stopLoop];
        [buttonPlayPause setTitle:@"Play Movement" forState:UIControlStateNormal];
        
    } else {
        // Play
        [iceCream startLoop];
        [buttonPlayPause setTitle:@"Pause Movement" forState:UIControlStateNormal];
    }
}

#pragma mark - IceCream Delegate

- (void)recalculatedForIceCream:(IceCream *)_iceCream position:(float)position velocity:(float)velocity time:(float)time {
    labelCurrentPosition.text = [NSString stringWithFormat:@"Current position: %.2fm", position];
    labelCurrentVelocity.text = [NSString stringWithFormat:@"Current velocity: %.2fm/s", velocity];
    labelCurrentTime.text = [NSString stringWithFormat:@"Time: %.1fs", time];
    
    car.frame = CGRectMake(50 + (position * [iceCream metersPerPixel]), 126, CAR_WIDTH, CAR_HEIGHT);
}

- (void)simulationDidFinish:(IceCream *)_iceCream {
    // Finalizou o carrinho :P
    [buttonSimulate setEnabled:YES];
    [buttonPlayPause setEnabled:NO];
}

#pragma mark - Notification

- (void)keyboardAppear:(NSNotification *)notification {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [viewFields setFrame:CGRectMake(0, 0, viewFields.frame.size.width, viewFields.frame.size.height)];
    [UIView commitAnimations];
}

- (void)keyboardDisappear:(NSNotification *)notification {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [viewFields setFrame:CGRectMake(0, 258, viewFields.frame.size.width, viewFields.frame.size.height)];
    [UIView commitAnimations];    
}

#pragma mark - 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    iceCream = [[IceCream alloc] initWithRoadWidth:ROAD_WIDTH carWidth:CAR_WIDTH];
    [iceCream setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
