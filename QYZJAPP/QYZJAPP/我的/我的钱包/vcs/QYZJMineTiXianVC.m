//
//  QYZJMineTiXianVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineTiXianVC.h"
#import "QYZJMineBankListTVC.h"
@interface QYZJMineTiXianVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property (weak, nonatomic) IBOutlet UILabel *desLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLBOne;
@property (weak, nonatomic) IBOutlet UILabel *moneyTwoLB;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArray;
@property(nonatomic,assign)NSInteger page;
@end

@implementation QYZJMineTiXianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的提现";
    self.desLB.text = @"1.单笔提现最低金额为20元\n2.提交提现申请后一周内提现金额到账\n3.未缴纳保证金, 提现时冻结提现金额5%\n4.反馈佣金冻结6小时, 到时自动转入提现钱包";
    
    
    self.confirmBt.layer.cornerRadius = 3;
    self.confirmBt.clipsToBounds = YES;
    
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    
    
}
- (IBAction)chooseAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
    }else {
        QYZJMineBankListTVC * vc =[[QYZJMineBankListTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(1);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_bankListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<QYZJMoneyModel *>*arr = [QYZJMoneyModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (arr.count > 0) {
                [self.imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:arr[0].logo]]  placeholderImage:[UIImage imageNamed:@"369"]];
                self.rightLB.hidden = YES;
                self.titleLB.text = arr[0].name;
                self.numberLB.text = arr[0].bank_account;
                self.titleLB.hidden = self.numberLB.hidden = NO;
            }else {
                self.rightLB.hidden = NO;
                self.titleLB.hidden = self.numberLB.hidden = YES;
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}


@end
