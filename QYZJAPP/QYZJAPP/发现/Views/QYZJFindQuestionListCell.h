//
//  QYZJFindQuestionListCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYZJFindQuestionListCell;

@protocol QYZJFindQuestionListCellDelegate <NSObject>

- (void)didClickFindQuestListCell:(QYZJFindQuestionListCell *)cell withIndex:(NSInteger)index;

@end



@interface QYZJFindQuestionListCell : UITableViewCell
@property(nonatomic,strong)QYZJFindModel *model;
@property(nonatomic,assign)id<QYZJFindQuestionListCellDelegate>delegate;

@property(nonatomic,strong)UIButton *listBt;
@end


