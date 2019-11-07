//
//  QYZJMinePayDetailVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMinePayDetailVC.h"
#import "QYZJHomePayCell.h"
#import "QYZJHomePayDetailOneCell.h"
#import "QYZJTongYongHeadFootView.h"
#import "QYZJPicShowCell.h"
@interface QYZJMinePayDetailVC ()
@property(nonatomic,strong)NSArray *headTitleArr;
@end

@implementation QYZJMinePayDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomePayCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomePayCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomePayDetailOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomePayDetailOneCell"];
    
    [self.tableView registerClass:[QYZJPicShowCell class] forCellReuseIdentifier:@"QYZJPicShowCell"];

    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.headTitleArr = @[@"",@"支付",@"合同",@"预算",@"图纸",@"变更相册"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2+4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
        
    }else if (section == 1) {
        return 2;
    }else if (section<=5) {
        return 1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 125;
    }else if (indexPath.section == 1) {
        return 110;
    }else if (indexPath.section <=5) {
        return  (ScreenW - 60)/3 + 25;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else if (section <=5) {
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
    
    QYZJTongYongHeadFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[QYZJTongYongHeadFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    }
    view.leftLB.text = self.headTitleArr[section];
    view.backgroundColor = WhiteColor;
    view.contentView.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QYZJHomePayCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayCell" forIndexPath:indexPath];
        cell.contentLB.hidden = YES;
        return cell;
    }else if (indexPath.section == 1) {
        QYZJHomePayDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailOneCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section <=5) {
        QYZJPicShowCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJPicShowCell" forIndexPath:indexPath];
        cell.picsArr = @[@"",@""];
        return cell;
    }
    QYZJHomePayDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomePayDetailOneCell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
