//
//  QYZJUserModel.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJUserModel.h"

@implementation QYZJUserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (self.nick_name) {
        [aCoder encodeObject:self.nick_name forKey:@"nick_name"];
    }
    if (self.ID) {
        [aCoder encodeObject:self.ID forKey:@"ID"];
    }
    if (self.isSame) {
        [aCoder encodeObject:self.isSame forKey:@"isSame"];
    }
    if (self.openid_new) {
        [aCoder encodeObject:self.openid_new forKey:@"openid_new"];
    }
    if (self.token) {
        [aCoder encodeObject:self.token forKey:@"token"];
    }
    if (self.role) {
        [aCoder encodeObject:self.role forKey:@"role"];
    }
    if (self.isSetPayPass) {
        [aCoder encodeObject:self.isSetPayPass forKey:@"isSetPayPass"];
    }
    if (self.openid) {
        [aCoder encodeObject:self.openid forKey:@"openid"];
    }
    if (self.telphone) {
        [aCoder encodeObject:self.telphone forKey:@"telphone"];
    }
}

//解档
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.nick_name = [aDecoder decodeObjectForKey:@"nick_name"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.isSame = [aDecoder decodeObjectForKey:@"isSame"];
        self.openid_new = [aDecoder decodeObjectForKey:@"openid_new"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.role = [aDecoder decodeObjectForKey:@"role"];
        self.isSetPayPass = [aDecoder decodeObjectForKey:@"isSetPayPass"];
        self.openid = [aDecoder decodeObjectForKey:@"openid"];
        self.telphone = [aDecoder decodeObjectForKey:@"telphone"];
    }
    return self;
}


- (void)setGoods_list:(NSMutableArray<QYZJFindModel *> *)goods_list {
    _goods_list =[QYZJFindModel mj_objectArrayWithKeyValuesArray:goods_list];
}
- (void)setCase_list:(NSMutableArray<QYZJFindModel *> *)case_list {
    _case_list = [QYZJFindModel mj_objectArrayWithKeyValuesArray:case_list];
}

@end
