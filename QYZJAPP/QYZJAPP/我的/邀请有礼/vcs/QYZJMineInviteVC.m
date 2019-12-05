//
//  QYZJMineInviteVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineInviteVC.h"
#import "QYZJMineYaoQingTVC.h"
@interface QYZJMineInviteVC ()
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property (weak, nonatomic) IBOutlet UILabel *codeLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation QYZJMineInviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"邀请有礼";
    self.leftBt.layer.cornerRadius = self.rightBt.layer.cornerRadius = 3;
    self.leftBt.clipsToBounds = self.rightBt.clipsToBounds = YES;
}
- (IBAction)action:(UIButton *)sender {
    if(sender.tag == 100) {
        
    }else if (sender.tag == 101) {
        QYZJMineYaoQingTVC * vc =[[QYZJMineYaoQingTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
        
    }
    
}



@end
