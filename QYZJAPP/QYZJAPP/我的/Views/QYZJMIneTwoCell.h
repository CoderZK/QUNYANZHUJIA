//
//  QYZJMIneTwoCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QYZJMIneTwoCell;

@protocol QYZJMIneTwoCellDelegate <NSObject>
- (void)didlMineTwoCell:(QYZJMIneTwoCell *)cell index:(NSInteger)index;
@end

@interface QYZJMIneTwoCell : UITableViewCell
@property(nonatomic,strong)NSArray *titleArr,*imgArr;
@property(nonatomic,assign)id<QYZJMIneTwoCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
