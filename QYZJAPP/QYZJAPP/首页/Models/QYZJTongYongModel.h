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
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *imgPath;
@property(nonatomic,strong)NSString *videoPath;
@end

NS_ASSUME_NONNULL_END
