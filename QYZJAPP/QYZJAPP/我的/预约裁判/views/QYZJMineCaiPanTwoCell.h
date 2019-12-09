//
//  QYZJMineCaiPanTwoCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineCaiPanTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *titelLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property(nonatomic,strong)QYZJFindModel *model;
@end

NS_ASSUME_NONNULL_END
