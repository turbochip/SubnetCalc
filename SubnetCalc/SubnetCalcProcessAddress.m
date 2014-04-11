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
	return(256-(NSInteger)intOctetValue);
}

/* calcSubnetID uses the magic number and interesting octet to determine
 the subnet containing the ipAddress. */
- (NSString *)calcSubnetID:(NSMutableArray *) ipAddr withMagic:(NSInteger) Magic andIntOctet: (NSInteger)intOctet
{
    return [NSString stringWithFormat:@"%d",(int)(trunc([ipAddr[intOctet] intValue]/Magic)*Magic)];
    
	//return 1;
    //trunc(ipAddr[intOctet]/Magic)*Magic;
}

- (NSMutableArray *)calcFirstAddress:(NSMutableArray *) netID withIntOctet:(NSInteger) intOctet
{
    for (int i=0;i<4;i++) {
        if(i<=intOctet) {
            self.FirstAddr[i]=netID[i];
        }else {
            self.FirstAddr[i]=@"0";
        }
    }
    self.FirstAddr[3]=[NSString stringWithFormat:@"%d",
                       [netID[3] intValue]+1];
    return _FirstAddr;
    
}

- (NSMutableArray *)calcLastAddress:(NSMutableArray *) bcastAddr
{
    for (int i=0;i<4;i++) {
        self.LastAddr[i]=bcastAddr[i];
    }
    self.LastAddr[3]=[NSString stringWithFormat:@"%d",
                       [self.LastAddr[3] intValue]-1];
    return self.LastAddr;
    
}


- (NSMutableArray *)calcBroadcastAddress:(NSMutableArray *) netID withIntOctet:(NSInteger) intOctet andMagicNum: (NSInteger) Magic
{
    for (int i=0;i<4;i++) {
        if(i<intOctet) {
            self.BroadcastAddr[i]=netID[i];
        }else {
            if(i>intOctet) {
                self.BroadcastAddr[i]=@"255";
            }else {
                self.BroadcastAddr[i]=[NSString stringWithFormat:@"%ld",[netID[i] intValue]+Magic-1];
            }
        }
    }
    
    return self.BroadcastAddr;
    
}



/*doCalculationsFor calls the methods that do all the calculations.
 It seemed to make more sense for these to go here rather than in the
 controller. */
- (void)doCalculationsFor:(NSString *)inaddr andSubnet:(NSString *)Subnet
{
    NSLog(@"%@",inaddr);
    NSLog(@"%@",Subnet);
    self.IPAddr=[self parseAddr:inaddr];
    self.SubnetMask=[self parseAddr:Subnet];
    self.intOctet=[self interestingOctet:self.SubnetMask];
    self.magicNum=[self calcMagicNum:[self.SubnetMask[self.intOctet] intValue]];
    for(int i=0;i<4;i++) {
        if(i==self.intOctet){
            self.NetworkID[i]=[self calcSubnetID:self.IPAddr withMagic:self.magicNum andIntOctet:self.intOctet];
        } else {
            if([self.SubnetMask[i] intValue ]==255)
            {
                self.NetworkID[i]=self.IPAddr[i];
            } else {
                self.NetworkID[i]=@"0";
            }
        }
    }
    self.FirstAddr=[self calcFirstAddress:self.NetworkID withIntOctet:self.intOctet];
    self.BroadcastAddr=[self calcBroadcastAddress:self.NetworkID withIntOctet:self.intOctet andMagicNum:self.magicNum];
    self.LastAddr=[self calcLastAddress:self.BroadcastAddr];
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

- (NSMutableArray *)NetworkID
{
    if(!_NetworkID) _NetworkID=[[NSMutableArray alloc] init];
    
    return _NetworkID;
}

- (NSMutableArray *)FirstAddr
{
    if(!_FirstAddr) _FirstAddr=[[NSMutableArray alloc] init];
    
    return _FirstAddr;
}

- (NSMutableArray *)LastAddr
{
    if(!_LastAddr) _LastAddr=[[NSMutableArray alloc] init];
    
    return _LastAddr;
}

- (NSMutableArray *)BroadcastAddr
{
    if(!_BroadcastAddr) _BroadcastAddr=[[NSMutableArray alloc] init];
    
    return _BroadcastAddr;
}

@end

