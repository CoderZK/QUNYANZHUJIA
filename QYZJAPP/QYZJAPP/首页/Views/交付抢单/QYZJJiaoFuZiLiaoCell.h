//
//  QYZJJiaoFuZiLiaoCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QYZJJiaoFuZiLiaoCell;
@protocol QYZJJiaoFuZiLiaoCellDelegate <NSObject>

- (void)didClickQYZJJiaoFuZiLiaoCell:(QYZJJiaoFuZiLiaoCell *)cell withIndex:(NSInteger)index withIsdelect:(BOOL )isDelect;

@end

@interface QYZJJiaoFuZiLiaoCell : UITableViewCell
@property(nonatomic,strong)UILabel *leftLB;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)id<QYZJJiaoFuZiLiaoCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
