//
//  ViewController.m
//  RewriteDom3-MKMapvVew
//
//  Created by Qianfeng on 16/1/28.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<MKMapViewDelegate>
@property (strong,nonatomic)MKMapView *mapView;
@property (strong,nonatomic) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createLocationManager];
    [self createMapView];
    //[self addBackButton];
}
//创建返回button
-(void)addBackButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 10, 50, 20);
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"Back" forState:0];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//实现按钮方法  回到原来的位置
-(void)backButtonPressed {
    [_mapView setRegion:MKCoordinateRegionMake(_mapView.userLocation.coordinate, MKCoordinateSpanMake(0.00001, 0.00001)) animated:YES];
}


//创建地图视图
-(void)createMapView {
    _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    _mapView.mapType = MKMapTypeStandard;
    //显示用户位置
    _mapView.showsUserLocation = YES;
    //跟踪用户的位置
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.delegate = self;
}
//创建定位管理器
-(void)createLocationManager {
    _locationManager = [[CLLocationManager alloc]init];
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }
}
//定位到用户位置的时候 就会调用这个方法

//点一下蓝色的定位圈圈 就会显示 出东西
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    //userLocation.title = @"用户当前位置";
    //userLocation.subtitle = @"详细位置";
    
//    userLocation  CLPlacemark 点进去 看一下吧.....................
    
    
    
//    userLocation.coordinate.latitude
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:_mapView.userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks lastObject];
        if (placeMark.locality) {
            userLocation.title = placeMark.locality;
        }else {
            userLocation.title = placeMark.administrativeArea;
        }
        userLocation.subtitle = placeMark.name;
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






















