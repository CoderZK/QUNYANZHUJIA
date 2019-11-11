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
@interface QYZJMessageTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@end

@implementation QYZJMessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    self.titleArr = @[@"点赞",@"评论",@"验收",@"保修",@"系统通知"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMessageCell" bundle:nil] forCellReuseIdentifier:@"QYZJMessageCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    QYZJMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMessageCell" forIndexPath:indexPath];
    cell.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"xx_%ld",indexPath.row + 1]];
    cell.titleLB.text = self.titleArr[indexPath.row];
    cell.numberStr = [NSString stringWithFormat:@"%ld",indexPath.row * 3];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < 2) {
        QYZJPingOrZanListTVC * vc =[[QYZJPingOrZanListTVC alloc] init];
         vc.hidesBottomBarWhenPushed = YES;
         vc.type = indexPath.row;
         [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2) {
        
    }else if (indexPath.row == 3) {
        
    }else {
        //系统通知
        QYZJsystemNTVC * vc =[[QYZJsystemNTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
 
    
}


@end
