//
//  QYZJCityChooseTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJCityChooseTVC.h"

@interface QYZJCityChooseTVC ()
@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)NSMutableArray *rightDataArr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *userCityList;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *searchList;
@property(nonatomic,strong)UIView *headView,*cityView;
@property(nonatomic,assign)BOOL isSearch;
@property(nonatomic,strong)UIButton *addressBt;
@end

@implementation QYZJCityChooseTVC
- (NSMutableDictionary *)dataDict {
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

- (NSMutableArray *)rightDataArr {
    if (_rightDataArr == nil) {
        _rightDataArr = [NSMutableArray array];
    }
    return _rightDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择城市";
    self.userCityList = @[].mutableCopy;
    self.dataArray = @[].mutableCopy;
    self.searchList = @[].mutableCopy;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self acquireDataFromServe];
    [self addheadView];;
    
}

- (void)addheadView {
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    UIView * gayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    gayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headView addSubview:gayView];
    
    UISearchBar * searchbar =[[UISearchBar alloc] initWithFrame:CGRectMake(20, 10, ScreenW - 40, 30)];
    searchbar.placeholder = @"搜索城市";
    searchbar.searchTextField.font = kFont(14);
    searchbar.layer.cornerRadius = 8;
    searchbar.clipsToBounds = YES;
    searchbar.barStyle=UIBarStyleDefault;
    [gayView addSubview:searchbar];
    [searchbar setBarTintColor:[UIColor groupTableViewBackgroundColor]];
    [searchbar.searchTextField.rac_textSignal  subscribeNext:^(NSString * _Nullable x) {
       //文字发生改变时
        if (x.length > 0) {
            self.isSearch = YES;
            [self searchAction:x];
        }else {
            self.isSearch = NO;
            [self.tableView reloadData];
        }
   
        
    }];
    self.tableView.tableHeaderView = self.headView;
    searchbar.backgroundImage = [self imageWithColor:[UIColor groupTableViewBackgroundColor] size:CGSizeMake(1,1)];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(gayView.frame)+5, ScreenW-30, 20)];
    label.textColor = CharacterBlack70;
    label.font = kFont(15);
    label.text = @"定位城市";
    [self.headView addSubview:label];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) + 5, ScreenW - 20, 20)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitle:@"定位中..." forState:UIControlStateNormal];
    [self.headView addSubview:button];
    self.addressBt = button;
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(button.frame)+5, ScreenW-30, 20)];
    label1.textColor = CharacterBlack70;
    label1.font = kFont(15);
    label1.text = @"切换城市";
    [self.headView addSubview:label];
    
    self.cityView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame)+5, ScreenW, 20)];
    [self.headView addSubview:self.cityView];
    
 
}





//搜索
- (void)searchAction:(NSString *)text{
    [self.searchList removeAllObjects];
    for (zkPickModel * model  in self.dataArray) {
        if ([model.name containsString:text]) {
            [self.searchList addObject:model];
        }
    }
    
    [self.tableView reloadData];

}

- (void)setBiaoQianWithArr:(NSArray<zkPickModel *> *)arr {

    [self.cityView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (arr.count == 0) {
        self.cityView.mj_h = 0;
        self.headView.mj_h = CGRectGetMaxY(self.cityView.frame) + 10;
        self.tableView.tableHeaderView = self.headView;
        return;
    }
    
    CGFloat spaceX  = 10;
    CGFloat spaceY  = 20;
    CGFloat ww = (ScreenW - 30 - 3 * spaceX) / 4;
    CGFloat hh = 35;
    for (int i = 0;i< arr.count; i++) {
        UIButton * newProductBTBT = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) , 40  + (spaceY + hh) * (i/4), ww, hh)];
        [newProductBTBT setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
        [newProductBTBT setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateSelected];
        newProductBTBT.tag = i+1000;
        newProductBTBT.titleLabel.font = kFont(14);
        newProductBTBT.layer.cornerRadius = 4;
        newProductBTBT.clipsToBounds = YES;
        [newProductBTBT setTitleColor:CharacterBlack70 forState:UIControlStateNormal];
        [newProductBTBT setTitleColor:WhiteColor forState:UIControlStateSelected];
        [newProductBTBT setTitle:arr[i].name forState:UIControlStateNormal];
        [self.cityView addSubview:newProductBTBT];
        [newProductBTBT addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton * delectBt = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) + ww - 7.5 ,40  + (spaceY + hh) * (i/4) - 7.5 , 15, 15)];
        [delectBt setBackgroundImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
        delectBt.tag = 100+i;
        [delectBt addTarget:self action:@selector(delectCity:) forControlEvents:UIControlEventTouchUpInside];
        [self.cityView addSubview:delectBt];
        if (i+1 == arr.count) {
            self.cityView.mj_h = 20 + newProductBTBT.mj_y + hh;
            self.headView.mj_h = CGRectGetMaxY(self.cityView.frame) + 10;
        }
        

    }
    self.tableView.tableHeaderView = self.headView;
}


#pragma marke---- 点击切换城市的城市 -------
- (void)selectAction:(UIButton *)button {
    
    
    
}

