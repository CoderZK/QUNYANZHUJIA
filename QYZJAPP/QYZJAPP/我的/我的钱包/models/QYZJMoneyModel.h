//
//  QYZJMoneyModel.h
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMoneyModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *bank_account;
@property(nonatomic,strong)NSString *logNote;
@property(nonatomic,strong)NSString *moneyType;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *addtime;
@property(nonatomic,strong)NSString *stage_name;
@property(nonatomic,strong)NSString *con;


@property(nonatomic,assign)CGFloat sr_money;
@property(nonatomic,assign)CGFloat pay_money;
@property(nonatomic,assign)CGFloat yq_money;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,assign)CGFloat yj_money;

@property(nonatomic,assign)BOOL isSelect;
//@property(nonatomic,assign)BOOL isRead;

@end

NS_ASSUME_NONNULL_END
