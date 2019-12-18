//
//  QYZJSetBaoXiuTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJSetBaoXiuTVC : BaseTableViewController
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *dataArray;
@property(nonatomic,strong)NSString *ID;
@end

NS_ASSUME_NONNULL_END
