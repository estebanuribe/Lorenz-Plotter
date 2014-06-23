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
static inline double xprime (double h, double a, double x, double y) { return x + h * a * (y - x); }
static inline double yprime (double h, double b, double x, double y, double z) { return y + h * (x * (b - z) - y); }
static inline double zprime (double h, double c, double x, double y, double z) { return z + h * (x * y - c * z); }

void drawLineFromPointToPointInContext(double old_xd, double old_yd, double xd, double yd, double zd, CGContextRef context, CGColor *strokeColor) {
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, old_xd, old_yd);
    CGPathAddLineToPoint(path, NULL, xd, yd);
    CGContextAddPath(context, path);
    
    CGContextSetLineWidth(context, zd);
    CGContextSetStrokeColorWithColor(context, strokeColor);
    CGContextStrokePath(context);
    CGPathRelease(path);
}

void drawPointsInContext(double xd, double yd, double zd, CGContextRef context, CGColor *fillColor, CGColor *strokeColor) {
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextSetLineWidth(context, 0.2);
    
    CGContextSetFillColorWithColor(context, fillColor);
    CGPathAddArc(path, NULL, xd, yd, zd, 0, radians(360), 0);
    
    CGContextSetStrokeColorWithColor(context, strokeColor);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGPathRelease(path);
}

void drawLeadPointInContext(double xd, double yd, CGContextRef context, CGColor *leadPointColor, CGColor *leadStrokeColor) {
    CGMutablePathRef leadPointPath = CGPathCreateMutable();
    
    CGContextSetLineWidth(context, 0.5);
    CGContextSetFillColorWithColor(context, leadPointColor);
    CGPathAddArc(leadPointPath, NULL, xd, yd, 3.0, 0, radians(360), 0);
    CGContextAddPath(context, leadPointPath);
    CGContextFillPath(context);
    
    
    CGContextSetStrokeColorWithColor(context, leadStrokeColor);
    CGContextAddPath(context, leadPointPath);
    CGContextStrokePath(context);
    
    CGPathRelease(leadPointPath);

}

@implementation LorenzView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        savedDrawingImage = nil;
        x = 0.001, y = 0, z = 0;
//        x2 = 0.11, y2 = 0, z2 = 0;
//        x3 = 0.101, y3 = 0, z3 = 0;
        red = 0, green = 0, blue = 0;
        iterator = 0;
        
        h = 0.01;
        a = 10.0; //10.0;
        b = 28.0; //28.0; //28.0
        c = 8.0/3.0;
        
        _x = x, _y = y, _z = z, _h = h, _a = a, _b = b, _c = c;
//        attractor = new LorenzAttractor(h,a,b,c);
        
        _xyz = [NSString stringWithFormat:@"%0.2f, %0.2f, %0.2f", 0.0, 0.0, 0.0];

        
        old_xd = 0 + self.center.x;
        old_yd = 0 + self.center.y;
//        old_x2d = 0 + self.center.x;
//        old_y2d = 0 + self.center.y;
//        old_x3d = 0 + self.center.x;
//        old_y3d = 0 + self.center.y;
        
        _pause = NO;
        _clear = NO;
        _showLeadPoint = YES;
        _autoClear = YES;
        _drawLines = YES;
        _restart = NO;
//        _pointColor = [UIColor redColor];
        _strokeColor = [UIColor blueColor];
        _pointColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
        
//        [[UIColor redColor] getRed:&red green:&green blue:&blue alpha:&alpha];
//        _pointColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.5];
        
        _leadPointColor = [UIColor lightGrayColor];
        _leadStrokeColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad {
    timeElapsed = 0;
    savedDrawingImage = nil;
}

