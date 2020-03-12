//
//  QYZJBankListCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJBankListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;
@property(nonatomic,strong)QYZJMoneyModel * model;
@end

NS_ASSUME_NONNULL_END
