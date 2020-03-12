//
//  QYZJOtherCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJOtherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *whiteV;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *blackV;

@end

NS_ASSUME_NONNULL_END
