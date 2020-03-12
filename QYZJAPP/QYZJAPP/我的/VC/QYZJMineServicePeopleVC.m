//
//  QYZJMineServicePeopleVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineServicePeopleVC.h"

@interface QYZJMineServicePeopleVC ()

@end

@implementation QYZJMineServicePeopleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系客服";
    
    self.view.backgroundColor =[UIColor groupTableViewBackgroundColor];
}
- (IBAction)action:(id)sender {
    
    UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打%@",@"18406564080"] preferredStyle:(UIAlertControllerStyleAlert)];
           UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
               
           }];
           UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"18406564080"]]];
            
           }];
           
           [alertVC addAction:action1];
           [alertVC addAction:action2];
           
           [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    
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
