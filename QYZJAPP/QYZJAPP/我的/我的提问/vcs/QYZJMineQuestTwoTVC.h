//
//  QYZJMineQuestTwoTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineQuestTwoTVC : BaseTableViewController
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,assign)NSInteger isPay;
@property(nonatomic,assign)NSInteger is_answer;
@end

NS_ASSUME_NONNULL_END
