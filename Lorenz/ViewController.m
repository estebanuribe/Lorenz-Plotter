//
//  ViewController.m
//  Lorenz
//
//  Created by Esteban Uribe on 8/23/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "XYZValueAdjusterViewController.h"
#import "HABCValueAdjusterViewController.h"

#import "ViewController.h"
#import "LorenzView.h"



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
    
    self.view.layer.frame = CGRectInset(self.view.layer.frame, 20.0, 20.0);


    lorenzTimer = [NSTimer scheduledTimerWithTimeInterval:0.000001 target:self selector:@selector(drawLorenz:) userInfo:nil repeats:YES];
}


- (void) drawLorenz:(NSTimer *)timer {
//    elapsedTime += timer.timeInterval;
//    [self.view.layer setNeedsDisplay];

    NSString *coordinates = [NSString stringWithFormat:@"x: %0.2f; y: %0.2f; z: %0.2f", lorenzView.x, lorenzView.y, lorenzView.z];
    [xyzCoordinatesButton setTitle:coordinates forState:UIControlStateNormal];

    NSString *lorenzValues = [NSString stringWithFormat:@"h: %0.2f; a: %0.2f; b: %0.2f; c: %0.2f", lorenzView.h, lorenzView.a, lorenzView.b, lorenzView.c];
    [lorenzValuesButton setTitle:lorenzValues forState:UIControlStateNormal];

//    [initialCoordinatesLabel setText:[NSString stringWithFormat:@"x=%0.2f, y=%0.2f, z=%0.2f", lorenzView.x, lorenzView.y, lorenzView.y]];

    [lorenzView setNeedsDisplay];
//    [lorenzLayer setNeedsDisplay];
//    [self.view.layer displayIfNeeded];
}

- (IBAction)restartLorenzView:(id)sender {
    lorenzView.restart = YES;
    [lorenzView setNeedsDisplay];
}

- (IBAction)clearLorenzView:(id)sender {
    lorenzView.clear = YES;
    [lorenzView setNeedsDisplay];
}

- (IBAction)toggleLorenz:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.titleLabel.text = (!lorenzView.pause)?@"Start":@"Pause";
    [button setTitle:(!lorenzView.pause)?@"Start":@"Pause" forState:UIControlStateNormal];
    lorenzView.pause = !lorenzView.pause;
}

- (IBAction)toggleLeadPoint:(id)sender {
    UISwitch *button = (UISwitch *)sender;
    lorenzView.showLeadPoint = button.on;
}

- (IBAction)toggleAutoClear:(id)sender; {
    UISwitch *button = (UISwitch *)sender;
    lorenzView.autoClear = button.on;
}

- (IBAction)toggleLines:(id)sender {
    UISwitch *button = (UISwitch *)sender;
    lorenzView.drawLines = button.on;
}

/*void MyDrawColoredPattern (void *info, CGContextRef context) {
    
    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, radians(90), 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 16, 16, 4, 0, radians(45), 0);
    CGContextFillPath(context);
    
}*/

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    
    CGFloat offset = 30.0;
    
    if (savedDrawingImage) [savedDrawingImage drawInRect:layer.frame];
    CGColorRef pointColor = [UIColor whiteColor].CGColor;
    CGContextSetFillColorWithColor(context, pointColor);
    
//    CGFloat xd = _x/_z * zoom + offset;
//    CGFloat xy = _y/z * zoom + offset;
    
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

