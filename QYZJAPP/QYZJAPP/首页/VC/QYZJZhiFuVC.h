//
//  QYZJZhiFuVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJZhiFuVC : BaseViewController
@property(nonatomic,strong)NSString *osn;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,assign)NSInteger type; // 0旁听 1抢单支付(非VIP)
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,assign)BOOL is_needWeChat;



@end

NS_ASSUME_NONNULL_END
