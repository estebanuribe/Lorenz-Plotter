//
//  LorenzView.m
//  Lorenz
//
//  Created by Esteban Uribe on 8/23/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import "LorenzView.h"

#import <QuartzCore/QuartzCore.h>

static inline double radians (double degrees) { return degrees * M_PI/180; }

@implementation LorenzView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        savedDrawingImage = nil;
        x = 10, y = 10, z = 10;
        red = 0, green = 0, blue = 0;
        iterator = 0;
    }
    return self;
}

- (void)viewDidLoad {
    timeElapsed = 0;
    savedDrawingImage = nil;
    attractor = new LorenzAttractor(10.0,28.0,8/3);
}

- (void)drawRect:(CGRect)rect
{

    if (iterator > 10000) {
        savedDrawingImage = nil;
        iterator = 0;
    }
    
    if (savedDrawingImage) [savedDrawingImage drawInRect:rect];
    
    double h = 0.01;
    double a = 10; //10.0;
    double b = 28.0; //28.0; //28.0
    double c = 8.0 / 3.0;

    CGContextRef context = UIGraphicsGetCurrentContext();
    NSAssert(context != NULL, @"Context is NULL!");
    

    CGFloat offset = 300.0;
//    CGFloat xp = attractor->xprime(x, y)+offset;
//    CGFloat yp = attractor->yprime(x, y, z)+offset;
//    CGFloat zp = attractor->zprime(x, y, z)+offset;

    double xp = x + h * a * (y - x);
    double yp = y + h * (x * (b - z) - y);
    double zp = z + h * (x * y - c * z);

    x = xp, y = yp, z = zp;
   
    iterator++;
    UIColor *newColor = [UIColor redColor];
//    UIColor *newColor = (iterator%2)?[UIColor redColor]:[UIColor blueColor];

/*    if (iterator > 500) {
        newColor = [UIColor blueColor];
        
        //red = ((double)arc4random()/0x100000000);
        //blue = ((double)arc4random()/0x100000000);
        //green = ((double)arc4random()/0x100000000);
        iterator = 0;
    }*/
    //UIColor *newColor = [UIColor colorWithRed:zp green:zp blue:zp alpha:0.5];
//    UIColor *newColor = [UIColor grayColor];
//    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //NSLog(@"color: %@", newColor);
    //CGFloat white = 0.0, alpha = 0.0;
    
    //if([newColor getWhite:&white alpha:&alpha]) {
    //    newColor = [UIColor colorWithWhite:white alpha:0.5];
    //}
    
    CGColorRef pointColor = newColor.CGColor;

    //xp += 300.0;
    //yp += 300.0;
    //zp += 300.0;

//    CGFloat xd = xp/zp;
//    CGFloat yd = yp/zp;
//    if(xd < 0.0) xd = -xd;
//    if(yd < 0.0) yd = -yd;

//    CGFloat xd = xp; //fmod(xp, 768.0);
//    CGFloat yd = yp; //fmod(yp, 768.0)+300.0;
//    CGFloat zd = fmod(zp, 3.0);
    
//    CGFloat xd = (xp / yp) * 1.0;
//    CGFloat yd = (yp / zp) * 1.0;
    
//    CGContextAddArc(context, (xp*10)+self.center.x, (yp*10)+self.center.y, zp/4.0, 0, radians(360), 0);

    double xd = (xp*10.0)+self.center.x;
    double yd = (yp*10.0)+self.center.y;
    double zd = z/16.0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetLineWidth(context, 0.2);

    CGContextSetFillColorWithColor(context, pointColor);
    CGPathAddArc(path, NULL, xd, yd, zd, 0, radians(360), 0);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    
//    CGContextStrokePath(context);
    CGPathRelease(path);

    path = CGPathCreateMutable();

    //CGContextSetFillColorWithColor(context, pointColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//    CGPathAddArc(path, NULL, (xp*10)+self.center.x, (yp*10)+self.center.y, z/8.0, 0, radians(360), 0);
    CGPathAddArc(path, NULL, xd, yd, zd, 0, radians(360), 0);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGPathRelease(path);

//    CGContextFillPath(context);
    
    
    x = xp;
    y = yp;
    z = zp;
    
    NSAssert(context != nil, @"graphics context is nil");
    //    CGImageRef imageRef = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    if(imageRef)    {
        savedDrawingImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    else NSLog(@"we got wiped out! (%f, %f, %f)", xp, yp, zp);
    //savedDrawingImage = UIGraphicsGetImageFromCurrentImageContext();
    

    
//    self.layer.backgroundColor = [UIColor orangeColor].CGColor;
//    self.layer.cornerRadius = 20.0;
//    self.layer.frame = CGRectInset(self.layer.frame, 20.0, 20.0);
}

@end
