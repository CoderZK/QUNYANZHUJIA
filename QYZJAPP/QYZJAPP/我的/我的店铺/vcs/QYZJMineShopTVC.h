//
//  QYZJMineShopTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineShopTVC : BaseTableViewController
@property(nonatomic,strong)QYZJUserModel *dataModel;
@property(nonatomic,assign)BOOL isMine;
@property(nonatomic,strong)NSString *user_id;
@end

NS_ASSUME_NONNULL_END
