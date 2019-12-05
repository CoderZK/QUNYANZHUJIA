//
//  QYZJMineYuHuiQuanCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineYuHuiQuanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *desLB;
@property (weak, nonatomic) IBOutlet UILabel *bottomLB;
@property(nonatomic,strong)QYZJMoneyModel *model;
@end

NS_ASSUME_NONNULL_END
