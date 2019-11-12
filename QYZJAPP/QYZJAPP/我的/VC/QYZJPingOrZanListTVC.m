//
//  QYZJPingOrZanListTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJPingOrZanListTVC.h"
#import "QYZJPingOrZanCell.h"

@interface QYZJPingOrZanListTVC ()
@property(nonatomic,strong)UIButton *left1Bt,*left2Bt,*rightBt;
@end

@implementation QYZJPingOrZanListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setheadV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJPingOrZanCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"详情";
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJPingOrZanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.type == 0) {
        cell.imgVTwo.hidden = YES;
        cell.contentLB.hidden = NO;
    }else {
        cell.imgVTwo.hidden = NO;
        cell.contentLB.hidden = YES;
    }
    cell.titleLB.text = @"测试";
    cell.rightLB.text = @"安全热偶if就阿偶时候如果覅滑丝的回复我阿UR荣华富贵我很委屈儒雅我润肺而且我让";
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)setheadV {
    
    UIView * headV= [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    headV.backgroundColor = [UIColor whiteColor];
    
    self.left1Bt = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
    self.left1Bt.titleLabel.font = kFont(14);
    [self.left1Bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.left1Bt setTitleColor:OrangeColor forState:UIControlStateSelected];
    self.left1Bt.tag = 100;
    self.left1Bt.selected = YES;
    [self.left1Bt setTitle:@"未读" forState:UIControlStateNormal];
    [self.left1Bt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:self.left1Bt];
    
    self.left2Bt = [[UIButton alloc] initWithFrame:CGRectMake(90, 10, 60, 30)];
    self.left2Bt.titleLabel.font = kFont(14);
    [self.left2Bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.left2Bt setTitleColor:OrangeColor forState:UIControlStateSelected];
    self.left2Bt.tag = 101;
    [self.left2Bt setTitle:@"已读" forState:UIControlStateNormal];
    [self.left2Bt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:self.left2Bt];
    
    
    self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 120, 10, 110, 30)];
    self.rightBt.titleLabel.font = kFont(14);
    [self.rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.rightBt.layer.cornerRadius = 3;
    self.rightBt.clipsToBounds = YES;;
  
    [self.rightBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    self.rightBt.tag = 102;
    [self.rightBt setTitle:@"全部标记为已读" forState:UIControlStateNormal];
    [self.rightBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:self.rightBt];
    
    
    self.tableView.tableHeaderView = headV;
}

- (void)action:(UIButton *)button {
    if (button.tag == 100) {
        self.left1Bt.selected = YES;
        self.left2Bt.selected = NO;
        self.rightBt.hidden = NO;
    }else if (button.tag == 101) {
        self.left1Bt.selected = NO;
        self.left2Bt.selected = YES;
        self.rightBt.hidden = YES;
    }else {
        
    }

}

@end
