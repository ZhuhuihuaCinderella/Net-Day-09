//
//  ViewController.m
//  RewriteDome6 NSMapView 大头针3
//
//  Created by Qianfeng on 16/1/28.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "MyMKAnnotationView.h"
@interface ViewController ()<MKMapViewDelegate>
@property (nonatomic ,strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createLocationManager];
    [self createMapView];
    
}


- (IBAction)buttonPressed:(id)sender {
    //点击按钮的时候添加大头针
    MyAnnotation *annotation = [[MyAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake( 34.772907 ,113.682015);
    annotation.title = @"附近有帅哥";
    annotation.subtitle = @"在哪 在哪 在哪";

    //为什么没有图片??????????????
    annotation.image = [UIImage imageNamed:@"location"];
    annotation.pinImage = [UIImage imageNamed:@"location"];
    
    [_mapView addAnnotation:annotation];
}

/*
-(void)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 10, 50, 20);
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"back" forState:0];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
}
-(void)buttonPressed {
    //点击按钮的时候添加大头针
    MyAnnotation *annotation = [[MyAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake( 34.783378, 113.62445);
    annotation.title = @"附近有帅哥";
    annotation.subtitle = @"在哪 在哪 在哪";
    [_mapView addAnnotation:annotation];
}
 */
-(void)createMapView {
    _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view sendSubviewToBack:_mapView];
}
-(void)createLocationManager {
    _locationManager = [[CLLocationManager alloc]init];
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    //创建自定义的大头针
    MyMKAnnotationView *anView = [MyMKAnnotationView MyMKAnnotationView:mapView];
    [anView configData:annotation];
    return anView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
