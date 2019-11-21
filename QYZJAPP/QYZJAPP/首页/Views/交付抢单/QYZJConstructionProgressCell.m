//
//  QYZJConstructionProgressCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJConstructionProgressCell.h"

@interface QYZJConstructionProgressCell()
@property(nonatomic,strong)UIScrollView *scrollview;
@end

@implementation QYZJConstructionProgressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, ScreenW, 65)];
        self.scrollview.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollview];
 
        
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray<QYZJWorkModel *> *)dataArray {
    _dataArray = dataArray;
    
    CGFloat leftSpace = 40;
    CGFloat ww = 100;
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (dataArray.count == 0){
        return;
    }
    
    for (int i = 0 ; i < dataArray.count; i++) {
        QYZJWorkModel * model = dataArray[i];
        QYZJWorkModel * modelTwo = nil;
        if (i+1<dataArray.count) {
            modelTwo = dataArray[i+1];
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(leftSpace + (ww) * i, 0, 30, 30)];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(button.frame), CGRectGetMidY(button.frame)-1, ww, 2)];
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(button.frame) - 35 , CGRectGetMaxY(button.frame) + 5 , ww, 20)];
        lb.font = kFont(14);
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = model.stageName;
        if (i+1 == dataArray.count ) {
            view.hidden = YES;
        }
        if([model.status intValue]== 4|| [model.status intValue] == 6) {
            [button setImage:[UIImage imageNamed:@"32"] forState:UIControlStateNormal];
        
        }else {
           [button setImage:[UIImage imageNamed:@"33"] forState:UIControlStateNormal];
        }
        if (modelTwo != nil && ([modelTwo.status intValue] == 4 || [modelTwo.status intValue] == 6)) {
            view.backgroundColor = OrangeColor;
        }else {
            view.backgroundColor = CharacterColor180;
        }
        [self.scrollview addSubview:view];
        [self.scrollview addSubview:button];
        [self.scrollview addSubview:lb];
        
        
    }
    
    self.scrollview.contentSize = CGSizeMake(80+ (dataArray.count - 1) * 100 + 15, 65);
 
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
