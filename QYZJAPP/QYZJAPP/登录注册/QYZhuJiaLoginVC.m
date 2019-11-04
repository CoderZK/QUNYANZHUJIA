//
//  QYZhuJiaLoginVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZhuJiaLoginVC.h"
#import "QYZJFindPasswordVC.h"
#import "QYZJRegistVC.h"
@interface QYZhuJiaLoginVC ()

@end

@implementation QYZhuJiaLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"注册" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        QYZJRegistVC * vc =[[QYZJRegistVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

}
- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
     
        QYZJRegistVC * vc =[[QYZJRegistVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        
        QYZJFindPasswordVC * vc =[[QYZJFindPasswordVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    
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
