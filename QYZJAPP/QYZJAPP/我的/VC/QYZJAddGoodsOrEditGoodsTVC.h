//
//  QYZJAddGoodsOrEditGoodsTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJAddGoodsOrEditGoodsTVC : BaseTableViewController
@property(nonatomic,strong)QYZJFindModel *dataModel;
@property(nonatomic,assign)NSInteger type; //0 修改 1 添加
@end

NS_ASSUME_NONNULL_END
