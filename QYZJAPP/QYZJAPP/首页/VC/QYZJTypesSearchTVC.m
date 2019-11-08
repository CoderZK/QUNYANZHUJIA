//
//  QYZJTypesSearchTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJTypesSearchTVC.h"
#import "FindHeadView.h"
#import "QYZJSearchView.h"
#import "QYZJSearchLabelView.h"
#import "QYZJHomeFourCell.h"
#import "QYZJHomeFiveCell.h"
@interface QYZJTypesSearchTVC ()
@property(nonatomic,strong)FindHeadView *navigaV;
@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)QYZJSearchView *serachV;
@property(nonatomic,strong)QYZJSearchLabelView *LabelV;
@property(nonatomic,assign)NSInteger typeIndex;

@end

@implementation QYZJTypesSearchTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    self.titleArr = @[].mutableCopy;
    self.dataDict = @{}.mutableCopy;
    [self setheadV];
    [self getLeiXingData];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFourCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFourCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFiveCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFiveCell"];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}



- (void)setheadV {

    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
    self.headV.clipsToBounds = YES;    
    self.navigaV = [[FindHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
       self.navigaV.clipsToBounds = YES;
    


       self.navigaV.delegateSignal = [RACSubject subject];
       [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {

           NSDictionary * dict = x;
           if ([[NSString stringWithFormat:@"%@",dict[@"search"]] isEqualToString:@"city"]) {
               //点击搜索
           }
       }];

       [self.headV addSubview:self.navigaV];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 60, ScreenW, 10)];
    backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headV addSubview:backV];

    self.serachV = [[QYZJSearchView alloc] initWithFrame:CGRectMake(0, 70, ScreenW, 49.4)];
    [self.headV addSubview:self.serachV];
    Weak(weakSelf);
    self.serachV.clickHeadBlock = ^(NSInteger index) {
        //点击了标题
        weakSelf.LabelV.dataArray = weakSelf.dataDict[weakSelf.titleArr[index]];;
        weakSelf.headV.mj_h = CGRectGetMaxY(weakSelf.LabelV.frame);
        weakSelf.tableView.tableHeaderView = weakSelf.headV;
    };
    
    
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(0, 119.4, ScreenW, 0.6)];
    backV1.backgroundColor = lineBackColor;
    [self.headV addSubview:backV1];
    

    
    self.LabelV = [[QYZJSearchLabelView alloc] initWithFrame:CGRectMake(0, 120, ScreenW, 0)];
    [self.headV addSubview:self.LabelV];
    self.LabelV.clickLabelBlock = ^(NSInteger index) {
        NSLog(@"=====\n%ld",index);

    };
    self.tableView.tableHeaderView = self.headV;

}



- (void)getLeiXingData {

    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findLabelByTypeListURL] parameters:@{@"role_id":self.role_id} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {

            NSMutableArray * arr = [QYZJTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            self.dataDict =  [self getDataDictWithArr:arr];
            [self setViewData];

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];

}

- (void)setViewData {
    NSArray * arr = [self.dataDict allKeys];
    self.serachV.dataArray = arr.mutableCopy;
    if (arr.count>0) {
        self.LabelV.dataArray = self.dataDict[arr[0]];
        self.headV.mj_h = CGRectGetMaxY(self.LabelV.frame);
        self.tableView.tableHeaderView = self.headV;
    }else {

    }
}
- (NSMutableDictionary *)getDataDictWithArr:(NSMutableArray<QYZJTongYongModel *>*)dataArr {
    NSMutableDictionary * dict = @{}.mutableCopy;
    for (QYZJTongYongModel *   model in dataArr) {
        if ([self.titleArr containsObject:model.typeName]) {
            
            NSMutableArray * arr = dict[model.typeName];;
            [arr addObject:model];
            dict[model.typeName] = arr;
            
        }else {
            [self.titleArr addObject:model.typeName];
            NSMutableArray * arr = @[].mutableCopy;
            [arr addObject:model];
            dict[model.typeName] = arr;
        
        }
        
    }
    return dict;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        QYZJHomeFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFourCell" forIndexPath:indexPath];
        return cell;
    }else {
        QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"------%@",indexPath);

}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
