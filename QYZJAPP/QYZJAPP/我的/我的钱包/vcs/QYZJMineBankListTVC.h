//
//  QYZJMineBankListTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineBankListTVC : BaseTableViewController
@property(nonatomic,copy)void(^sendBankBlock)(QYZJMoneyModel *model);
@end

NS_ASSUME_NONNULL_END
