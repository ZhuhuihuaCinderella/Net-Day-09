//
//  ViewController.m
//  RewriteDome1 CLLoction
//
//  Created by Qianfeng on 16/1/28.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self createLocationManager];
    //[self createManager];
    //[self countOfTwoDistance];
//    [self geoCoder];
    [self recerseGeoCoder];
}

//地理编码 根据地址算出经纬度
-(void)geoCoder {
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder geocodeAddressString:@"河南省郑州市纬五路21号经纬中学操场" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error) {
            NSLog(@"没有找到位置");
        }else {
            CLPlacemark *plackMark = [placemarks lastObject];
            if (plackMark.locality) {
                NSLog(@"%@",plackMark.locality);
            }
            NSLog(@"%@",plackMark.name);
            NSLog(@"%f %f",plackMark.location.coordinate.latitude,plackMark.location.coordinate.longitude);
        }
    }];
}
//34.772827 113.675891
//反地理编码  根据经纬度 算出来地址
-(void)recerseGeoCoder {
    CLLocation *location = [[CLLocation alloc]initWithLatitude:34.772827 longitude:113.675891];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks lastObject];
        NSLog(@"%@",placeMark.name);
        NSLog(@"%@",placeMark.addressDictionary);
    }];
    
    
}

//计算两个经纬度的差
-(void)countOfTwoDistance {
    CLLocation *location1 = [[CLLocation alloc]initWithLatitude:34.783378 longitude:113.406417];
    CLLocation *location2 = [[CLLocation alloc]initWithLatitude:34.883378 longitude:113.406417];
    //用系统的方法计算
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    NSLog(@"%f",distance);
}

//创建一个定位管理器
- (void)createManager {
    _locationManager = [[CLLocationManager alloc]init];
    //设置代理
    _locationManager.delegate = self;
    //定位过滤器，用户了走了 一千米 定位一次
    _locationManager.distanceFilter = 1;
    //精度,精度越高越费电
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //iOS8以前 直接调用startUpdatingLocation就可以开始定位了
    //iOS8以后在开始定位以前，需要申请定位权限
    //***判断当前系统的版本号，如果大于iOS8，才去申请权限，低版本的不用去申请
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0  ) {
        //申请定位权限 ,定位权限分两种，在申请定位权限之前，必须要在info.plist 文件中配置
        
        // 1.一直定位
        // 需要在info.plist里增加这个key NSLocationAlwaysUsageDescription
        
        // 2.应用在启用的时候才允许定位
        // 需要在info.plist里增加这个key NSLocationWhenInUseUsageDescription
        //申请定位
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
}
//更新了用户的位置
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //1.获取用户的位置
    CLLocation *location = [locations lastObject];
    //经纬度
    CLLocationCoordinate2D coordinate =location.coordinate;
    NSLog(@"纬度%f 经度%f",coordinate.latitude,coordinate.longitude);
}
/*
#pragma mark - 创建定位管理器
-(void)createLocationManager {
    //创建定位管理器
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    //设置距离过滤器 用户走了1m 就定位一次
    _locationManager.distanceFilter = 1;
    //设置精度 精度越高越耗电
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //开始定位
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
}
#pragma mark - 实现协议里的方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //1.获取用户的位置
    CLLocation *location = [locations lastObject];
    //经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f",coordinate.latitude,coordinate.longitude);
    
    
    
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
