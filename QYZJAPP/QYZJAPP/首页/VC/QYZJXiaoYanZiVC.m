//
//  QYZJXiaoYanZiVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/22.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJXiaoYanZiVC.h"

@interface QYZJXiaoYanZiVC ()
@property (weak, nonatomic) IBOutlet UIImageView *logoBt;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@end

@implementation QYZJXiaoYanZiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.contentLB.text = @"    小燕子是北京久久安居网路科技有限公司群燕筑家项目官网方客服，工作宗旨是\"服务好平台每位用户\"。\n     1、负责群燕筑家项目介绍，推广;\n      2、负责群燕筑家用户相关使用指导，包括但不限于（注册、入住、抢单、放单等）；\n        3、负责跟进解决用户纠纷投诉等问题。";
    if (isUPUPUP) {
        self.contentLB.text = @"    小燕子是北京久久安居网路科技有限公司群燕筑家项目官网方客服，工作宗旨是\"服务好平台每位用户\"。\n     1、负责群燕筑家项目介绍，推广;\n        2、负责跟进解决用户纠纷投诉等问题。";
    }
    
    self.logoBt.layer.cornerRadius = 35;
    self.logoBt.clipsToBounds = YES;
    
    self.nameLB.hidden = self.imgV.hidden = YES;
    
    
    
}


@end
