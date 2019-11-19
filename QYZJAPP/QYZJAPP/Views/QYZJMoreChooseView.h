//
//  QYZJMoreChooseView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface QYZJMoreChooseView : UIView
@property(nonatomic,strong)NSMutableArray<QYZJTongYongModel *> *dataArray;
- (void)show;
- (void)diss;
@end

@interface QYZJMoreChooseCell : UITableViewCell
@property(nonatomic,strong)UILabel * leftLB;
@property(nonatomic,strong)UIImageView *rightImgV;
@property(nonatomic,strong)QYZJTongYongModel * model;

@end
