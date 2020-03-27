//
//  QYZJMineZhiBoTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineZhiBoTVC.h"
#import "QYZJZhiBoCell.h"
#import <AVKit/AVKit.h>
@interface QYZJMineZhiBoTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArray;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)AVPlayerViewController *playVC;
@property(nonatomic,strong)AVPlayer * avPlayer;
@end

@implementation QYZJMineZhiBoTVC

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    self.avPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:@""]];
    [self.avPlayer pause];
    [self.avPlayer seekToTime:(CMTimeMake(0, 1))];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"装修直播";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJZhiBoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    
    [self setHeadV];;
    
}

- (void)setHeadV {
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    self.headV.clipsToBounds = YES;
    
    NSString *webVideoPath = @"http://hls01open.ys7.com/openlive/7f37456a1fd547d496e78ab734cb39e5.m3u8";
    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
    //步骤2：创建AVPlayer
    AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
    self.avPlayer = avPlayer;
    self.playVC = [[AVPlayerViewController alloc] init];
    [self addChildViewController:self.playVC];
    [self.headV addSubview:self.playVC.view];
    self.playVC.view.frame = CGRectMake(0, 0, ScreenW, 0);
    self.playVC.player = avPlayer;
    self.tableView.tableHeaderView = self.headV;
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_ysListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<QYZJMoneyModel *>*arr = [QYZJMoneyModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count/2 + self.dataArray.count % 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat ww = (ScreenW- 30) /2.0;
    return  ww*9/16 + 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJZhiBoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ((indexPath.row + 1) * 2 > self.dataArray.count) {
        
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2, 1)].mutableCopy;
        
    }else {
        cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 2, 2)].mutableCopy;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftBt.tag = 0;
    cell.rightBt.tag = 1;
    [cell.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)clickAction:(UIButton *)button {
    
    
    
    
    
    QYZJZhiBoCell * cell = (QYZJZhiBoCell *)button.superview.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QYZJMoneyModel * model = self.dataArray[indexPath.row * 2 + button.tag];
    
    for (int i = 0;i<self.dataArray.count;i++) {
        if (i == indexPath.row * 2 + button.tag) {
            self.dataArray[i].isPlaying = YES;
        }else {
             self.dataArray[i].isPlaying = NO;
        }
    }
    [self.tableView reloadData];
    
    NSString *webVideoPath = model.ysUrl;
    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
    //步骤2：创建AVPlayer
    self.avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
    self.playVC.player = self.avPlayer;
    self.headV.mj_h = ScreenW * 9/16;
    self.playVC.view.frame = CGRectMake(0, 0, ScreenW, ScreenW * 9/16);
    [self.headV addSubview:self.playVC.view];
    
    
}


- (void)dealloc{
    NSLog(@"%@",@"-----");

}

@end
