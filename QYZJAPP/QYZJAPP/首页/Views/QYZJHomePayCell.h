//
//  QYZJHomePayCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJHomePayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB1;
@property (weak, nonatomic) IBOutlet UILabel *typeLB2;
@property (weak, nonatomic) IBOutlet UILabel *qianDanLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,assign)NSInteger type; // 0首页 1 我的支付
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusCons;
@end

NS_ASSUME_NONNULL_END