- (void)drawRect:(CGRect)rect
{
    if (_restart) {
        x = 0.0000000001, y = 0, z = 0;
//        x2 = 0.11, y2 = 0, z2 = 0;
//        x3 = 0.101, y3 = 0, z3 = 0;
        iterator = 0;
        _clear = YES;
        _restart = NO;
    }
    
    if(_clear) {
        savedDrawingImage = nil;
        _clear = NO;
        [xyzCoordinates setText:@""];

    }
    
    if(_pause) {
        [savedDrawingImage drawInRect:rect];
        return;
    }
    
    if (_autoClear) {
        iterator++;
        if (iterator > 10000) {
            savedDrawingImage = nil;
            iterator = 0;
            [xyzCoordinates setText:@""];
        }
    } else iterator = 0;
    
    if (savedDrawingImage) [savedDrawingImage drawInRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSAssert(context != NULL, @"Context is NULL!");

    if(isnan(x) || isnan(y) || isnan(z)) x = 0.1, y = 0, z = 0;
//    if(isnan(x2) || isnan(y2) || isnan(z2)) x2 = 0.11, y2 = 0, z2 = 0;
//    if(isnan(x3) || isnan(y3) || isnan(z3)) x3 = 0.01, y3 = 0, z3 = 0;

//    double xp = x + h * a * (y - x);
//    double yp = y + h * (x * (b - z) - y);
//    double zp = z + h * (x * y - c * z);
    
    double xp = xprime(h, a, x, y);
    double yp = yprime(h, b, x, y, z);
    double zp = zprime(h, c, x, y, z);

/*    double x2p = xprime(h, a, x2, y2);
    double y2p = yprime(h, b, x2, y2, z2);
    double z2p = zprime(h, c, x2, y2, z2);

    double x3p = xprime(h, a, x3, y3);
    double y3p = yprime(h, b, x3, y3, z3);
    double z3p = zprime(h, c, x3, y3, z3);
*/
/*    double xp2 = attractor->xprime(x, y);
    double yp2 = attractor->yprime(x, y, z);
    double zp2 = attractor->zprime(x, y, z);
    if( xp != xp2 || yp != yp2 || zp != zp2) {
        NSLog(@"xp, yp, zp, (%f, %f, %f)\nxp2, yp2, zp2, (%f, %f, %f)\n----", xp, yp, zp, xp2, yp2, zp2);
    }*/

    x = xp, y = yp, z = zp;
/*    x2 = x2p, y2 = y2p, z2 = z2p;
    x3 = x3p, y3 = y3p, z3 = z3p;
*/
/*    _xyz = [NSString stringWithFormat:@"(%0.2f, %0.2f, %0.2f)\n(%0.2f, %0.2f, %0.2f)\n(%0.2f, %0.2f, %0.2f)", x, y, z , x2, y2, z2, x3, y3, z3];*/
    _xyz = [NSString stringWithFormat:@"(%0.2f, %0.2f, %0.2f)", x, y, z];
    [xyzCoordinates setText:_xyz];

    double xd = (xp*10.0)+self.center.x;
    double yd = (yp*10.0)+self.center.y;
    double zd = 1.0;
//    double zd = zp/24.0;
//    zd = fabs((zd > 40.0)?fmod(zd, 40.0):zd); zd = (!zd)?1.0:zd;
    
    
/*    double x2d = (x2p*10.0)+self.center.x;
    double y2d = (y2p*10.0)+self.center.y;
    double z2d = 1.0;*/
//    double z2d = z2p/24.0;
//    z2d = fabs((z2d > 40.0)?fmod(z2d, 40.0):z2d); z2d = (!z2d)?1.0:z2d;
    

/*    double x3d = (x3p*10.0)+self.center.x;
    double y3d = (y3p*10.0)+self.center.y;
    double z3d = 1.0;*/
//    double z3d = z3p/24.0;
//    z3d = fabs((z3d > 40.0)?fmod(z3d, 40.0):z3d); z3d = (!z3d)?1.0:z3d;
    

    
    if (_drawLines) {
        drawLineFromPointToPointInContext(old_xd, old_yd, xd, yd, zd, context, _pointColor.CGColor);
//        drawLineFromPointToPointInContext(old_x2d, old_y2d, x2d, y2d, z2d, context, _pointColor.CGColor);
//        drawLineFromPointToPointInContext(old_x3d, old_y3d, x3d, y3d, z3d, context, _pointColor.CGColor);
//        drawLineFromPointToPointInContext(old_x2d, old_y2d, x2d, y2d, z2d, context, [UIColor greenColor].CGColor);
//        drawLineFromPointToPointInContext(old_x3d, old_y3d, x3d, y3d, z3d, context, [UIColor orangeColor].CGColor);
    } else {
        drawPointsInContext(xd, yd, zd, context, _pointColor.CGColor, _pointColor.CGColor);
//        drawPointsInContext(x2d, y2d, z2d, context, _pointColor.CGColor, _pointColor.CGColor);
//        drawPointsInContext(x3d, y3d, z3d, context, _pointColor.CGColor, _pointColor.CGColor);

//        drawPointsInContext(x2d, y2d, z2d, context, [UIColor greenColor].CGColor, [UIColor greenColor].CGColor);
//        drawPointsInContext(x3d, y3d, z3d, context, [UIColor orangeColor].CGColor, [UIColor orangeColor].CGColor);
    }

    old_xd = xd;
    old_yd = yd;
    
/*    old_x2d = x2d;
    old_y2d = y2d;

    old_x3d = x3d;
    old_y3d = y3d;
*/
    NSAssert(context != nil, @"graphics context is nil");

    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    if(imageRef)    {
        savedDrawingImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    else NSLog(@"we got wiped out! (%f, %f, %f)", xp, yp, zp);

    if(_showLeadPoint) {
        drawLeadPointInContext(xd, yd, context, _leadPointColor.CGColor, _leadStrokeColor.CGColor);
//        drawLeadPointInContext(x2d, y2d, context, [UIColor orangeColor].CGColor, [UIColor lightGrayColor].CGColor);
//        drawLeadPointInContext(x3d, y3d, context, [UIColor blueColor].CGColor, [UIColor lightGrayColor].CGColor);
    }
}

- (void) setX:(double)xn Y:(double)yn Z:(double)zn {
    _clear = YES;
    _x = xn;
    _y = yn;
    _z = zn;
}

- (void) setH:(double)hn A:(double)an B:(double)bn C:(double)cn {
    _clear = YES;
    _h = hn;
    _a = an;
    _b = bn;
    _c = cn;
    _x = 0.1;
    _y = 0;
    _z = 0;
    h = _h;
    a = _a;
    b = _b;
    c = _c;
}


@end
