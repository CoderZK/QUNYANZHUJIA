//
//  QYZJMineBaoXiuCellTableViewCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineBaoXiuCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIButton *rightBT;
@property (weak, nonatomic) IBOutlet UILabel *contentTwoLB;
@property(nonatomic,strong)QYZJFindModel *model;

@end

NS_ASSUME_NONNULL_END


