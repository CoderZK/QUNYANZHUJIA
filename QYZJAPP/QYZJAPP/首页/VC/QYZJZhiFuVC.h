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
@property(nonatomic,assign)NSInteger type; // 0旁听 1
@property(nonatomic,strong)NSString *ID;
@end

NS_ASSUME_NONNULL_END
