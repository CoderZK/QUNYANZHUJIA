//
//  QYZJMineShopCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QYZJMineShopCell;
@protocol QYZJMineShopCellDelegate <NSObject>

- (void)didClickQYZJMineShopCell:(QYZJMineShopCell*)cell index:(NSInteger)index isEdit:(BOOL)isEdit;

@end

@interface QYZJMineShopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *leftMoneyLB;
@property (weak, nonatomic) IBOutlet UILabel *rightMoneyLB;
@property (weak, nonatomic) IBOutlet UIButton *leftEditBt;
@property (weak, nonatomic) IBOutlet UIButton *rightEdibtBt;
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property(nonatomic,strong)NSArray<QYZJFindModel *> *dataArray;
@property(nonatomic,assign)id<QYZJMineShopCellDelegate>delegate;
@property(nonatomic,assign)NSInteger isShenHe;
@end

NS_ASSUME_NONNULL_END
