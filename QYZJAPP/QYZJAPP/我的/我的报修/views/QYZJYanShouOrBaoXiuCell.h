//
//  QYZJYanShouOrBaoXiuCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJYanShouOrBaoXiuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hCons;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property(nonatomic,assign)NSInteger type; // 0验收 1 报修
@property(nonatomic,strong)QYZJMoneyModel *model;
@end

NS_ASSUME_NONNULL_END
