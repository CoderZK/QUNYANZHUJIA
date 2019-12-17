//
//  QYZJMineBaoXiuDetailTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineBaoXiuDetailTVC : BaseTableViewController
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,assign)NSInteger type; // 1 交付阶段详情
//@property(nonatomic,strong)NSString *ID;
@end

NS_ASSUME_NONNULL_END
