//
//  QYZJCityChooseTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJCityChooseTVC : BaseTableViewController

@property(nonatomic,copy)void(^clickCityBlock)(NSString *cityStr,NSString * cityId);

@end

NS_ASSUME_NONNULL_END
