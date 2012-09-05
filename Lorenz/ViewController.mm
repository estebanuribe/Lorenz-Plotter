//
//  ViewController.m
//  Lorenz
//
//  Created by Esteban Uribe on 8/23/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"



static inline double radians (double degrees) { return degrees * M_PI/180; }

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    elapsedTime = 0;
    savedDrawingImage = nil;
    
/*    lorenzLayer = [CALayer layer];
    lorenzLayer.frame = self.view.layer.bounds;*/
    self.view.layer.backgroundColor = [UIColor blueColor].CGColor;
    self.view.layer.frame = CGRectInset(self.view.layer.frame, 20.0, 20.0);
//    [lorenzLayer setDelegate: self];

//    [self.view.layer addSublayer: lorenzLayer];*/


    lorenzTimer = [NSTimer scheduledTimerWithTimeInterval:0.000001 target:self selector:@selector(drawLorenz:) userInfo:nil repeats:YES];
    
    
/*    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor blueColor].CGColor;
    sublayer.shadowOffset = CGSizeMake(0, 3);
    sublayer.shadowRadius = 5.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 0.8;
    sublayer.frame = CGRectMake(30, 30, 128, 192);
    sublayer.borderColor = [UIColor blackColor].CGColor;
    sublayer.borderWidth = 2.0;
    sublayer.cornerRadius = 10.0;
    
    [self.view.layer addSublayer:sublayer];*/
    
/*    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = sublayer.bounds;
    imageLayer.cornerRadius = 10.0;

    imageLayer.contents = (id) [UIImage imageNamed:@"KermitFolder.jpg"].CGImage;
    imageLayer.masksToBounds = YES;
    [sublayer addSublayer:imageLayer];
    
    CALayer *customDrawn = [CALayer layer];
    customDrawn.delegate = self;
    customDrawn.backgroundColor = [UIColor greenColor].CGColor;
    customDrawn.frame = CGRectMake(30, 250, 128, 40);
    customDrawn.shadowOffset = CGSizeMake(0, 3);
    customDrawn.shadowRadius = 5.0;
    customDrawn.shadowColor = [UIColor blackColor].CGColor;
    customDrawn.shadowOpacity = 0.8;
    customDrawn.cornerRadius = 10.0;
    customDrawn.borderColor = [UIColor blackColor].CGColor;
    customDrawn.borderWidth = 2.0;
    customDrawn.masksToBounds = YES;
    [self.view.layer addSublayer:customDrawn];
    [customDrawn setNeedsDisplay];*/
    
    
/*    CALayer *orbit1 = [CALayer layer];
	orbit1.bounds = CGRectMake(0, 0, 200, 200);
	orbit1.position = self.view.center;
	orbit1.cornerRadius = 100;
	orbit1.borderColor = [UIColor redColor].CGColor;
	orbit1.borderWidth = 1.5;
	
	CALayer *planet1 = [CALayer layer];
	planet1.bounds = CGRectMake(0, 0, 20, 20);
	planet1.position = CGPointMake(100, 0);
	planet1.cornerRadius = 10;
	planet1.backgroundColor = [UIColor redColor].CGColor;
	[orbit1 addSublayer:planet1];
	
	CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	anim1.fromValue = [NSNumber numberWithFloat:0];
	anim1.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
	anim1.repeatCount = HUGE_VALF;
	anim1.duration = 2.0;
//	[orbit1 addAnimation:anim1 forKey:@"transform"];

    
    CALayer *points = [CALayer layer];
    points.bounds = CGRectMake(100,100, 50, 50);
    points.position = CGPointMake(self.view.center.x+200, self.view.center.y+50);*/
    
//	[self.view.layer addSublayer:orbit1];
}


- (void) drawLorenz:(NSTimer *)timer {
//    elapsedTime += timer.timeInterval;
//    [self.view.layer setNeedsDisplay];
    [self.view setNeedsDisplay];
//    [lorenzLayer setNeedsDisplay];
//    [self.view.layer displayIfNeeded];
}


void MyDrawColoredPattern (void *info, CGContextRef context) {
    
    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, radians(90), 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 16, 16, 4, 0, radians(45), 0);
    CGContextFillPath(context);
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    
    CGFloat offset = 30.0;
    
    if (savedDrawingImage) [savedDrawingImage drawInRect:layer.frame];
    CGColorRef pointColor = [UIColor whiteColor].CGColor;
    CGContextSetFillColorWithColor(context, pointColor);
    
//    CGFloat xd = x/z * zoom + offset;
//    CGFloat xy = y/z * zoom + offset;
    
//    CGContextAddArc(context, xd, xy, 10, 0, radians(360), 0);
//    CGContextFillPath(context);

    NSAssert(context != nil, @"graphics context is nil");
    
//    x = attractor->xprime(x, y);
//    y = attractor->yprime(x, y, z);
//    z = attractor->zprime(x, y, z);
//    CGImageRef imageRef = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
//    CGImageRef imageRef = CGBitmapContextCreateImage(context);
//    savedDrawingImage = [UIImage imageWithCGImage:imageRef];
    savedDrawingImage = UIGraphicsGetImageFromCurrentImageContext();

//    UIGraphicsEndImageContext();
//    [self.view setNeedsDisplay];

/*    CGColorRef bgColor = [UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
    CGContextSetFillColorWithColor(context, bgColor);
    CGContextFillRect(context, layer.bounds);
    
    static const CGPatternCallbacks callbacks = { 0, &MyDrawColoredPattern, NULL };
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL,
                                           layer.bounds,
                                           CGAffineTransformIdentity,
                                           24,
                                           24,
                                           kCGPatternTilingConstantSpacing,
                                           true,
                                           &callbacks);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, layer.bounds);
    CGContextRestoreGState(context);*/
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