- (IBAction)toggleInitialCoordinatesAdjuster:(id)sender {
    if (sender == xyzCoordinatesButton) {
        if (!xyzValueAdjusterViewController) {
            xyzValueAdjusterViewController = [[XYZValueAdjusterViewController alloc] initWithNibName:@"XYZValueAdjusterViewController" bundle:nil];
            [self.view addSubview:xyzValueAdjusterViewController.view];
            CGPoint offsetPoint = xyzCoordinatesButton.frame.origin;
            CGRect frame = xyzValueAdjusterViewController.view.frame;
            offsetPoint = CGPointMake(offsetPoint.x, offsetPoint.y+xyzCoordinatesButton.frame.size.height);
            frame = CGRectMake(offsetPoint.x, offsetPoint.y, frame.size.width, frame.size.height);
            xyzValueAdjusterViewController.view.frame = frame;
            frame = xyzValueAdjusterViewController.view.frame;

            NSKeyValueObservingOptions options =
            NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionPrior;
            
            [xyzValueAdjusterViewController addObserver:self forKeyPath:@"x" options:0 context:NULL];
            [xyzValueAdjusterViewController addObserver:self forKeyPath:@"y" options:0 context:NULL];
            [xyzValueAdjusterViewController addObserver:self forKeyPath:@"z" options:0 context:NULL];
        }
        
        xyzValueAdjusterViewController.view.hidden = !xyzValueAdjusterViewController.view.hidden;
    }
}

- (IBAction)toggleLorenzValueAdjuster:(id)sender {
    if (sender == lorenzValuesButton) {
        if (!lorenzValueAdjusterViewController) {
            lorenzValueAdjusterViewController = [[HABCValueAdjusterViewController alloc] initWithNibName:@"HABCValueAdjusterViewController" bundle:nil];
            [self.view addSubview:lorenzValueAdjusterViewController.view];
            CGPoint offsetPoint = lorenzValuesButton.frame.origin;
            CGRect frame = lorenzValueAdjusterViewController.view.frame;
            offsetPoint = CGPointMake(offsetPoint.x, offsetPoint.y+lorenzValuesButton.frame.size.height);
            frame = CGRectMake(offsetPoint.x, offsetPoint.y, frame.size.width, frame.size.height);
            lorenzValueAdjusterViewController.view.frame = frame;
            frame = lorenzValueAdjusterViewController.view.frame;
            
            NSKeyValueObservingOptions options =
            NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionPrior;
            
            [lorenzValueAdjusterViewController addObserver:self forKeyPath:@"h" options:0 context:NULL];
            [lorenzValueAdjusterViewController addObserver:self forKeyPath:@"a" options:0 context:NULL];
            [lorenzValueAdjusterViewController addObserver:self forKeyPath:@"b" options:0 context:NULL];
            [lorenzValueAdjusterViewController addObserver:self forKeyPath:@"c" options:0 context:NULL];
        }
        
        lorenzValueAdjusterViewController.view.hidden = !lorenzValueAdjusterViewController.view.hidden;
        if (!lorenzValueAdjusterViewController.view.hidden) {
            [lorenzValueAdjusterViewController setH:lorenzView.h    A:lorenzView.a
                                                  B:lorenzView.b    C:lorenzView.c];
        }
    }

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context  {
    
    if (object == xyzValueAdjusterViewController) {
        double x = [xyzValueAdjusterViewController.x doubleValue];
        double y = [xyzValueAdjusterViewController.y doubleValue];
        double z = [xyzValueAdjusterViewController.z doubleValue];
        
        NSString *coordinates = [NSString stringWithFormat:@"x: %0.2f; y: %0.2f; z: %0.2f", x, y, z];
        [xyzCoordinatesButton setTitle:coordinates forState:UIControlStateNormal];
        [lorenzView setX:x Y:y Z:z];
        NSLog(coordinates);
    } else if (object == lorenzValueAdjusterViewController) {
        double h = [lorenzValueAdjusterViewController.h doubleValue];
        double a = [lorenzValueAdjusterViewController.a doubleValue];
        double b = [lorenzValueAdjusterViewController.b doubleValue];
        double c = [lorenzValueAdjusterViewController.c doubleValue];
        
        NSString *lorenzValues = [NSString stringWithFormat:@"h: %0.2f; a: %0.2f; b: %0.2f; c: %0.2f", h, a, b, c];
        [lorenzValuesButton setTitle:lorenzValues forState:UIControlStateNormal];
        [lorenzView setH:h A:a B:b C:c];
        NSLog(lorenzValues);
        
    }
}



@end
