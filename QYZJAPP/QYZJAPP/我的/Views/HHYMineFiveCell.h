//
//  HHYMineFiveCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HHYMineFiveCellDelegate <NSObject>

- (void)didClickFiveCellWithIndex:(NSInteger )index;


@end


@interface HHYMineFiveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *friendsLB;
@property (weak, nonatomic) IBOutlet UILabel *subscribeLB;
@property(nonatomic,assign)id<HHYMineFiveCellDelegate>delegate;
@property(nonatomic,strong)QYZJUserModel *model;
@end

NS_ASSUME_NONNULL_END
