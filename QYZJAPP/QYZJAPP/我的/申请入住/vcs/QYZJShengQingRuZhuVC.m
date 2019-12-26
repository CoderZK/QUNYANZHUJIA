//
//  QYZJShengQingRuZhuVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJShengQingRuZhuVC.h"
#import "QYZJShenQingRuZhuTwoVC.h"
@interface QYZJShengQingRuZhuVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UIButton *selectBt;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *quDaoArr;
@property(nonatomic,strong)NSString *labelStr,*labelID;
@end

@implementation QYZJShengQingRuZhuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请入驻";
    
    self.quDaoArr = [NSMutableArray mutableCopy];
    [self getQuDaoArrList];
    
}

- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
        
        if (self.quDaoArr.count == 0) {
                   [SVProgressHUD showErrorWithStatus:@"获取中,请先完善其它内容"];
                   [self getQuDaoArrList];
                   return;
        }
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;

       

        NSMutableArray * arr = @[].mutableCopy;
        for (zkPickModel  * model  in self.quDaoArr) {
            [arr addObject:model.name];
        }
        picker.arrayType = titleArray;
        picker.array = arr.mutableCopy;
        picker.selectLb.text = @"";
        [picker show];
    }else if (sender.tag == 101) {
        
        sender.selected = !sender.selected;
        
    }else if (sender.tag == 102) {
        
        
        
    }else {
        
        if (self.selectBt.selected == NO) {
            [SVProgressHUD showErrorWithStatus:@"请同意并阅读服务协议"];
            return;
        }else {
         
            if (self.labelID ==nil) {
                [SVProgressHUD showErrorWithStatus:@"请选择身份"];
                return;
            }
            [self checkP];
            
        }
       
        
    }

}

- (void)checkP {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_addApplicationCheckURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
    
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            QYZJShenQingRuZhuTwoVC * vc =[[QYZJShenQingRuZhuTwoVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.typeID = self.labelID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
   
        
    }];
}



- (void)getQuDaoArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_labelListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.quDaoArr = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    
    
    self.labelID = self.quDaoArr[leftIndex].ID;
    self.labelStr = self.quDaoArr[leftIndex].name;
    self.titleTF.text = self.labelStr;
    
    
}


@end
