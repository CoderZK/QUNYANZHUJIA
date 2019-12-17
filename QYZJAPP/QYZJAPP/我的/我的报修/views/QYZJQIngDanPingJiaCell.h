//
//  QYZJQIngDanPingJiaCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJQIngDanPingJiaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property(nonatomic,strong)QYZJFindModel  *model;
@end

NS_ASSUME_NONNULL_END
