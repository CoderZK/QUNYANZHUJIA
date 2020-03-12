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
@property(nonatomic,assign)NSInteger type; // 1 交付阶段详情 // 2 保修
//@property(nonatomic,strong)NSString *ID;
@property(nonatomic,assign)NSInteger staus; //设置保修
@property(nonatomic,assign)BOOL isNoShow;
@end

NS_ASSUME_NONNULL_END
