//
//  SubnetCalcViewController.h
//  SubnetCalc
//
//  Created by Chip Cox on 4/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubnetCalcProcessAddress.h"

@interface SubnetCalcViewController : UIViewController
@property (strong, nonatomic) NSMutableArray * IPA;
@property (strong,nonatomic) SubnetCalcProcessAddress *ProcessAddr;
@end
