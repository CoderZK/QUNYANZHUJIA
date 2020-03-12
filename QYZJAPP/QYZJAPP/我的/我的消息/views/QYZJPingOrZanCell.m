//
//  QYZJPingOrZanCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJPingOrZanCell.h"

@implementation QYZJPingOrZanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgVOne.layer.cornerRadius = 25;
    self.imgVOne.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    
    [self.imgVOne sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.headerPic]] placeholderImage:[UIImage imageNamed:@"789"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.nickName;
    self.contentLB.text = model.commentContent;
    self.rightLB.text = model.articleContent;
    self.timeLB.text = model.time;
    
}


@end
