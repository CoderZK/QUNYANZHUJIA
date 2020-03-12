//
//  QYZJTuiBaoVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJTuiBaoVC : BaseViewController
@property(nonatomic,assign)CGFloat bond_money;
@property(nonatomic,copy)void(^tuiBaoBlock)(BOOL is_bood);
@end

NS_ASSUME_NONNULL_END
