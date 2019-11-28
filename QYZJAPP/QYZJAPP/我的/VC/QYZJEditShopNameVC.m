//
//  QYZJEditShopNameVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJEditShopNameVC.h"

@interface QYZJEditShopNameVC ()
@property (weak, nonatomic) IBOutlet UIButton *comfirmBt;
@property (weak, nonatomic) IBOutlet UITextField *TF;

@end

@implementation QYZJEditShopNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.comfirmBt.layer.cornerRadius = 4;
    self.comfirmBt.clipsToBounds = YES;
    self.navigationItem.title = @"编辑";
    
    
}
- (IBAction)confirmAction:(id)sender {
    
    if (self.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入小店名称"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"name"] = self.TF.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editShopURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                if (self.sendShopNameBlock != nil) {
                    self.sendShopNameBlock(self.TF.text);
                }
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
     
        
    }];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
