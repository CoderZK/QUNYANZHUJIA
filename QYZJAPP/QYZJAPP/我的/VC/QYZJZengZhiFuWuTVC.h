//
//  QYZJZengZhiFuWuTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJZengZhiFuWuTVC : BaseTableViewController
@property(nonatomic,strong)NSString *headImg,*nameStr;
@property(nonatomic,assign)BOOL is_bond;
@property(nonatomic,assign)CGFloat bond_money;

@end

NS_ASSUME_NONNULL_END
