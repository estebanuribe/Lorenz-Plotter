//
//  LorenzView.h
//  Lorenz
//
//  Created by Esteban Uribe on 8/23/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#import "LorenzAttractor.h"


@interface LorenzView : UIView
{
    NSTimeInterval  timeElapsed;
    UIImage         *savedDrawingImage;

    LorenzAttractor *attractor;
    
    double x;
    double y;
    double z;
    
    double x2;
    double y2;
    double z2;

    double x3;
    double y3;
    double z3;

    double red;
    double green;
    double blue;
    int    iterator;
    
    double h;
    double a;
    double b;
    double c;
    
    double old_xd;
    double old_yd;
    
    double old_x2d;
    double old_y2d;
    
    double old_x3d;
    double old_y3d;

    
    IBOutlet UITextView *xyzCoordinates;

}

@property (assign) double x;
@property (assign) double y;
@property (assign) double z;

@property (retain) NSString *xyz;

@property (assign) double h;
@property (assign) double a;
@property (assign) double b;
@property (assign) double c;

@property (assign) BOOL clear;
@property (assign) BOOL pause;
@property (assign) BOOL showLeadPoint;
@property (assign) BOOL autoClear;
@property (assign) BOOL drawLines;
@property (assign) BOOL restart;

@property (retain) UIColor *pointColor;
@property (retain) UIColor *strokeColor;

@property (retain) UIColor *leadPointColor;
@property (retain) UIColor *leadStrokeColor;

- (void) setX:(double)xn Y:(double)yn Z:(double)zn;
- (void) setH:(double)hn A:(double)an B:(double)bn C:(double)cn;

@end
