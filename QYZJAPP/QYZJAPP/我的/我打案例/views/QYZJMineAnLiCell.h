//
//  QYZJMineAnLiCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineAnLiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titelLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property(nonatomic,strong)QYZJFindModel *model;
@end

NS_ASSUME_NONNULL_END
