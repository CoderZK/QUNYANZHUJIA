//
//  QYZJHomeOneCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QYZJHomeOneCellDelegate <NSObject>

- (void)didClickHomeCellIndex:(NSInteger)index;

@end

@interface QYZJHomeOneCell : UITableViewCell

@property(nonatomic,assign)id<QYZJHomeOneCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *lll;


@end

NS_ASSUME_NONNULL_END
