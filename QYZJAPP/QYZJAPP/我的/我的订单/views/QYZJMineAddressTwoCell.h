//
//  QYZJMineAddressTwoCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineAddressTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightCons;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;
@property (weak, nonatomic) IBOutlet UIImageView *dizhiImgV;
@property (weak, nonatomic) IBOutlet UIButton *deleteBt;
@end

NS_ASSUME_NONNULL_END
