//
//  QYZJHomeTwoCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QYZJHomeTwoCellDelegate <NSObject>

- (void)didClickHomeTwoCellIndex:(NSInteger)index;

@end

@interface QYZJHomeTwoCell : UITableViewCell
@property(nonatomic,assign)id<QYZJHomeTwoCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
