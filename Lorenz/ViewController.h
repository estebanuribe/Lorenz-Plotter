//
//  ViewController.h
//  Lorenz
//
//  Created by Esteban Uribe on 8/23/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LorenzAttractor.h"

@class LorenzView, XYZValueAdjusterViewController, HABCValueAdjusterViewController;

@interface ViewController : UIViewController
{
    CALayer *lorenzLayer;
    NSTimer *lorenzTimer;
    NSTimeInterval elapsedTime;
    UIImage *savedDrawingImage;
    LorenzAttractor *attractor;
    
    IBOutlet UIButton   *toggle;
    IBOutlet LorenzView *lorenzView;
    IBOutlet UILabel    *initialCoordinatesLabel;
    IBOutlet UILabel    *lorenzValuesLabel;
    IBOutlet UIButton   *xyzCoordinatesButton;
    IBOutlet UIButton   *lorenzValuesButton;
    
    XYZValueAdjusterViewController *xyzValueAdjusterViewController;
    HABCValueAdjusterViewController *lorenzValueAdjusterViewController;
}

- (void) drawLorenz:(NSTimer *)timer;

- (IBAction)restartLorenzView:(id)sender;
- (IBAction)clearLorenzView:(id)sender;
- (IBAction)toggleLorenz:(id)sender;
- (IBAction)toggleLeadPoint:(id)sender;
- (IBAction)toggleAutoClear:(id)sender;

- (IBAction)toggleInitialCoordinatesAdjuster:(id)sender;
- (IBAction)toggleLorenzValueAdjuster:(id)sender;

@end
