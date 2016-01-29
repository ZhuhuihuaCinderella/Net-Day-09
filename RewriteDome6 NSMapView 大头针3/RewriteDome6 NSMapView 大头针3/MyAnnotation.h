//
//  MyAnnotation.h
//  RewriteDome6 NSMapView 大头针3
//
//  Created by Qianfeng on 16/1/28.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;


@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *pinImage;

@end
