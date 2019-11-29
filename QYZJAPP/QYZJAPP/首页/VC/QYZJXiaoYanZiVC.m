//
//  QYZJXiaoYanZiVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/22.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJXiaoYanZiVC.h"

@interface QYZJXiaoYanZiVC ()

@end

@implementation QYZJXiaoYanZiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel * LB = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, ScreenW - 110, 20)];
    LB.backgroundColor = [UIColor redColor];
    LB.numberOfLines = 0;
    [self.view addSubview:LB];
    
    LB.attributedText = [@"回复内容: 啊得覅去玩IE覅秦得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦皇岛得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦皇岛得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦皇岛得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦皇岛皇岛房地产via是你大V就皇岛房地产via是你大V就" getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor80 textColorTwo:[UIColor blackColor] nsrange:NSMakeRange(0, 5)];
    CGFloat hh  =  [@"回复内容: 啊得覅去玩IE覅秦得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦皇岛得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦皇岛得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦皇岛得覅去玩IE覅秦皇岛房地产via是你大V就得覅去玩IE覅秦皇岛皇岛房地产via是你大V就皇岛房地产via是你大V就" getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 110];
    LB.mj_h = hh;
    
    
    
    
    
}


@end
