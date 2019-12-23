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
@property(nonatomic,assign)NSInteger type; // 0 预约.1提问
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,assign)CGFloat money;
@end

NS_ASSUME_NONNULL_END
