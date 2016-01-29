//
//  ViewController.m
//  RewriteDom3-MKMapvVew
//
//  Created by Qianfeng on 16/1/28.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
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
    [self addBackButton];
    
}

//创建大头针
-(void)addAnnotation {
    
  MyAnnotation *annotation = [[MyAnnotation alloc]init];//34.771756 113.682015
    annotation.coordinate = CLLocationCoordinate2DMake(34.771756 ,113.682015);
    annotation.title = @"附近有好吃的";
    annotation.subtitle = @"仔细找找 就发现了";
    
    [_mapView addAnnotation:annotation];
    
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
    [self addAnnotation];
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
        NSLog(@"%f %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    }];
    
    
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //先判断一下是系统的大头针还是自定义的大头针
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
       
    }else{
        NSLog(@"就是我们自己定义的大头针");
        //先检查服用队列里有没有可以复用的大头针
        MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"id"];
        if (!pinAnnotationView) {
            pinAnnotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"id"];
        }
        
        //在这里可以设置大头针视图了
        pinAnnotationView.pinTintColor = [UIColor brownColor];
        //设置弹框是否可以弹出来
        pinAnnotationView.canShowCallout = YES;
        
        //可以设置大头针从天而降
        pinAnnotationView.animatesDrop = NO;
        
         return pinAnnotationView;
    }
}
//当添加大头针到地图上的时候 会调用此方法
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    //如果想要做动画 就用此方法
    for (MKAnnotationView *view in views) {
        //还要判断是不是系统的大头针
        if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
            //如果不是系统的大头针
            //拿到最终的frame
            CGRect endFrame = view.frame;
            view.frame = CGRectMake(endFrame.origin.x, 0, endFrame.size.width, endFrame.size.height);
            [UIView animateWithDuration:0.5 animations:^{
                view.frame = endFrame;
            }];
        }
    }
}

//触摸屏幕的时候 添加一个大头针
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    //首先找到触摸的点
    CGPoint point = [[touches anyObject]locationInView:self.view];
    
    //把点转化为 经纬度坐标
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:point toCoordinateFromView:self.view];
    MyAnnotation *annotation = [[MyAnnotation alloc]init];
    annotation.coordinate = coordinate;
    [_mapView addAnnotation:annotation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






















