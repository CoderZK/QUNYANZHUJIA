//
//  QYZJFindGuangChangDetailTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindGuangChangDetailTVC.h"
#import "QYZJFindGuangChangDetailView.h"
#import "QYZJPingLunNeiCell.h"
@interface QYZJFindGuangChangDetailTVC ()
@property(nonatomic,strong)QYZJFindModel *dataModel;
@property(nonatomic,strong)QYZJFindGuangChangDetailView *headV;
@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UITextField *TF;
@end

@implementation QYZJFindGuangChangDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self getData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJPingLunNeiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 1;
    
    self.whiteView = [[UIView alloc] init];
    self.whiteView.layer.cornerRadius = 3;
    self.whiteView.clipsToBounds = YES;
    self.whiteView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.whiteView.mj_w = ScreenW ;
    self.whiteView.mj_h = 60;
    self.whiteView.mj_x = 15;
    [self.view addSubview:self.whiteView];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 10, ScreenW, 40)];
    backV.backgroundColor = WhiteColor;
    [self.whiteView addSubview:backV];
    

    
    self.TF = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, ScreenW - 50, 30)];
    self.TF.font = kFont(14);
    self.TF.placeholder = @"请输入评论";
    [backV addSubview:self.TF];
    
    
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44 - 34 - 60);
        self.whiteView.mj_y = ScreenH - sstatusHeight - 44 - 34 -60;
    }else {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44 -60);
         self.whiteView.mj_y = ScreenH - sstatusHeight - 44  -60;
    }
    
    
    
    
    
}

- (QYZJFindGuangChangDetailView *)headV {
    if (_headV == nil) {
        _headV = [[QYZJFindGuangChangDetailView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.01)];
        _headV.clipsToBounds = YES;
        
    }
    return _headV;
}


- (void)getData {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"id"] = self.ID;
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_articleDetailsURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.dataModel = [QYZJFindModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.model = self.dataModel;
            self.headV.mj_h = self.headV.headHeight;
            self.tableView.tableHeaderView = self.headV;
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModel.commentList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QYZJTongYongHeadFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[QYZJTongYongHeadFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.4, ScreenW, 0.6)];
        backV.backgroundColor = lineBackColor;
        [view addSubview:backV];
        

    }
    view.rightBt.hidden = YES;
    view.leftLB.text = [NSString stringWithFormat:@"评论(%@)",self.dataModel.commentNum];;
    view.backgroundColor = WhiteColor;
    view.contentView.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJPingLunNeiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    QYZJFindModel * model = self.dataModel.commentList[indexPath.row];
    if ([model.commentId intValue] > 0) {
        NSString * str = [NSString stringWithFormat:@"%@回复%@ : %@",model.nickName,model.toNickName,model.commentContent];
        NSRange range1 = NSMakeRange(0, model.nickName.length);
        NSRange range2 = NSMakeRange(model.nickName.length + 2, model.toNickName.length);
        cell.titleLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor] textColorOne:OrangeColor textColorTwo:[UIColor blueColor] nsrangeOne:range1 nsRangeTwo:range2];

    }else {
        NSString * str = [NSString stringWithFormat:@"%@ : %@",model.nickName,model.commentContent];
        cell.titleLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor] textColorTwo:OrangeColor nsrange:NSMakeRange(0,model.nickName.length)];

    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
