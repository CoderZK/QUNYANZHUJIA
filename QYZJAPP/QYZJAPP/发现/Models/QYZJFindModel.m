//
//  QYZJFindModel.m
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindModel.h"

@implementation QYZJFindModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}
- (void)setCommentList:(NSMutableArray<QYZJFindModel *> *)commentList {
    _commentList =[QYZJFindModel mj_objectArrayWithKeyValuesArray:commentList];
}

- (void)setGoodsList:(NSMutableArray<QYZJFindModel *> *)goodsList {
    _goodsList = [QYZJFindModel mj_objectArrayWithKeyValuesArray:goodsList];
}
- (void)setGoodList:(NSMutableArray<QYZJFindModel *> *)goodList {
    _goodList = [QYZJFindModel mj_objectArrayWithKeyValuesArray:goodList];
}

- (void)setArticle:(QYZJFindModel *)article {
    _article = [QYZJFindModel mj_objectWithKeyValues:article];
}

/** 看得见的
 
 
 
 
 
 
 
 */


@end
