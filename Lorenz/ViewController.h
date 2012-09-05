//
//  ViewController.h
//  Lorenz
//
//  Created by Esteban Uribe on 8/23/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LorenzAttractor.h"


@interface ViewController : UIViewController
{
    CALayer *lorenzLayer;
    NSTimer *lorenzTimer;
    NSTimeInterval elapsedTime;
    UIImage *savedDrawingImage;
    LorenzAttractor *attractor;
    
}

- (void) drawLorenz:(NSTimer *)timer;

@end
