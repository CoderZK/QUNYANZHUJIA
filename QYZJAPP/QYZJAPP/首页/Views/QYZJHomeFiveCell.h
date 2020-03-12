//
//  QYZJHomeFiveCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJHomeFiveCell : UITableViewCell
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,assign)NSInteger type; // 0 首页 1 发现广场
@property(nonatomic,assign)NSInteger moneyTtype; // 0 首页展示提问和预约 1 裁判(z展示预约) 2 教练
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBtMxCons;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@end

NS_ASSUME_NONNULL_END
