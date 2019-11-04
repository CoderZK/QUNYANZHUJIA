//
//  QYZJHomeVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomeVC.h"
#import "QYZJNoDataView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "zkBannerModel.h"
#import "zkLunBoCell.h"
#import "HomeNavigationView.h"
#import "QYZJHomeOneCell.h"
#import "QYZJHomeTwoCell.h"
@interface QYZJHomeVC ()<zkLunBoCellDelegate>
@property(nonatomic,strong)NSString *passwordStr;
@property(nonatomic,strong)NSMutableArray<zkBannerModel *> *bannerDataArr;
@property(nonatomic,strong)HomeNavigationView *navigaV;
@end

@implementation QYZJHomeVC

- (NSMutableArray<zkBannerModel *> *)bannerDataArr {
    if (_bannerDataArr == nil) {
        _bannerDataArr = [NSMutableArray array];
    }
    return _bannerDataArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[zkLunBoCell class] forCellReuseIdentifier:@"zkLunBoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, sstatusHeight + 44, ScreenW, ScreenH - sstatusHeight - 44);
    [self addNav];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeTwoCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeTwoCell"];

}

- (void)addNav {
    
    self.navigaV = [[HomeNavigationView alloc] initWithFrame:CGRectMake(0, sstatusHeight, ScreenW, 44)];
    [self.view addSubview:self.navigaV];
    self.navigaV.delegateSignal = [RACSubject subject];
    [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {
       
        NSDictionary * dict = x;
        if ([[NSString stringWithFormat:@"%@",dict[@"key"]] isEqualToString:@"city"]) {
            //点击的是城市
        }else {
            //点击的是搜索
            
            
        }
        
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return ScreenW / 2+30;
    }else if (indexPath.section == 1) {
        return 100;
    }
    return 100;;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        zkLunBoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkLunBoCell" forIndexPath:indexPath];
        cell.dataArr = @[@"http://pic1.win4000.com/wallpaper/b/575fd4f22de59.jpg",@"http://www.leawo.cn/attachment/201409/1/1723875_1409556793I3Eg.jpg",@"http://b-ssl.duitang.com/uploads/item/201604/23/20160423165323_k4rhF.jpeg"];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1) {
        
        QYZJHomeOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeOneCell" forIndexPath:indexPath];
         return cell;
    }
    QYZJHomeTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeTwoCell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma makr ------ 点击轮播图的事件 -------
- (void)didSelectLunBoPic:(NSInteger )index {
    
    NSLog(@"%d",index);
    
    
}

@end
