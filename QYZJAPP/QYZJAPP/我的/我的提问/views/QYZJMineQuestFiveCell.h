//
//  QYZJMineQuestFiveCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJMineQuestFiveCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *nameLB,*typeLB,*contentLB;
@property(nonatomic,strong)UIButton *listBt,*replyBt;
@property(nonatomic,strong)QYZJFindModel *model;
@end

NS_ASSUME_NONNULL_END
