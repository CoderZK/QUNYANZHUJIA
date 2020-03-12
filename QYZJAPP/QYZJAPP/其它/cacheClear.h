//
//  cacheClear.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^cleanCacheBlock)();
@interface cacheClear : NSObject
+(void)cleanCache:(cleanCacheBlock)block;
+(float)folderSizeAtPath;
@end

NS_ASSUME_NONNULL_END
