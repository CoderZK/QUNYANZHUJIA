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
#import "QYZJYuYueFangDanTVC.h"
#import "QYZJXiaoYanZiVC.h"
#import "QYZJSearchListTVC.h"
#import "TabBarController.h"
#import "QYZJRecommendVC.h"
#import "QYZJMineOrderTVC.h"
#import "QYZJQuestOrAppointTVC.h"
@interface QYZJHomeVC ()<zkLunBoCellDelegate,QYZJHomeOneCellDelegate,QYZJHomeTwoCellDelegate,UITabBarControllerDelegate>
@property(nonatomic,strong)NSString *passwordStr;
@property(nonatomic,strong)NSMutableArray<zkBannerModel *> *bannerDataArr;
@property(nonatomic,strong)HomeNavigationView *navigaV;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,strong)NSString *cityID;
@property(nonatomic,strong)NSString *searchWord;
@property(nonatomic,strong)QYZJLocationTool *tool;

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
    if ([zkSignleTool shareTool].isLogin) {
       [self getUserBaseicInfoHome];
    }
    [self getBanList];
    
    [self getConfig];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}





- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tabBarController.delegate = self;
    
    self.tool = [[QYZJLocationTool alloc] init];
    [self.tool locationAction];
    Weak(weakSelf);
    self.tool.locationBlock = ^(NSString * _Nonnull cityStr, NSString * _Nonnull cityID) {
        weakSelf.navigaV.titleStr = cityStr;
        weakSelf.cityID = cityID;
        weakSelf.page = 1;
        [weakSelf getData];
        [zkSignleTool shareTool].cityId = cityID;
    };
    
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
    
    [self seysTemparam];

    
}


