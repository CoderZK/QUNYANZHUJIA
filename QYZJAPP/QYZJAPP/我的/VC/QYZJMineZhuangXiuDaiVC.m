//
//  QYZJMineZhuangXiuDaiVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineZhuangXiuDaiVC.h"

@interface QYZJMineZhuangXiuDaiVC ()
@property (weak, nonatomic) IBOutlet UITextView *TV;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@end

@implementation QYZJMineZhuangXiuDaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"装修贷";
    self.TV.layer.borderWidth = 0.6f;
    self.TV.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}


@end
