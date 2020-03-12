//
//  QYZJZhiBoCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJZhiBoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property (weak, nonatomic) IBOutlet UILabel *leftLb1;
@property (weak, nonatomic) IBOutlet UILabel *leftLb2;
@property (weak, nonatomic) IBOutlet UILabel *rightLb1;
@property (weak, nonatomic) IBOutlet UILabel *rightLb2;

@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
