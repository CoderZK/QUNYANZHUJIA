//
//  QYZJJiaoFuZiLiaoTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJJiaoFuZiLiaoTVC.h"
#import "QYZJJiaoFuZiLiaoCell.h"
@interface QYZJJiaoFuZiLiaoTVC ()<QYZJJiaoFuZiLiaoCellDelegate>
@property(nonatomic,strong)NSArray *leftArr;
@end

@implementation QYZJJiaoFuZiLiaoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写资料";
    [self.tableView registerClass:[QYZJJiaoFuZiLiaoCell class] forCellReuseIdentifier:@"QYZJJiaoFuZiLiaoCell"];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    [self setFootV];
    self.leftArr = @[@""];
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"下一步" andImgaeName:@""];
    Weak(weakSelf);
     view.footViewClickBlock = ^(UIButton *button) {
              NSLog(@"\n\n%@",@"完成");
         QYZJShowFromTopView * view = [[QYZJShowFromTopView alloc] initWithFrame:CGRectMake(0, 0 , ScreenW, ScreenH)];
         [self.view addSubview:view];
         view.dataArray = @[@"1",@"2",@"3"];
         view.subject = [[RACSubject alloc] init];
         [[view.TF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
             
         }];
         //点击
         [view.subject subscribeNext:^(id  _Nullable x) {
             
         }];
         [view show];
    };
    [self.view addSubview:view];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return 50;
    }
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {

        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.textColor = CharacterColor180;
        cell.rightLB.hidden = cell.swith.hidden = cell.moreImgV.hidden = YES;
        cell.TF.userInteractionEnabled = YES;
        cell.leftLB.text = @"签单金额";
        cell.TF.placeholder = @"请输入签单额";
        return cell;
    }
    QYZJJiaoFuZiLiaoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJJiaoFuZiLiaoCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.dataArray = @[].mutableCopy;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark ---- 点击图片添加或者删除 ----
- (void)didClickQYZJJiaoFuZiLiaoCell:(QYZJJiaoFuZiLiaoCell *)cell withIndex:(NSInteger)index withIsdelect:(BOOL)isDelect {
    
    
    
}


@end
