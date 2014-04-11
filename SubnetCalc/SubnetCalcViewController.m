//
//  SubnetCalcViewController.m
//  SubnetCalc
//
//  Created by Chip Cox on 4/2/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "SubnetCalcViewController.h"
#import "SubnetCalcProcessAddress.h"

@interface SubnetCalcViewController ()
/* properties associated with the fields on the form */
@property (weak, nonatomic) IBOutlet UITextField *IPAField;
@property (weak, nonatomic) IBOutlet UITextField *SubnetMaskField;
@property (weak, nonatomic) IBOutlet UILabel *IPAText;
@property (weak, nonatomic) IBOutlet UILabel *SubnetMaskText;
@property (weak, nonatomic) IBOutlet UILabel *intOctetText;
@property (weak, nonatomic) IBOutlet UILabel *MagicNumText;
@property (weak, nonatomic) IBOutlet UILabel *FirstAddrText;
@property (weak, nonatomic) IBOutlet UILabel *LastAddrText;
@property (weak, nonatomic) IBOutlet UILabel *BroadcastText;
@property (weak, nonatomic) IBOutlet UILabel *NetworkID;

@end

@implementation SubnetCalcViewController

- (SubnetCalcProcessAddress *)ProcessAddr {
    if(!_ProcessAddr) _ProcessAddr = [[SubnetCalcProcessAddress alloc] init];

    return _ProcessAddr;
}

/*CalcButton - action initiated by pressing the calculate button in the window
 it calls the model function to do all the calculations and displays them */
- (IBAction)CalcButton:(UIButton *)sender {
    NSLog(@"%@",self.IPAField.text);
    NSLog(@"%@",self.SubnetMaskField.text);
    [self.ProcessAddr doCalculationsFor:self.IPAField.text andSubnet:self.SubnetMaskField.text];
    self.IPAText.text=[NSString stringWithFormat:@"IP Address: %@",[self.ProcessAddr buildAddrString:self.ProcessAddr.IPAddr]];
    self.SubnetMaskText.text=[NSString stringWithFormat:@"Subnet Mask: %@",[self.ProcessAddr buildAddrString:self.ProcessAddr.SubnetMask]];
    self.intOctetText.text=[NSString stringWithFormat:@"Interesting Octet : %@",[NSString stringWithFormat:@"%ld",(long)self.ProcessAddr.intOctet+1 ]];
    self.MagicNumText.text=[NSString stringWithFormat:@"Magic #: %ld",self.ProcessAddr.magicNum];
    self.NetworkID.text=[NSString stringWithFormat:@"Network ID: %@",[self.ProcessAddr buildAddrString:self.ProcessAddr.NetworkID]];
    self.FirstAddrText.text=[NSString stringWithFormat:@"First Address: %@",[self.ProcessAddr buildAddrString:self.ProcessAddr.FirstAddr]];
    self.BroadcastText.text=[NSString stringWithFormat:@"Broadcast Address: %@",[self.ProcessAddr buildAddrString:self.ProcessAddr.BroadcastAddr]];
    self.LastAddrText.text=[NSString stringWithFormat:@"Last Address: %@",[self.ProcessAddr buildAddrString:self.ProcessAddr.LastAddr]];
}

@end
