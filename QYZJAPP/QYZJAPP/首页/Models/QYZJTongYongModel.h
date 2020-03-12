//
//  QYZJTongYongModel.h
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJTongYongModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString*ID;
@property(nonatomic,strong)NSString *typeName;
@property(nonatomic,strong)NSString*roleId;

@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *imgPath;
@property(nonatomic,strong)NSString *videoPath;
@property(nonatomic,strong)NSString *osn;

@property(nonatomic,assign)BOOL is_need_wechat_pay;
@property(nonatomic,assign)BOOL is_vip;
@property(nonatomic,assign)BOOL is_pay;
@property(nonatomic,assign)BOOL isSelect;

@property(nonatomic,assign)CGFloat wechat_money;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,assign)CGFloat allMoney;




@property(nonatomic,assign)NSInteger status; // 1   已抢, 2 待支付
@end

NS_ASSUME_NONNULL_END
