//
//  QYZJMineYuHuiQuanTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineYuHuiQuanTVC : BaseTableViewController
@property(nonatomic,copy)void(^youHuiQuanBlock)(NSString * ID);
@property(nonatomic,assign)NSInteger isChoose; // 0 展示全部 1 展示预约 2 展示提问
@end

NS_ASSUME_NONNULL_END
