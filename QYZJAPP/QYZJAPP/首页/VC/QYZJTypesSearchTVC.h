//
//  QYZJTypesSearchTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJTypesSearchTVC : BaseTableViewController
@property(nonatomic,strong)NSString * titleStr;
@property(nonatomic,strong)NSString *role_id;
@property(nonatomic,strong)NSString *cityID;
@property(nonatomic,assign)NSInteger type; // 2教练1裁判 
@end

NS_ASSUME_NONNULL_END
