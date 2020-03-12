//
//  QYZJSettingCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLB;
@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property (weak, nonatomic) IBOutlet UIImageView *jianTouImgV;
@property (weak, nonatomic) IBOutlet UISwitch *switchBt;

@end

NS_ASSUME_NONNULL_END
