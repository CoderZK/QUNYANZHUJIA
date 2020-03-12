//
//  QYZJMineTiXianCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineTiXianCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)QYZJMoneyModel *model;
@property (weak, nonatomic) IBOutlet UILabel *moneyTwoLB;
@end

NS_ASSUME_NONNULL_END
