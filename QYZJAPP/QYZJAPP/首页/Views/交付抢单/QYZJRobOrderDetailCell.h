//
//  QYZJRobOrderDetailCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJRobOrderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titelLB;
@property (weak, nonatomic) IBOutlet UILabel *leftLB;
@property (weak, nonatomic) IBOutlet UIButton *gouTongBt;
@property(nonatomic,strong)QYZJWorkModel *model;
@property(nonatomic,assign)NSInteger type; // 1 推荐赚钱的详情
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@end

NS_ASSUME_NONNULL_END