- (void)delectCity:(UIButton *)button {
    
    NSString * url = [QYZJURLDefineTool user_delUserCityURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)acquireDataFromServe {
    
    
    NSString * url = [QYZJURLDefineTool user_cityListURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"key"] intValue]== 1) {
            NSArray * arr = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"cityList"]];
            self.userCityList = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"userCityList"]];
            [self setBiaoQianWithArr:self.userCityList];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            }
            self.dataDict = nil;
            [self paiXunAction];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSearch) {
        return 1;
    }
    return self.rightDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearch) {
        return self.searchList.count;
    }
    return [self.dataDict[self.rightDataArr[section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.isSearch) {
        zkPickModel * model = self.searchList[indexPath.row];
        cell.textLabel.text = model.name;
    }else {
       zkPickModel * model = [self.dataDict[self.rightDataArr[indexPath.section]] objectAtIndex:indexPath.row];
       cell.textLabel.text = model.name;
    }
    
   
    cell.textLabel.font = kFont(14);
    return cell;
    
}


/**每一组的标题*/
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isSearch) {
        return nil;
    }
    return self.rightDataArr[section];
}

/** 右侧索引列表*/
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    /*
     索引数组中的"内容"，跟分组无关
     索引数组中的下标，对应的是分组的下标
     return @[@"哇哈哈", @"hello", @"哇哈哈", @"hello", @"哇哈哈", @"hello", @"哇哈哈", @"hello"];
     返回self.carGroup中title的数组
     NSMutableArray *arrayM = [NSMutableArray array];
     for (HMCarGroup *group in self.carGroups) {
     [arrayM addObject:group.title];
     }
     return arrayM;
     KVC是cocoa的大招
     用来间接获取或者修改对象属性的方式
     使用KVC在获取数值时，如果指定对象不包含keyPath的"键名"，会自动进入对象的内部查找
     如果取值的对象是一个数组，同样返回一个数组
     */
    /*例如：
     NSArray *array = [self.carGroups valueForKeyPath:@"cars.name"];
     NSLog(@"%@", array);
     */
    
    if (self.isSearch) {
        return @[];
    }
    return self.rightDataArr;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSearch) {
        return 0.01;;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        view.backgroundColor = RGB(245, 245, 245);
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 50)];
        lb.font = kFont(15);
        [view addSubview:lb];
        lb.tag = 100;
    }
    
    UILabel * lb = (UILabel *)[view viewWithTag:100];
    lb.text = self.rightDataArr[section];
    view.clipsToBounds = YES;
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//排序
- (void)paiXunAction {
    for (int i = 0 ; i < self.dataArray.count; i++) {
        if (self.dataArray[i]) {
            //将取出的名字转换成字母
            NSMutableString *pinyin = [self.dataArray[i].name mutableCopy];
            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
            /*多音字处理*/
            NSString * firstStr = [self.dataArray[i].name substringToIndex:1];
            if ([firstStr compare:@"长"] == NSOrderedSame)
            {
                if (pinyin.length>=5)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
                }
            }
            else if ([firstStr compare:@"沈"] == NSOrderedSame)
            {
                if (pinyin.length>=4)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
                }
            }
            else if ([firstStr compare:@"厦"] == NSOrderedSame)
            {
                if (pinyin.length>=3)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
                }
            }
            else if ([firstStr compare:@"地"] == NSOrderedSame)
            {
                if (pinyin.length>=3)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
                }
            }
            else if ([firstStr compare:@"重"] == NSOrderedSame)
            {
                if (pinyin.length>=5)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
                }
            }
            //将拼音转换成大写拼音
            NSString * upPinyin = [pinyin uppercaseString];
            //取出第一个首字母当做字典的key
            NSString * firstChar = [upPinyin substringToIndex:1];
            NSMutableArray * arr = [self.dataDict objectForKey:firstChar];
            if (!arr)
            {
                arr = [NSMutableArray array];
                [_dataDict setObject:arr forKey:firstChar];
            }
            [arr addObject:self.dataArray[i]];
        }
        else
        {
            NSMutableArray * arr = [self.dataDict objectForKey:@"#"];
            if (!arr)
            {
                arr = [NSMutableArray array];
                [self.dataDict setObject:arr forKey:@"#"];
            }
            [arr addObject:self.dataArray[i]];
        }
    }
    
    self.rightDataArr = [self paixuArrWithArr:self.dataDict.allKeys].mutableCopy;
    if (self.rightDataArr.count > 0 && [[self.rightDataArr firstObject] isEqualToString:@"#"]) {
        [self.rightDataArr removeObjectAtIndex:0];
        [self.rightDataArr addObject:@"#"];
    }
    [self.tableView reloadData];
    
}

//排序
- (NSArray * )paixuArrWithArr:(NSArray *)arr {
    
    if (arr.count == 0) {
        return arr;
    }
    NSArray *resultkArrSort = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    
    return resultkArrSort;
}

- (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size{
    
       CGRect rect =CGRectMake(0,0, size.width, size.height);
    
        UIGraphicsBeginImageContext(rect.size);
    
        CGContextRef context =UIGraphicsGetCurrentContext();
    
        CGContextSetFillColorWithColor(context, [color CGColor]);
    
        CGContextFillRect(context, rect);
    
        UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
        UIGraphicsEndImageContext();
    
        return image;
    
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
