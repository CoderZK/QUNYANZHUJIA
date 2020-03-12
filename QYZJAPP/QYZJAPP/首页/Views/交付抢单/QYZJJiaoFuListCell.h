//
//  QYZJJiaoFuListCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJJiaoFuListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB1;
@property (weak, nonatomic) IBOutlet UILabel *typeLB2;
@property (weak, nonatomic) IBOutlet UILabel *typeLB3;
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property(nonatomic,strong)QYZJFindModel *model;
@end

NS_ASSUME_NONNULL_END
