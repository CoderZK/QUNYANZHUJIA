//
//  TabBarController.m
//  Elem1
//
//  Created by sny on 15/9/17.
//  Copyright (c) 2015年 cznuowang. All rights reserved.
//

#import "TabBarController.h"
#import "BaseViewController.h"
#import "QYZJHomeVC.h"
#import "QYZJMineVC.h"
#import "QYZJFindVC.h"
#import "QYZJRecommendVC.h"

@interface TabBarController ()
{
    BaseNavigationController * _mineNavi;
}
@end

@implementation TabBarController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *imgArr=@[@"ico_shouye_2-1",@"ico+faxian",@"ico_wde"];
    NSArray *selectedImgArr=@[@"ico_shouye",@"ico_faxian_2",@"ico_wde_2"];
    NSArray *barTitleArr=@[@"首页",@"发现",@"我的"];
    NSArray *className=@[@"QYZJHomeVC",@"QYZJFindVC",@"QYZJMineVC"];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    
    
    for (int i=0; i<className.count; i++)
    {
        NSString *str=[className objectAtIndex:i];
        BaseViewController *vc = nil;
        
        //此处创建控制器要根据自己的情况确定是否带tableView 
        
//        if (i== 0)
//        {
//           vc=[[NSClassFromString(str) alloc] initWithTableViewStyle:UITableViewStylePlain];
//        }
//        else
//        {
            vc=[[NSClassFromString(str) alloc] initWithTableViewStyle:UITableViewStyleGrouped];
//        }
        

        NSString *str1=[imgArr objectAtIndex:i];
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        attrs[NSForegroundColorAttributeName] = CharacterColor80;
        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
        selectedAttrs[NSForegroundColorAttributeName] = TabberGreen;
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        //让图片保持原来的模样，未选中的图片
        vc.tabBarItem.image=[[UIImage imageNamed:str1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //图片选中时的图片
        NSString *str2=[selectedImgArr objectAtIndex:i];
        vc.tabBarItem.selectedImage=[[UIImage imageNamed:str2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //页面的bar上面的title值
        NSString *str3=[barTitleArr objectAtIndex:i];
        vc.tabBarItem.title=str3;
        self.tabBar.tintColor=[UIColor blackColor];
        
        //给每个页面添加导航栏
        BaseNavigationController *nav=[[BaseNavigationController alloc] initWithRootViewController:vc];
        [arr addObject:nav];
    }
 
 
    self.viewControllers=arr;
    _mineNavi = arr.lastObject;
    self.tabBar.barTintColor = [UIColor whiteColor];
}

@end
