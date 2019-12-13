//
//  QYZJAddZiLiaoTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJAddZiLiaoTVC : BaseTableViewController
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,assign)NSInteger type; //0 正常单子添加资料 1 新建交付
@property(nonatomic,strong)QYZJFindModel *dataModel;
@end

NS_ASSUME_NONNULL_END
