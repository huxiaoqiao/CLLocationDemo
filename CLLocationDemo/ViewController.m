//
//  ViewController.m
//  CLLocationDemo
//
//  Created by 胡晓桥 on 15/2/2.
//  Copyright (c) 2015年 Qian100. All rights reserved.
//

#import "ViewController.h"
#import "CLView.h"
#import "UIColor+helper.h"
#import <CoreLocation/CoreLocation.h>

#define kViewMargin 10.f
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    CLView *_clView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#111111" withAlpha:1];
    
    _clView = [[CLView alloc] initWithFrame:CGRectMake(kViewMargin, 104,SCREEN_WIDTH - 2*kViewMargin,SCREEN_WIDTH - 2*kViewMargin)];
    [self.view addSubview:_clView];
    
    UIButton *locationButtom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    locationButtom.center = CGPointMake(SCREEN_WIDTH / 2, _clView.frame.origin.y + _clView.frame.size.height + 60);
    locationButtom.bounds = CGRectMake(0, 0, 80, 40);
    [locationButtom setTitle:@"开始定位" forState:UIControlStateNormal];
    [locationButtom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [locationButtom addTarget:self action:@selector(startUpdateLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationButtom];
    
   _locationManager = [[CLLocationManager alloc] init];
    
    
    //判断用户是否开启了地图服务
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中开启地图服务" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:confirmAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate = self;
        //设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位频率，每隔多少米定位一次
        CLLocationDistance distance = 10.0;//10米定位一次
        _locationManager.distanceFilter = distance;
        
    }
}

- (void)startUpdateLocation
{
    //启动跟踪定位
    [_locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate
/**
 *  位置发生改变后执行（第一次定位到某个位置之后也会执行）
 *
 *  @param manager   CLLocationManager对象
 *  @param locations locations数组
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations[0];
    
    if (location) {
        CLLocationCoordinate2D coordinate = location.coordinate;
        [_clView setCoordinateInfo:coordinate altitude:location.altitude];
        
        _geocoder = [[CLGeocoder alloc] init];
        [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *placemark = placemarks[0];
            NSDictionary *addressDic = placemark.addressDictionary;
            
            [_clView setProvince:addressDic[@"State"] City:addressDic[@"City"] Street:addressDic[@"Name"]];
                        
            
        }];
    }
    
    
    //停止定位
    [_locationManager stopUpdatingLocation];
}

@end
