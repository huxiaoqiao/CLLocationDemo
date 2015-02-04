//
//  CLView.h
//  CLLocationDemo
//
//  Created by 胡晓桥 on 15/2/2.
//  Copyright (c) 2015年 Qian100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CLView : UIView

- (void)setCoordinateInfo:(CLLocationCoordinate2D)coordinate altitude:(CLLocationDistance)altitude;

- (void)setProvince:(NSString *)province City:(NSString *)city Street:(NSString *)street;

@end
