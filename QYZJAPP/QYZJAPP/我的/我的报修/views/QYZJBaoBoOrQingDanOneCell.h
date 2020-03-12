//
//  QYZJBaoBoOrQingDanOneCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJBaoBoOrQingDanOneCell : UITableViewCell
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,assign)BOOL is_service; // 0 是服务方, 1 不是
@property(nonatomic,assign)NSInteger type; // 1 清单事 0 保修
@end

NS_ASSUME_NONNULL_END
