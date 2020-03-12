//
//  QYZJChangeConstructionOneCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYZJChangeConstructionOneCell;

@protocol QYZJChangeConstructionOneCellDelegate <NSObject>

- (void)didClickQYZJChangeConstructionOneCell:(QYZJChangeConstructionOneCell*)cell withIndex:(NSInteger)index;

@end



@interface QYZJChangeConstructionOneCell : UITableViewCell

@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *dataArray;
@property(nonatomic,assign)BOOL is_service; // 0 服务方 1 客户
@property(nonatomic,assign)id<QYZJChangeConstructionOneCellDelegate>delegate;
@end


