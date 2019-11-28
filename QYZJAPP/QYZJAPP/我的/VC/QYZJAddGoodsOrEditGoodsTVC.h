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
@property(nonatomic,assign)NSInteger type; //1 修改 0 添加 2 已下架
@property(nonatomic,strong)NSString *shopId;
@property(nonatomic,strong)NSString *goodsId;
@end

NS_ASSUME_NONNULL_END
