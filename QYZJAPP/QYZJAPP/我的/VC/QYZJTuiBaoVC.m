//
//  QYZJTuiBaoVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJTuiBaoVC.h"

@interface QYZJTuiBaoVC ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;

@end

@implementation QYZJTuiBaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"保证金";
    self.moneyLB.text = [NSString stringWithFormat:@"%0.2f",self.bond_money];;
    self.confirmBt.layer.cornerRadius = 4;
    self.confirmBt.clipsToBounds = YES;
}

- (IBAction)action:(id)sender {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"money"] = @(self.bond_money);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_backBondURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"申请退保成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
}


@end
