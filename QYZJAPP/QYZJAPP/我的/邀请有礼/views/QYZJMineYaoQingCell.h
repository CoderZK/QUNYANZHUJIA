//
//  QYZJMineYaoQingCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineYaoQingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *numberOneLB;
@property (weak, nonatomic) IBOutlet UILabel *numberTwoLB;
@property (weak, nonatomic) IBOutlet UILabel *numberThreeLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property(nonatomic,strong)QYZJFindModel *model;

@end

NS_ASSUME_NONNULL_END
