//
//  QYZJMineShopHeadView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineShopHeadView : UIView
@property(nonatomic,assign)CGFloat  headHeight;
@property(nonatomic,copy)void(^clickShopHeadBlock)(NSInteger index);
@property(nonatomic,strong)QYZJUserModel *dataModel;
@property(nonatomic,strong)UILabel *titelLB;
@property(nonatomic,strong)UIButton *editBt,*shareBt,*headBt;
@end

NS_ASSUME_NONNULL_END
