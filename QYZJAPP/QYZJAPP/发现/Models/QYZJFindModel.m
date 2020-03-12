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
    return @{@"ID":@"id",@"des":@"description"};
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

- (void)setHeadlinenews:(QYZJFindModel *)headlinenews {
    _headlinenews = [QYZJFindModel mj_objectWithKeyValues:headlinenews];
}

- (void)setMediaList:(NSMutableArray<QYZJFindModel *> *)mediaList {
    _mediaList = [QYZJFindModel mj_objectArrayWithKeyValuesArray:mediaList];
}


- (void)setAnswer_list:(NSMutableArray<QYZJFindModel *> *)answer_list
{
    _answer_list = [QYZJFindModel mj_objectArrayWithKeyValuesArray:answer_list];
}

- (void)setAnswerList:(NSMutableArray<QYZJFindModel *> *)answerList {
    _answerList = [QYZJFindModel mj_objectArrayWithKeyValuesArray:answerList];
}

- (void)setBroadcastReply:(NSMutableArray<QYZJFindModel *> *)broadcastReply {
    _broadcastReply = [QYZJFindModel mj_objectArrayWithKeyValuesArray:broadcastReply];
}

- (void)setApponitUsers:(NSMutableArray<QYZJFindModel *> *)apponitUsers {
    _apponitUsers = [QYZJFindModel mj_objectArrayWithKeyValuesArray:apponitUsers];
}

/** 看得见的
 
 
 
 
 
 
 
 */


@end
