//
//  zkLunBoCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkLunBoCell.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "zkLunBoTwoCell.h"
@interface zkLunBoCell()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;


@end


@implementation zkLunBoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addPagerView];
        [self addPageControl];
        
    }
    return self;
}


- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW * 8 * 165 / 9 / 385)];
    pagerView.layout.layoutType = 1;

//    pagerView.layout.itemSpacing = 30;
//    pagerView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    pagerView.backgroundColor = [UIColor whiteColor];
//    pagerView.layer.borderWidth = 1;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    [pagerView registerClass:[zkLunBoTwoCell class] forCellWithReuseIdentifier:@"cellId"];
    [self addSubview:pagerView];
    _pagerView = pagerView;

}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_pagerView.frame) , CGRectGetWidth(_pagerView.frame), 20)];
    pageControl.numberOfPages = self.dataArr.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(10, 10);
    pageControl.pageIndicatorSize = CGSizeMake(10, 10);
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255/255.0 green:128/225.0 blue:60/255.0 alpha:1.0];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
    //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}



- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    _pageControl.numberOfPages = dataArr.count;
    [_pagerView reloadData];
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _dataArr.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    zkLunBoTwoCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
   
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:_dataArr[index]]] placeholderImage:[UIImage imageNamed:@"789"]];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*0.8, CGRectGetHeight(pageView.frame)*0.9);
    layout.itemSpacing = 15;
    layout.layoutType = 1;
    layout.minimumScale = 0.9;
//    layout.minimumAlpha = 0.3;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
   
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectLunBoPic:)]) {
        [self.delegate didSelectLunBoPic:index];
    }
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
