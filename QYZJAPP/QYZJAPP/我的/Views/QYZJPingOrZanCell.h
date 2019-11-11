//
//  QYZJPingOrZanCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJPingOrZanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgVOne;
@property (weak, nonatomic) IBOutlet UIImageView *imgVTwo;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;

@end

NS_ASSUME_NONNULL_END
