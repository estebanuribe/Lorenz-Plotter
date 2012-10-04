//
//  XYZValueAdjusterViewController.m
//  Lorenz
//
//  Created by Esteban Uribe on 9/11/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import "XYZValueAdjusterViewController.h"

@interface XYZValueAdjusterViewController ()

@end

@implementation XYZValueAdjusterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)updateXValue:(id)sender {
    [self setX:[NSNumber numberWithFloat:xValueSlider.value]];
}

- (IBAction)updateYValue:(id)sender {
    [self setY:[NSNumber numberWithFloat:yValueSlider.value]];
}

- (IBAction)updateZValue:(id)sender {
    [self setZ:[NSNumber numberWithFloat:zValueSlider.value]];
}


@end
