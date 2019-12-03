//
//  QYZJMineTiXianVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineTiXianVC.h"
#import "QYZJMineBankListTVC.h"
#import "QYZJAddBankTVC.h"
@interface QYZJMineTiXianVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property (weak, nonatomic) IBOutlet UILabel *desLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLBOne;
@property (weak, nonatomic) IBOutlet UILabel *moneyTwoLB;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArray;
@property(nonatomic,strong)NSString *bankId;
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
    [self getFreezeMoneyData];
    [self getFreezeMoneyTwoData];
    
    
}
- (IBAction)chooseAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
      QYZJMineBankListTVC * vc =[[QYZJMineBankListTVC alloc] init];
      vc.hidesBottomBarWhenPushed = YES;
        Weak(weakSelf);
        vc.sendBankBlock = ^(QYZJMoneyModel * _Nonnull model) {
            
            [weakSelf.imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.logo]]  placeholderImage:[UIImage imageNamed:@"369"]];
                weakSelf.rightLB.hidden = YES;
                weakSelf.titleLB.text = model.name;
                weakSelf.numberLB.text = model.bank_account;
                weakSelf.titleLB.hidden = weakSelf.numberLB.hidden = NO;
            weakSelf.bankId = model.ID;
            
        };
      [self.navigationController pushViewController:vc animated:YES];
    }else {
        //确认提现
        
        [self getMoneyAction];
       
    }
    
    
}


- (void)getMoneyAction {
    
    if (self.bankId == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择银行卡"];
        return;
    }
    if ([self.moneyTF.text floatValue] < 20) {
        [SVProgressHUD showErrorWithStatus:@"最小提现金额为20元"];
        return;
    }
    
    if ([self.moneyTF.text floatValue] > self.dataModel.money) {
        [SVProgressHUD showErrorWithStatus:@"提现金额超出可提现金额"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"money"] = self.moneyTF.text;
    dict[@"bank_id"] = self.bankId;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_addCashURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
          
            [SVProgressHUD showSuccessWithStatus:@"提现生情提交成功"];
            
            NSString * moneyStr = [NSString stringWithFormat:@"%0.2f",[[NSString stringWithFormat:@"%@",responseObject[@"result"]] floatValue]];
                       NSString * moneyTwo = [NSString stringWithFormat:@"%0.2f",self.dataModel.money - [self.moneyTF.text floatValue]];
                                  NSString * str = [NSString stringWithFormat:@"可提现金额%@元(冻结总金额%@元)",moneyTwo,moneyStr];
                                  self.moneyLBOne.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlack112 textColorOne:OrangeColor textColorTwo:OrangeColor nsrangeOne:NSMakeRange(5, moneyTwo.length) nsRangeTwo:NSMakeRange(str.length - moneyStr.length - 1-1, moneyStr.length)];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
     
        
    }];
}



- (void)getFreezeMoneyData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_cashFreezeMoneyURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            NSString * moneyStr = [NSString stringWithFormat:@"%0.2f",[[NSString stringWithFormat:@"%@",responseObject[@"result"]] floatValue]];
            NSString * moneyTwo = [NSString stringWithFormat:@"%0.2f",self.dataModel.money];
                       NSString * str = [NSString stringWithFormat:@"可提现金额%@元(冻结总金额%@元)",moneyTwo,moneyStr];
                       self.moneyLBOne.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlack112 textColorOne:OrangeColor textColorTwo:OrangeColor nsrangeOne:NSMakeRange(5, moneyTwo.length) nsRangeTwo:NSMakeRange(str.length - moneyStr.length - 1-1, moneyStr.length)];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
}

//动接总金额
- (void)getFreezeMoneyTwoData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"money"] = @(self.dataModel.money);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_freezeMoneyURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            NSString * moneyStr = [NSString stringWithFormat:@"%0.2f",[[NSString stringWithFormat:@"%@",responseObject[@"result"]] floatValue]];
            
            NSString * str = [NSString stringWithFormat:@"冻结总金额%@元",moneyStr];
            self.moneyTwoLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlack112 textColorTwo:OrangeColor nsrange:NSMakeRange(5, moneyStr.length)];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
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
                self.bankId = arr[0].ID;
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
