//
//  QYZJFindShopCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJFindShopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *leftMoneyLB;
@property (weak, nonatomic) IBOutlet UILabel *rightMoneyLB;
@property(nonatomic,strong)NSArray<QYZJFindModel *> *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *leftGouImgV;
@property (weak, nonatomic) IBOutlet UIImageView *rightGouImgV;
@end

NS_ASSUME_NONNULL_END
