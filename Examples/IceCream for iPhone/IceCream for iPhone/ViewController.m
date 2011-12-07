//
//  ViewController.m
//  IceCream for iPhone
//
//  Created by Lucas Moreira on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (IBAction)startMovement:(id)sender {
    if (!simulationVC) {
        simulationVC = [[SimulationViewController alloc] init];
    }
    
    [simulationVC setInitialSpace:[fieldInitialSpace.text floatValue]];
    [simulationVC setFinalSpace:[fieldFinalSpace.text floatValue]];
    [simulationVC setInitialVelocity:[fieldInitialVelocity.text floatValue]];
    [simulationVC setAceleration:[fieldAceleration.text floatValue]];
    
    [self presentModalViewController:simulationVC animated:YES];
}

- (IBAction)about:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About"
                                                    message:@"Open-source development\nby Lucas Moreira"
                                                   delegate:nil
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [fieldInitialSpace becomeFirstResponder];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
