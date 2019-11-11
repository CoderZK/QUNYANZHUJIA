//
//  QYZJChangePayPasswordOneVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJChangePayPasswordOneVC.h"
#import "QYZJChangePayPasswordTwoVC.h"
@interface QYZJChangePayPasswordOneVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldpassdTF;
@property (weak, nonatomic) IBOutlet UITextField *nPassdTF;
@property (weak, nonatomic) IBOutlet UITextField *nTwoPassdTF;
@end

@implementation QYZJChangePayPasswordOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 100) {
        QYZJChangePayPasswordTwoVC * vc =[[QYZJChangePayPasswordTwoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
