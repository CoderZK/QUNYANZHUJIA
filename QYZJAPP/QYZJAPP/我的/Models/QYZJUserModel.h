//
//  QYZJUserModel.h
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QYZJFindModel.h"
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
@property(nonatomic,strong)NSString *pro_name;
@property(nonatomic,strong)NSString *area_id;
@property(nonatomic,strong)NSString *city_name;
@property(nonatomic,strong)NSString *pro_id;
@property(nonatomic,strong)NSString *city_id;
@property(nonatomic,strong)NSString *area_name;
@property(nonatomic,strong)NSString *head_img;
@property(nonatomic,strong)NSString *role_name;
@property(nonatomic,strong)NSString *is_bond;
@property(nonatomic,strong)NSString *label;
@property(nonatomic,strong)NSString *invitation_code;
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *address;

@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *goods_list;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *case_list;

@property(nonatomic,assign)BOOL is_vip;
@property(nonatomic,assign)BOOL is_coach;
@property(nonatomic,assign)BOOL isNews;


@property(nonatomic,assign)NSInteger follow_num;
@property(nonatomic,assign)NSInteger fans_num;
@property(nonatomic,assign)NSInteger goods_num;
@property(nonatomic,assign)NSInteger question_num;
@property(nonatomic,assign)NSInteger answer_num;
@property(nonatomic,assign)NSInteger appoint_num;

@property(nonatomic,assign)float bond_money;
@property(nonatomic,assign)float score;

@end

NS_ASSUME_NONNULL_END
