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
    double zoom;
    double red;
    double green;
    double blue;
    int     iterator;
}

@end
