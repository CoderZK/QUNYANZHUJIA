//
//  QYZJCoachCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface QYZJCoachCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray<QYZJTongYongModel *> *dataArr;
@property(nonatomic,assign)BOOL isSpread,isMore;//是否是展开
@property(nonatomic,copy)void(^sendStatusBlock)(BOOL isMore,BOOL isSpread,BOOL isReload,NSInteger index);
@end


@interface CoachView : UIView
@property(nonatomic,strong)UIButton *clickBt;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLB;
@end
