//
//  QYZJMineInviteVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineInviteVC.h"

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
        
    }else {
        
        
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
