//
//  QYZJAddMineLabelsVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJAddMineLabelsVC : BaseViewController
@property(nonatomic,copy)void(^sendLabelsBlock)(NSString *labelsID,NSString * labelsStr);
@property(nonatomic,strong)NSMutableArray<QYZJTongYongModel *> *leiXingArr;
@end

NS_ASSUME_NONNULL_END
