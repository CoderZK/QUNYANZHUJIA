//
//  QYZJAddBankTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAddBankTVC.h"
#import "QYZJAddBankCell.h"
@interface QYZJAddBankTVC ()<zkPickViewDelelgate,UITextFieldDelegate>
@property(nonatomic,strong)NSArray *leftTitleArray;
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *bankArr;
@property(nonatomic,strong)NSString *str1,*str2,*str3,*ID;
@end

@implementation QYZJAddBankTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJAddBankCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.leftTitleArray = @[@"联系方式",@"地址",@"详细地址"];
    self.bankArr = @[].mutableCopy;
    [self getCityData];
    [self addFootView];
    self.navigationItem.title = @"添加银行卡";
    
    [self.tableView reloadData];
  
    
}

- (void)addFootView {

    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    footV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton * nextBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, ScreenW - 40, 45)];
    nextBt.layer.cornerRadius = 4;
    nextBt.clipsToBounds = YES;
    nextBt.titleLabel.font = kFont(15);
    [nextBt setTitle:@"提交" forState:UIControlStateNormal];
    [nextBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    [nextBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    [[nextBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {

        [self addBank];

    }];
    [footV addSubview:nextBt];
    self.tableView.tableFooterView = footV;

}


- (void)addBank {
    
    [self.tableView endEditing:YES];
    
    if (self.str1.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    if (self.str3.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入银行卡号"];
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary  * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"bankNo"] = self.str3;
    dict[@"bank_id"] = self.ID;
    dict[@"username"] = self.str1;
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_bindBankURL] parameters:dict  success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"添加银行卡成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}

- (void)getCityData {
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_bankListURL] parameters:@{@"NoToken":@"0"} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.bankArr = [QYZJMoneyModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJAddBankCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.TF.placeholder = self.leftTitleArray[indexPath.row];
    cell.backgroundColor = WhiteColor;
    cell.contentView.backgroundColor = WhiteColor;
    cell.TF.userInteractionEnabled = YES;
    cell.rightImgV.hidden = YES;
    cell.TF.delegate = self;
    cell.leftImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ico_%ld",indexPath.row+10]];
     cell.TF.keyboardType = UIKeyboardTypeDefault;
    if (indexPath.row == 0) {
        cell.TF.text = self.str1;
        cell.TF.placeholder = @"请输入姓名";
    }else if (indexPath.row == 1) {
        cell.TF.text = self.str2;
        cell.rightImgV.hidden = NO;
        cell.TF.userInteractionEnabled = cell.rightImgV.hidden = NO;
        cell.TF.placeholder = @"请选择银行卡";
    }else {
        cell.TF.text = self.str3;
        cell.TF.placeholder = @"请输入银行卡号";
        cell.TF.keyboardType = UIKeyboardTypeNumberPad;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        
        if (self.bankArr.count == 0) {
           [SVProgressHUD showErrorWithStatus:@"数据获取中..,先去填写其它资料"];
           [self getCityData];
           return;
        }
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        NSMutableArray * titleArr = @[].mutableCopy;
        for (QYZJMoneyModel * model  in self.bankArr) {
            [titleArr addObject:model.name];
        }
        picker.arrayType = titleArray;
        picker.array = titleArr;
        picker.selectLb.text = @"请选择银行卡";
        [picker show];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    QYZJAddBankCell * cell = (QYZJAddBankCell *)textField.superview.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0) {
        self.str1 = textField.text;
    }else {
        self.str3 = textField.text;
    }
    
    
}

#pragma mark ------- 点击筛选 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);

    
    self.ID = self.bankArr[leftIndex].ID;
    self.str2 = self.bankArr[leftIndex].name;
    [self.tableView reloadData];
    
}
@end
