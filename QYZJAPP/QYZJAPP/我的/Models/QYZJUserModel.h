//
//  QYZJUserModel.h
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJUserModel : NSObject<NSCoding>
@property(nonatomic,strong)NSString *nick_name;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *isSame;
@property(nonatomic,strong)NSString *openid_new;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *role;
@property(nonatomic,strong)NSString *isSetPayPass;
@property(nonatomic,strong)NSString *openid;
@property(nonatomic,strong)NSString *telphone;

@end

NS_ASSUME_NONNULL_END
