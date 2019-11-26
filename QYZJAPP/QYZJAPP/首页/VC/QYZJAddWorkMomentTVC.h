//
//  QYZJAddWorkMomentTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJAddWorkMomentTVC : BaseTableViewController
@property(nonatomic,assign)NSInteger type; //0 添加施工阶段 1 修改案例
@property(nonatomic,strong)NSString *titleStr,*contentStr;
@end

NS_ASSUME_NONNULL_END
