//
//  QYZJMineAddressTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineAddressTVC.h"
#import "QYZJAddAddressVC.h"
#import "QYZJMineAddressTwoCell.h"
@interface QYZJMineAddressTVC ()

@end

@implementation QYZJMineAddressTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"地址列表";
    

    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineAddressTwoCell" bundle:nil] forCellReuseIdentifier:@"cell"];    
    [self setFootV];
    
}

- (void)setFootV {
    
  self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
  if (sstatusHeight > 20) {
      self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
  }
  KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"添加新地址" andImgaeName:@"jia"];
  Weak(weakSelf);
   view.footViewClickBlock = ^(UIButton *button) {
       QYZJAddAddressVC * vc =[[QYZJAddAddressVC alloc] init];
       vc.hidesBottomBarWhenPushed = YES;
       [weakSelf.navigationController pushViewController:vc animated:YES];
  };
  [self.view addSubview:view];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineAddressTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
