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
// 0 0 头像 1 进店 2 收藏 3评论 4赞   5删除
- (void)didClickFindCell:(QYZJFindCell *)cell index:(NSInteger)index;

@end

@interface QYZJFindCell : UITableViewCell
@property(nonatomic,assign)NSInteger type; // 0 发现广场 1 收藏 // 2 发布
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,assign)id<QYZJFindCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END








