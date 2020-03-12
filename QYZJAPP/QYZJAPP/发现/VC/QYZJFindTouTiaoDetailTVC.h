//
//  QYZJFindTouTiaoDetailTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/14.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJFindTouTiaoDetailTVC : BaseTableViewController
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,copy)void(^sendTouTiaoModelBlock)(QYZJFindModel *model);
@end

NS_ASSUME_NONNULL_END
