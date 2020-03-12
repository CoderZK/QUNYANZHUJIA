//
//  QYZJFangDanTwoTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJFangDanTwoTVC : BaseTableViewController
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,copy)void(^addDemndBlock)(NSMutableArray<QYZJFindModel *> *arr);
@end

NS_ASSUME_NONNULL_END
