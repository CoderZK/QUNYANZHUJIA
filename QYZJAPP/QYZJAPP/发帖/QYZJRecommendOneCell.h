//
//  QYZJRecommendOneCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJRecommendOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB1;
@property (weak, nonatomic) IBOutlet UILabel *typeLB2;
@property (weak, nonatomic) IBOutlet UILabel *typeLB3;
@property (weak, nonatomic) IBOutlet UILabel *qianDanLB;
@property (weak, nonatomic) IBOutlet UILabel *statusLB;

@property(nonatomic,strong)QYZJFindModel *model;

@end

NS_ASSUME_NONNULL_END