- (void)addNav {
    
    self.navigaV = [[HomeNavigationView alloc] initWithFrame:CGRectMake(0, sstatusHeight, ScreenW, 44)];
    [self.view addSubview:self.navigaV];
    self.navigaV.delegateSignal = [RACSubject subject];
    [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {
        
         if (![zkSignleTool shareTool].isLogin) {
               [self gotoLoginVC];
               return;
           }
        
        NSDictionary * dict = x;
        if ([[NSString stringWithFormat:@"%@",dict[@"key"]] isEqualToString:@"city"]) {
            //点击的是城市
            QYZJCityChooseTVC * vc =[[QYZJCityChooseTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            __weak QYZJHomeVC * weakSelf = self;
            vc.clickCityBlock = ^(NSString * _Nonnull cityStr, NSString * _Nonnull cityId) {
                
                weakSelf.navigaV.titleStr = cityStr;
                weakSelf.cityID = cityId;
                weakSelf.page = 1;
                [zkSignleTool shareTool].cityId = cityId;
                [weakSelf getData];
            };
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            //点击的是搜索
            QYZJSearchListTVC * vc =[[QYZJSearchListTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.type = 0;
            vc.cityID = self.cityID;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}

- (void)getConfig {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_iosURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"key"] intValue]== 1) {
            
            //1为展示购物
            if ([[NSString stringWithFormat:@"%@",responseObject[@"result"][@"value"]] isEqualToString:@"1"]) {
                [zkSignleTool shareTool].isUp = YES;

            }else {
                
                TabBarController * tvc = (TabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                NSMutableArray * arr = tvc.viewControllers.mutableCopy;
                
                if ( arr.count == 3) {
                    
                    QYZJRecommendVC * rvc = [[QYZJRecommendVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    
                    NSString *str1= @"ico_tuijian";
                    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
                    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
                    attrs[NSForegroundColorAttributeName] = CharacterColor80;
                    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
                    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
                    selectedAttrs[NSForegroundColorAttributeName] = TabberGreen;
                    UITabBarItem *item = [UITabBarItem appearance];
                    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
                    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
                      //让图片保持原来的模样，未选中的图片
                    rvc.tabBarItem.image=[[UIImage imageNamed:str1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                          
                          //图片选中时的图片
                    NSString *str2=@"ico_tuijian_2";
                    rvc.tabBarItem.selectedImage=[[UIImage imageNamed:str2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    
                    NSString *str3=@"推荐赚钱";
                    rvc.tabBarItem.title=str3;
                    
                    BaseNavigationController * navc = [[BaseNavigationController alloc] initWithRootViewController:rvc];
                    
                    [arr insertObject:navc atIndex:2];
                    tvc.viewControllers = arr;
                    
                    
                }
                
                [zkSignleTool shareTool].isUp = NO;
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return self.dataArray.count + 1;
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
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
        [button setTitle:@" >" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [view addSubview:button];
        
        
        
    }
    
    UIButton * bt = (UIButton*)[view viewWithTag:100];
    [bt addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        return ScreenW / 2+30;
        return ScreenW * 8 * 165 / 9 / 385 + 30;
    }else if (indexPath.section == 1) {
        return 100;
    }else if (indexPath.section == 2) {
        return (ScreenW - 30)  / 3;
    }
    return 100;
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
        if ([zkSignleTool shareTool].role == 0) {
            QYZJHomeOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeOneCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            QYZJHomeTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeTwoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
       
    }else if (indexPath.section == 2) {
        QYZJHomeThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeThreeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgV.image = [UIImage imageNamed:@"bookOrder"];
        return cell;
    }else if (indexPath.section == 3 && indexPath.row == 0) {
        QYZJHomeFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFourCell" forIndexPath:indexPath];
        return cell;
    }else {
        QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row - 1];
        cell.headBt.tag = indexPath.row - 1;
        [cell.headBt addTarget:self action:@selector(gotoZhuYeAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
 
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     if (![zkSignleTool shareTool].isLogin) {
           [self gotoLoginVC];
           return;
       }
    
    if (indexPath.section == 2) {
        
        if([zkSignleTool shareTool].role == 1) {
            [SVProgressHUD showErrorWithStatus:@"您已经是服务方,不能预约订单"];
            return ;
        }
        
        if (isUPUPUP) {
         if([zkSignleTool shareTool].role == 1) {
               [SVProgressHUD showErrorWithStatus:@"您已经是服务方,不能提问和预约"];
               return ;
           }
           
           QYZJQuestOrAppointTVC * vc =[[QYZJQuestOrAppointTVC alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           vc.type = 1;
           vc.cityID = self.cityID;
           vc.isMore = YES;
           [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        
        QYZJYuYueFangDanTVC * vc =[[QYZJYuYueFangDanTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            QYZJXiaoYanZiVC * vc =[[QYZJXiaoYanZiVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            QYZJMineZhuYeTVC * vc =[[QYZJMineZhuYeTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = self.dataArray[indexPath.row-1].ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
//    else {
//        BaseNavigationController * navc = [[BaseNavigationController alloc] initWithRootViewController:[[QYZhuJiaLoginVC alloc] init]];
//        [self presentViewController:navc animated:YES completion:nil];
//    }
    
 
}
#pragma mark ------- 取他人的主页 ------
- (void)gotoZhuYeAction:(UIButton *)button {
    
    if (![zkSignleTool shareTool].isLogin) {
           [self gotoLoginVC];
           return;
       }
    
    QYZJMineZhuYeTVC * vc =[[QYZJMineZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataArray[button.tag].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ------ 点击轮播图的事件 -------
- (void)didSelectLunBoPic:(NSInteger )index {
    
    NSLog(@"%d",index);
    
    if(isUPUPUP){
        return;
    }
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
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [self pushHomeTwoVCWithIndex:index];
}

- (void)didClickHomeTwoCellIndex:(NSInteger)index {
    
    if (![zkSignleTool shareTool].isLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [self pushHomeTwoVCWithIndex:index];
}

- (void)pushHomeTwoVCWithIndex:(NSInteger)index {
    if (index<2) {
        QYZJHomeTwoTVC * vc =[[QYZJHomeTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.type = 2-index;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 2){
        if (isUPUPUP) {
            
            QYZJMineOrderTVC * vc =[[QYZJMineOrderTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            return;
            
        }
        
        QYZJHomePayTVC * vc =[[QYZJHomePayTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        QYZJRobOrderTVC * vc =[[QYZJRobOrderTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"type"] = @"0";
    dict[@"city_id"] = [zkSignleTool shareTool].cityId;
    dict[@"search_word"] = self.searchWord;
    dict[@"search_type"] = @"0";
    dict[@"roleId"] = @"0";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_searchURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<QYZJFindModel *>*arr = [QYZJFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
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


- (void)getBanList {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"city_id"] =[zkSignleTool shareTool].cityId;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_bannerListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.bannerDataArr = [zkBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"bannerList"]];
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 7){
            [SVProgressHUD showSuccessWithStatus:@"用户未登录"];
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}



- (void)getUserBaseicInfoHome {
    zkRequestTongYongTool * tool = [[zkRequestTongYongTool alloc] init];
    [tool requestWithUrl:[QYZJURLDefineTool user_basicInfoURL] andDict:@{}];
    tool.subject = [[RACSubject alloc] init];
    @weakify(self);
    [tool.subject subscribeNext:^(id  _Nullable x) {
           @strongify(self);
           if (x !=nil && [x[@"key"] intValue] == 1) {
               [zkSignleTool shareTool].role = [[NSString stringWithFormat:@"%@",x[@"result"][@"role"]] intValue];
               [self.tableView reloadData];
           }else {
               [SVProgressHUD dismiss];
           }
    }];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (![zkSignleTool shareTool].isLogin) {
        
        [self gotoLoginVC];
        return NO;
        
        
    }
    return YES;
}


@end
