//
//  QYZJQuestOrAppointTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJQuestOrAppointTVC : BaseTableViewController
@property(nonatomic,assign)NSInteger type; // 1 预约.2提问 // 1 裁判  2 教练
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,strong)NSString *cityID;
@property(nonatomic,assign)BOOL isMore;
@end

NS_ASSUME_NONNULL_END
