//
//  QYZJConstructionCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJConstructionCell : UITableViewCell
@property(nonatomic,strong)QYZJWorkModel *model;
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *dataArray;
@end

NS_ASSUME_NONNULL_END
