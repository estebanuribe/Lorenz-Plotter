//
//  HABCValueAdjusterViewController.h
//  Lorenz
//
//  Created by Esteban Uribe on 9/11/12.
//  Copyright (c) 2012 Esteban Uribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HABCValueAdjusterViewController : UIViewController
{
    IBOutlet UITextField *hValue;
    IBOutlet UITextField *aValue;
    IBOutlet UITextField *bValue;
    IBOutlet UITextField *cValue;
}

@property (retain) NSNumber *h;
@property (retain) NSNumber *a;
@property (retain) NSNumber *b;
@property (retain) NSNumber *c;

- (void) setH:(double)h A:(double)a B:(double)b C:(double)c;

- (IBAction)updateValue:(id)sender;

@end
