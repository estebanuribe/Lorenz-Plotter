//
//  XYZValueAdjusterViewController.h
//  Lorenz
//
//  Created by Esteban Uribe on 9/11/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZValueAdjusterViewController : UIViewController
{
    IBOutlet UISlider *xValueSlider;
    IBOutlet UISlider *yValueSlider;
    IBOutlet UISlider *zValueSlider;
    
    IBOutlet UITextField *xValue;
    IBOutlet UITextField *yValue;
    IBOutlet UITextField *zValue;
}

@property (retain) NSNumber *x;
@property (retain) NSNumber *y;
@property (retain) NSNumber *z;

- (IBAction)updateXValue:(id)sender;
- (IBAction)updateYValue:(id)sender;
- (IBAction)updateZValue:(id)sender;

@end
