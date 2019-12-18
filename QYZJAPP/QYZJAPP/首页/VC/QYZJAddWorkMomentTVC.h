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
@property(nonatomic,assign)NSInteger type; //0 添加施工阶段 1 修改案例  2 创建保修播报 3 创建案例  4修改阶段  5 创建清单播报 6//创建保修 7 立即整改
@property(nonatomic,strong)NSString *titleStr,*contentStr;
@property(nonatomic,strong)NSString *ID,*IDTwo;
@property(nonatomic,assign)NSInteger changeType; // 1 正常阶段,2 变更阶段
@property(nonatomic,assign)CGFloat price;
@property(nonatomic,strong)NSString *videoUrl;
@property(nonatomic,strong)NSMutableArray *picsArrTwo;
@end

NS_ASSUME_NONNULL_END
