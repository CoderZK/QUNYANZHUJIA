//
//  QYZJFindGuangChangDetailTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJFindGuangChangDetailTVC : BaseTableViewController
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,copy)void(^sendGuanChangModelBlock)(QYZJFindModel *model);
@end

NS_ASSUME_NONNULL_END
