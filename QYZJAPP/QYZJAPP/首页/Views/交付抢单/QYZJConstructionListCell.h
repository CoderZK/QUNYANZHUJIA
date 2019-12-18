//
//  QYZJConstructionListCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYZJConstructionListCell;
@protocol QYZJConstructionListCellDelegate <NSObject>

-(void)didclickQYZJConstructionListCell:(QYZJConstructionListCell *)cell withIndex:(NSInteger)index isNeiClick:(BOOL )isNei NeiRow:(NSInteger )row isClickNeiCell:(BOOL)isClickNeiCell;

@end

@interface QYZJConstructionListCell : UITableViewCell
@property(nonatomic,strong)QYZJWorkModel *model;
@property(nonatomic,assign)BOOL is_service; // 0 是服务方, 1 不是
@property(nonatomic,assign)NSInteger type; //0 清单 1 保修
@property(nonatomic,assign)id<QYZJConstructionListCellDelegate>delegate;
@end


@interface QYZJConstructionListNeiCell : UITableViewCell
@property(nonatomic,strong)QYZJWorkModel *model;
@property(nonatomic,assign)BOOL is_service;
@property(nonatomic,copy)void(^clcikNeiCellBlock)(QYZJConstructionListNeiCell *cellNei ,NSInteger index,BOOL isClickCell);
@property(nonatomic,assign)NSInteger type; // 0 清单 1 保修
@end



