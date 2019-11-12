//
//  HHYMineFourCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HHYMineFourCell;
@protocol HHYMineFourCellDelegate <NSObject>

- (void)didClickView:(HHYMineFourCell *)cell withIndex:(NSInteger )index;

@end

@interface HHYMineFourCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *friendsLB;
@property (weak, nonatomic) IBOutlet UILabel *flowerLB;
@property (weak, nonatomic) IBOutlet UILabel *fansLB;
@property (weak, nonatomic) IBOutlet UILabel *subscribeLB;

@property(nonatomic,assign)id<HHYMineFourCellDelegate>delegate;

@property(nonatomic,strong)QYZJUserModel *model;
@end

NS_ASSUME_NONNULL_END
