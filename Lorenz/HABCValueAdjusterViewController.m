//
//  HABCValueAdjusterViewController.m
//  Lorenz
//
//  Created by Esteban Uribe on 9/11/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import "HABCValueAdjusterViewController.h"

@interface HABCValueAdjusterViewController ()

@end

@implementation HABCValueAdjusterViewController

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

- (IBAction)updateValue:(id)sender {
    if (sender == hValue) [self setH:[NSNumber numberWithFloat:[hValue.text floatValue]]];
    if (sender == aValue) [self setA:[NSNumber numberWithFloat:[aValue.text floatValue]]];
    if (sender == bValue) [self setB:[NSNumber numberWithFloat:[bValue.text floatValue]]];
    if (sender == cValue) [self setC:[NSNumber numberWithFloat:[cValue.text floatValue]]];
}

- (void) setH:(double)hn A:(double)an B:(double)bn C:(double)cn {
    _h = [NSNumber numberWithDouble:hn];
    _a = [NSNumber numberWithDouble:an];
    _b = [NSNumber numberWithDouble:bn];
    _c = [NSNumber numberWithDouble:cn];
    
    hValue.text = _h.stringValue;
    aValue.text = _a.stringValue;
    bValue.text = _b.stringValue;
    cValue.text = _c.stringValue;
}

@end
