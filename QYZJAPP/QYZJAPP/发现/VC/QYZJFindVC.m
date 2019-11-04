//
//  QYZJFindVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindVC.h"
#import "FindHeadView.h"
#import "QYZJFindOneCell.h"
@interface QYZJFindVC ()
@property(nonatomic,strong)FindHeadView *navigaV;
@end

@implementation QYZJFindVC
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
    

     self.tableView.frame = CGRectMake(0, sstatusHeight + 110, ScreenW, ScreenH - sstatusHeight - 110);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJFindOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJFindOneCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
     [self addNav];
}

- (void)addNav {
    
    self.navigaV = [[FindHeadView alloc] initWithFrame:CGRectMake(0, sstatusHeight, ScreenW, 110)];
    [self.view addSubview:self.navigaV];
    self.navigaV.delegateSignal = [RACSubject subject];
    [self.navigaV.delegateSignal subscribeNext:^(id  _Nullable x) {
       
        NSDictionary * dict = x;
        if ([[NSString stringWithFormat:@"%@",dict[@"search"]] isEqualToString:@"city"]) {
            //点击搜索
        }else {
            NSNumber *number = dict[@"text"];
            
            NSLog(@"%@",number);

        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJFindOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJFindOneCell" forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
