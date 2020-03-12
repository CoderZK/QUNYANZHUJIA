//
//  zkRequestTongYongTool.h
//  QYZJAPP
//
//  Created by zk on 2019/11/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zkRequestTongYongTool : NSObject
@property(nonatomic,strong)RACSubject *subject;
//通用的请求
- (void)requestWithUrl:(NSString *)url andDict:(NSMutableDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
