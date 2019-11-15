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
#import "QYZJHomeThreeCell.h"
#import "QYZJHomeFourCell.h"
#import "QYZJHomeFiveCell.h"
#import "QYZJHomeTwoTVC.h"
#import "QYZJHomePayTVC.h"
#import "QYZJRobOrderTVC.h"
@interface QYZJHomeVC ()<zkLunBoCellDelegate,QYZJHomeOneCellDelegate,QYZJHomeTwoCellDelegate>
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
    self.navigationController.navigationBar.hidden = YES;
    //    self.navigationController.navigationBar.hidden = YES;;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //    QYZJLocationTool * tool = [[QYZJLocationTool alloc] init];
    //    [tool locationAction];
    
    [self.tableView registerClass:[zkLunBoCell class] forCellReuseIdentifier:@"zkLunBoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, sstatusHeight + 44, ScreenW, ScreenH - sstatusHeight - 44);
    [self addNav];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeTwoCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeThreeCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeThreeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFourCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFourCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFiveCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFiveCell"];
    
    
    [self getBanList];
}



- (void)addNav {
    
    self.navigaV = [[HomeNavigationView alloc] initWithFrame:CGRectMake(0, sstatusHeight, ScreenW, 44)];
    [self.view addSubview:self.navigaV];
    self.navigaV.delegateSignal = [RACSubject subject];
    [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {
        
        NSDictionary * dict = x;
        if ([[NSString stringWithFormat:@"%@",dict[@"key"]] isEqualToString:@"city"]) {
            //点击的是城市
            QYZJCityChooseTVC * vc =[[QYZJCityChooseTVC alloc] init];
            __weak QYZJHomeVC * weakSelf = self;
            vc.clickCityBlock = ^(NSString * _Nonnull cityStr, NSString * _Nonnull cityId) {
                
                weakSelf.navigaV.titleStr = cityStr;
                
            };
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            //点击的是搜索
        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 5;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 40;
    }
    return 0.01;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headVview"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        view.clipsToBounds = YES;
        view.backgroundColor = WhiteColor;
        UILabel * leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
        leftLB.font = kFont(15);
        leftLB.text = @"推荐答人";
        [view addSubview:leftLB];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 15 - 80, 10, 80, 30)];
        [button setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        button.titleLabel.font = kFont(14);
        button.tag = 100;
        [button setTitle:@"更多   >" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [view addSubview:button];
    }
    
    UIButton * bt = (UIButton*)[view viewWithTag:100];
    [bt addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return ScreenW / 2+30;
    }else if (indexPath.section == 1) {
        return 100;
    }else if (indexPath.section == 2) {
        return 200;
    }
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        zkLunBoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkLunBoCell" forIndexPath:indexPath];
        NSMutableArray * arr = @[].mutableCopy;
        for (zkBannerModel * model  in self.bannerDataArr) {
            [arr addObject:model.pic];
        }
        cell.dataArr = arr;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1) {
        if (0) {
            QYZJHomeOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeOneCell" forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        }
        QYZJHomeTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeTwoCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 2) {
        QYZJHomeThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeThreeCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 3 && indexPath.row == 0) {
        QYZJHomeFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFourCell" forIndexPath:indexPath];
        return cell;
    }else {
        QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
        return cell;
    }
    QYZJHomeTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeTwoCell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaseNavigationController * navc = [[BaseNavigationController alloc] initWithRootViewController:[[QYZhuJiaLoginVC alloc] init]];
    [self presentViewController:navc animated:YES completion:nil];
}


#pragma mark ------ 点击轮播图的事件 -------
- (void)didSelectLunBoPic:(NSInteger )index {
    
    NSLog(@"%d",index);
    
    zkBannerModel  * model = self.bannerDataArr[index];
    LxmWebViewController *vc = [[LxmWebViewController alloc] init];
    [vc loadHtmlStr:model.path withBaseUrl:nil];
    vc.navigationItem.title = model.title;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


#pragma mark ----  点击更多 -------
- (void)moreAction:(UIButton *)button {
    
}


#pragma mark ---- 点击首页的教练,裁判等 -----
- (void)didClickHomeCellIndex:(NSInteger)index {
    [self pushHomeTwoVCWithIndex:index];
}

- (void)didClickHomeTwoCellIndex:(NSInteger)index {
    [self pushHomeTwoVCWithIndex:index];
}

- (void)pushHomeTwoVCWithIndex:(NSInteger)index {
    if (index<2) {
        QYZJHomeTwoTVC * vc =[[QYZJHomeTwoTVC alloc] init];
        vc.type = index;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 2){
        
        QYZJHomePayTVC * vc =[[QYZJHomePayTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        QYZJRobOrderTVC * vc =[[QYZJRobOrderTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)getBanList {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"city_id"] = @"1004";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_bannerListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.bannerDataArr = [zkBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"bannerList"]];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


@end
