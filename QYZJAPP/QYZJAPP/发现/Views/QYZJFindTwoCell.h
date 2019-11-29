//
//  QYZJFindTwoCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYZJFindTwoCell;

@protocol QYZJFindTwoCellDelegate <NSObject>

- (void)didClickFindTwoCell:(QYZJFindTwoCell *)cell withIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface QYZJFindTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *deleteCollectbT;
@property (weak, nonatomic) IBOutlet UIButton *zanBt;
@property (weak, nonatomic) IBOutlet UIButton *pingLunBt;
@property (weak, nonatomic) IBOutlet UIButton *collectBt;
@property(nonatomic,assign)NSInteger type; // 0 发现广场 1 收藏
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;
@property(nonatomic,strong)QYZJFindModel *model;

@property(nonatomic,assign)id<QYZJFindTwoCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
