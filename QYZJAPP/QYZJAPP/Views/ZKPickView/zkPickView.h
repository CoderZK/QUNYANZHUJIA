//
//  zkPickView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ARRAYTYPE) {
    NormalArray,
    titleArray,
    AreaArray,
    ArerArrayNormal
    
};

@protocol zkPickViewDelelgate <NSObject>

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex;

@end

@interface zkPickView : UIView
@property (nonatomic, assign) ARRAYTYPE arrayType;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)UILabel *selectLb;
@property(nonatomic,assign)id<zkPickViewDelelgate>delegate;
- (void)show;
- (void)diss;

@end

NS_ASSUME_NONNULL_END
