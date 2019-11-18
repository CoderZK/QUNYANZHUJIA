//
//  QYZJZengZhiFWCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface QYZJZengZhiFWCell : UITableViewCell
@property(nonatomic,strong)NSArray<QYZJMoneyModel *> *dataArray;
@end

@interface QYZJZengZhiFuWuNeiView : UIView
@property(nonatomic,strong)UIButton *bt;
@property(nonatomic,strong)UILabel *tuiJianLB,*titleLB,*moneyLB;
@property(nonatomic,copy)void(^clickTuiJianBlock)(NSInteger index);
@property(nonatomic,strong)QYZJMoneyModel *model;
@end
