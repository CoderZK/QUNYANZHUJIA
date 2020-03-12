//
//  QYZJWorkModel.m
//  QYZJAPP
//
//  Created by zk on 2019/11/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJWorkModel.h"

@implementation QYZJWorkModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id",@"des":@"description"};
}

- (void)setChangeTurnoverLists:(NSMutableArray<QYZJWorkModel *> *)changeTurnoverLists {
    _changeTurnoverLists = [QYZJWorkModel mj_objectArrayWithKeyValuesArray:changeTurnoverLists];
}
- (void)setMedia_url:(NSMutableArray<QYZJWorkModel *> *)media_url {
    _media_url = [QYZJWorkModel mj_objectArrayWithKeyValuesArray:media_url];
}
- (void)setChangeConstructionStage:(NSMutableArray<QYZJWorkModel *> *)changeConstructionStage {
    _changeConstructionStage = [QYZJWorkModel mj_objectArrayWithKeyValuesArray:changeConstructionStage];
}

- (void)setConstructionStage:(NSMutableArray<QYZJWorkModel *> *)constructionStage {
    _constructionStage = [QYZJWorkModel mj_objectArrayWithKeyValuesArray:constructionStage];
}

- (void)setTurnoverLists:(NSMutableArray<QYZJWorkModel *> *)turnoverLists {
    _turnoverLists = [QYZJWorkModel mj_objectArrayWithKeyValuesArray:turnoverLists];
}

- (void)setTurnover:(QYZJWorkModel *)turnover {
    _turnover = [QYZJWorkModel mj_objectWithKeyValues:turnover];
}
- (void)setSelfStage:(NSMutableArray<QYZJWorkModel *> *)selfStage {
    _selfStage = [QYZJWorkModel mj_objectArrayWithKeyValuesArray:selfStage];
}
- (void)setTurnoverListOrderFirst:(QYZJWorkModel *)turnoverListOrderFirst {
    _turnoverListOrderFirst = [QYZJWorkModel mj_objectWithKeyValues:turnoverListOrderFirst];
}
- (void)setDemandUser:(QYZJWorkModel *)demandUser {
    _demandUser = [QYZJWorkModel mj_objectWithKeyValues:demandUser];
}
- (void)setTurnoverListOrderFinal:(QYZJWorkModel *)turnoverListOrderFinal {
    _turnoverListOrderFinal = [QYZJWorkModel mj_objectWithKeyValues:turnoverListOrderFinal];
}
- (void)setTurnoverList:(QYZJWorkModel *)turnoverList {
    _turnoverList = [QYZJWorkModel mj_objectWithKeyValues:turnoverList];
}
- (void)setDemand:(QYZJWorkModel *)demand {
    _demand = [QYZJWorkModel mj_objectWithKeyValues:demand];
}

- (void)setOther:(NSMutableArray<QYZJWorkModel *> *)other {
    _other = [QYZJWorkModel mj_objectArrayWithKeyValuesArray:other];
}

- (void)setRepairSelf:(NSMutableArray<QYZJWorkModel *> *)repairSelf {
    _repairSelf = [QYZJWorkModel mj_objectArrayWithKeyValuesArray:repairSelf];
}

@end
