//
//  QYZJHomeTwoTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJHomeTwoTVC : BaseTableViewController
@property(nonatomic,assign)NSInteger type; // 2教练 // 1 裁判
@property(nonatomic,strong)NSString *cityID;
@end

NS_ASSUME_NONNULL_END
