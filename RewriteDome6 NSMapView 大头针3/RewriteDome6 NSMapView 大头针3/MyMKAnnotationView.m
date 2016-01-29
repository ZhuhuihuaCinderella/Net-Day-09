//
//  MyMKAnnotationView.m
//  RewriteDome6 NSMapView 大头针3
//
//  Created by Qianfeng on 16/1/28.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "MyMKAnnotationView.h"

@implementation MyMKAnnotationView


+(instancetype)MyMKAnnotationView:(MKMapView*)mapView {
    //先去检查复用队列里有没有可用的大头针视图
    MyMKAnnotationView *annotationView = (MyMKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"id"];
    //如果不在 就去创建
    if (!annotationView) {
        annotationView = [[MyMKAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:@"id"];
        annotationView.canShowCallout = YES;
        //在这里可以设置左右视图 格式固定的可以在这里设置
    }
    return annotationView;
}

//配置大头针数据
-(void)configData:(MyAnnotation*)myAnnotation {
    self.annotation = myAnnotation;
    self.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"location"]];
    //定义了大头针视图
    self.image = myAnnotation.pinImage;
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
