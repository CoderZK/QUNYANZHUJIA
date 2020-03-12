//
//  QYZJMessageTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMessageTVC.h"
#import "QYZJMessageCell.h"
#import "QYZJPingOrZanListTVC.h"
#import "QYZJsystemNTVC.h"
#import "QYZJYanShouOrBaoXiuTVC.h"
@interface QYZJMessageTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSDictionary *dataDict;
@end

@implementation QYZJMessageTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    self.titleArr = @[@"点赞",@"评论",@"验收",@"报修",@"系统通知"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMessageCell" bundle:nil] forCellReuseIdentifier:@"QYZJMessageCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}




- (void)getData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    zkRequestTongYongTool * tool = [[zkRequestTongYongTool alloc] init];
    tool.subject = [[RACSubject alloc] init];
    [tool requestWithUrl:[QYZJURLDefineTool user_newsURL] andDict:dict];
    @weakify(self);
    [tool.subject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x !=nil && [x[@"key"] intValue] == 1) {
            self.dataDict = x[@"result"];
            [self.tableView reloadData];
        }else {
            [SVProgressHUD dismiss];
        }
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return view;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    QYZJMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMessageCell" forIndexPath:indexPath];
    cell.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"xx_%d",indexPath.row + 1]];
    cell.titleLB.text = self.titleArr[indexPath.row];
    cell.numberStr = [NSString stringWithFormat:@"%d",indexPath.row * 3];
    
    if (self.dataDict != nil) {
        if (indexPath.row == 0) {
             cell.numberStr = [NSString stringWithFormat:@"%@",self.dataDict[@"goodNum"]];
         }else if (indexPath.row == 1) {
             cell.numberStr = [NSString stringWithFormat:@"%@",self.dataDict[@"commentNum"]];
         }else if (indexPath.row ==2) {
            cell.numberStr = [NSString stringWithFormat:@"%@",self.dataDict[@"comfirmNum"]];
         }else if (indexPath.row == 3) {
            cell.numberStr = [NSString stringWithFormat:@"%@",self.dataDict[@"repairNum"]];
         }else if (indexPath.row == 4) {
            cell.numberStr = [NSString stringWithFormat:@"%@",self.dataDict[@"systemNum"]];
         }
    }
 
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < 2) {
        QYZJPingOrZanListTVC * vc =[[QYZJPingOrZanListTVC alloc] init];
         vc.hidesBottomBarWhenPushed = YES;
         vc.type = indexPath.row;
         [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row <= 3) {
        QYZJYanShouOrBaoXiuTVC * vc =[[QYZJYanShouOrBaoXiuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        //系统通知
        QYZJsystemNTVC * vc =[[QYZJsystemNTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
 
    
}


@end
