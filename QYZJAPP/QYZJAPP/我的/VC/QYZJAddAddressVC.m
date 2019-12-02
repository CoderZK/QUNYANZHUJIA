//
//  QYZJAddAddressVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAddAddressVC.h"

@interface QYZJAddAddressVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressCityTF;
@property (weak, nonatomic) IBOutlet UITextField *addreddTF;
@property (weak, nonatomic) IBOutlet UIButton *comfirmBt;

@end

@implementation QYZJAddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.comfirmBt.layer.cornerRadius = 5;
    self.comfirmBt.clipsToBounds = YES;
    
    
}
- (IBAction)action:(UIButton *)sender {
    
    if (sender.tag == 100) {
        //点击城市
        
        
    }else {
        
        
        
        
    }
    
    
    
    
    
}


@end
