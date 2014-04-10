//
//  SubnetCalcProcessAddress.m
//  SubnetCalc
// on git
//  Created by Chip Cox on 4/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "SubnetCalcProcessAddress.h"

@interface SubnetCalcProcessAddress ()

@end

@implementation SubnetCalcProcessAddress
- (NSMutableArray *)parseAddr:(NSString *)inaddr
{
	return (NSMutableArray *)[inaddr componentsSeparatedByString:@"."];
}

/* interestingOctet finds the octet that isn't 255 or 0
 This is the octet that will determine the subnetting.
 It takes in the sugnet array and returns the index of the 
 interesting octet. */
- (NSInteger)interestingOctet:(NSMutableArray *) addrArray
{
    int i;
	for(i=0;i<4;i++) {
		if(([addrArray[i] intValue] !=255) && ([addrArray[i] intValue]!=0))
			break;
	}
    return i;
}

/* calcMagicNum determines the magic number defined as 255-interesting octet.
 it takes in the value of the interesting octet and returns the magic number.*/
- (NSInteger)calcMagicNum:(NSInteger)intOctetValue
{
	return(255-(NSInteger)intOctetValue);
}

/* calcSubnetID uses the magic number and interesting octet to determine
 the subnet containing the ipAddress. */
- (NSInteger)calcSubnetID:(NSMutableArray *) ipAddr withMagic:(NSMutableArray *) Magic andIntOctet: (NSInteger)intOctet
{
	return 1;
    //trunc(ipAddr[intOctet]/Magic)*Magic;
}

/*doCalculationsFor calls the methods that do all the calculations.  
 It seemed to make more sense for these to go here rather than in the
 controller. */
- (void)doCalculationsFor:(NSString *)inaddr andSubnet:(NSString *)Subnet
{
    NSLog(@"%@",inaddr);
    NSLog(@"%@",Subnet);
    _IPAddr=[self parseAddr:inaddr];
    _SubnetMask=[self parseAddr:Subnet];
    _intOctet=[self interestingOctet:_SubnetMask];
    _magicNum=[self calcMagicNum:[_SubnetMask[_intOctet] intValue]];
}

/*buildAddrString - uses stringWithFormat to turn an array into an IP address string */
- (NSString *) buildAddrString:(NSMutableArray *)addrArray
{
    for(int i=0;i<4;i++) NSLog(@"%@ ",addrArray[i]);
    return [NSString stringWithFormat:@"%@.%@.%@.%@",
            addrArray[0],
            addrArray[1],
            addrArray[2],
            addrArray[3]];
}

@end
