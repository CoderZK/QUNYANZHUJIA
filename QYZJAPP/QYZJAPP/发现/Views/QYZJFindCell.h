//
//  QYZJFindCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QYZJFindCell;
@protocol QYZJFindCellDelegate <NSObject>

- (void)didClickFindCell:(QYZJFindCell *)cell index:(NSInteger)index;

@end

@interface QYZJFindCell : UITableViewCell
@property(nonatomic,assign)NSInteger type; // 0 发现广场 1 收藏
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,assign)id<QYZJFindCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END








