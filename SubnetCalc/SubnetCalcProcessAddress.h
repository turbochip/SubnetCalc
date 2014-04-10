//
//  SubnetCalcProcessAddress.h
//  SubnetCalc
//
//  Created by Chip Cox on 4/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubnetCalcProcessAddress : NSObject
@property (strong, nonatomic) NSMutableArray *NetworkID;
@property (strong, nonatomic) NSMutableArray *SubnetMask;
@property (strong, nonatomic) NSMutableArray *IPAddr;
@property (strong, nonatomic) NSMutableArray *BroadcastAddr;
@property (strong, nonatomic) NSMutableArray *FirstAddr;
@property (strong, nonatomic) NSMutableArray *LastAddr;
@property (readwrite, nonatomic) NSInteger intOctet;
@property (readwrite, nonatomic) NSInteger magicNum;

- (void)doCalculationsFor:(NSString *)inaddr andSubnet:(NSString *)Subnet;

- (NSMutableArray *)parseAddr: (NSString *) InAddr;

- (NSString *) buildAddrString:(NSMutableArray *)addrArray;
@end


