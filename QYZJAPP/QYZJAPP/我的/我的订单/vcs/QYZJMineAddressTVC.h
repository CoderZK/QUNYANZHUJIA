//
//  QYZJMineAddressTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineAddressTVC : BaseTableViewController

@property(nonatomic,copy)void(^chooseAddressBlock)(QYZJMoneyModel *model);

@end

NS_ASSUME_NONNULL_END
