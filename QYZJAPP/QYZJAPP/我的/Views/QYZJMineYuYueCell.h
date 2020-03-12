//
//  QYZJMineYuYueCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineYuYueCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *tyepLB1;
@property (weak, nonatomic) IBOutlet UILabel *typeLB2;
@property (weak, nonatomic) IBOutlet UILabel *LB1;
@property (weak, nonatomic) IBOutlet UILabel *LB2;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@property(nonatomic,strong)QYZJMoneyModel *model;

@end

NS_ASSUME_NONNULL_END
