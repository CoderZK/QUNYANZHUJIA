//
//  QYZJHomeFourCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QYZJHomeFourCell;
@protocol QYZJHomeFourCellDelegate <NSObject>
- (void)didClickHomeFourCell:(QYZJHomeFourCell *)cell index:(NSInteger)index;
@end

@interface QYZJHomeFourCell : UITableViewCell
@property(nonatomic,assign)id delegate;
@end

NS_ASSUME_NONNULL_END
