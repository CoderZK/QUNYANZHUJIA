//
//  QYZJHomeFiveCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJHomeFiveCell : UITableViewCell
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,assign)NSInteger type; // 0 首页 1 发现广场
@end

NS_ASSUME_NONNULL_END
