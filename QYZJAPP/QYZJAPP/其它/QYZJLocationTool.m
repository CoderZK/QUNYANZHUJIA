//
//  QYZJLocationTool.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJLocationTool.h"

@interface QYZJLocationTool()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager* locationManager;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *dataArray;
@property(nonatomic,strong)NSString *cityStr;
@end

@implementation QYZJLocationTool
- (void)locationAction{
    [self findMe];
    [self getCityList];
}


- (void)findMe
{
    if ([CLLocationManager locationServicesEnabled]) {
        // 初始化定位管理器
        self.locationManager=[[CLLocationManager alloc]init];
        self.locationManager.delegate=self;
        // 设置定位精确度到千米
        self.locationManager.desiredAccuracy=kCLLocationAccuracyKilometer;
        // 设置过滤器为无
        self.locationManager.distanceFilter=kCLDistanceFilterNone;
        //这句话ios8以上版本使用
        [ self.locationManager requestAlwaysAuthorization];
        //开始定位
        [ self.locationManager startUpdatingLocation];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法定位" message:@"请检查你的设备是否开启定位功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    
    //根据经纬度反向地理编译出地址信息
       CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
       
       [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
           
           for (CLPlacemark * placemark in placemarks) {
               
               NSDictionary *address = [placemark addressDictionary];
               
               //  Country(国家)  State(省)  City（市）
               NSLog(@"#####%@",address);
               
               NSLog(@"%@", [address objectForKey:@"Country"]);
               
               NSLog(@"%@", [address objectForKey:@"State"]);
               
               NSLog(@"%@", [address objectForKey:@"City"]);
               self.cityStr = [NSString stringWithFormat:@"%@",[address objectForKey:@"City"]];;
               if (self.locationBlock != nil) {
//                   self.locationBlock([address objectForKey:@"City"]);
                   [self sendCity];
                   
                   
               }
               
           }
           
       }];
    
    // 2.停止定位
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}


- (void)getCityList {
    
    
    NSString * url = [QYZJURLDefineTool user_cityListURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"key"] intValue]== 1) {

            [zkSignleTool shareTool].dataArray = responseObject[@"result"][@"cityList"];
            
            NSArray * arr = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"cityList"]];
            self.dataArray = arr;
            
            [self sendCity];
            
        
        }else {
          
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
     
    }];
}

- (void)sendCity {
    
    for (zkPickModel * model  in self.dataArray) {
        if ([self.cityStr isEqualToString:model.name]) {
            if (self.locationBlock != nil) {
                self.locationBlock(self.cityStr, model.ID);
            }
        }
    }
    
}


@end
