//
//  QYZJSearchListTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJSearchListTVC : BaseTableViewController
@property(nonatomic,strong)NSString *cityID;
@property(nonatomic,assign)NSInteger type; //0 首页, 1 教练 2 裁判
@property(nonatomic,assign)BOOL isCaiPanNei;
@end

NS_ASSUME_NONNULL_END
