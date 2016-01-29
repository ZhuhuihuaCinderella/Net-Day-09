//
//  MyMKAnnotationView.h
//  RewriteDome6 NSMapView 大头针3
//
//  Created by Qianfeng on 16/1/28.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
@interface MyMKAnnotationView : MKAnnotationView

+(instancetype)MyMKAnnotationView:(MKMapView*)mapView ;

//配置大头针数据
-(void)configData:(MyAnnotation*)myAnnotation;

@end
