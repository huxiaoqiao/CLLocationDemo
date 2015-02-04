//
//  CLView.m
//  CLLocationDemo
//
//  Created by 胡晓桥 on 15/2/2.
//  Copyright (c) 2015年 Qian100. All rights reserved.
//

#import "CLView.h"
#import "UIColor+helper.h"

@interface CLView()
{
    UILabel *_longitudeLabel;
    UILabel *_latitudeLabel;
    UILabel *_provinceLabel;
    UILabel *_cityLabel;
    UILabel *_streetLabel;
    UILabel *_atitudeLabel;
    
    CGFloat _viewWidth;
    CGFloat _viewHeight;
    CGFloat _columnHeight;
    
}
@end

@implementation CLView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewWidth = frame.size.width;
        _viewHeight = frame.size.height;
        _columnHeight = _viewHeight / 7.0;
        [self initSet];
    }
    return self;
}

- (void)initSet
{
    self.backgroundColor = [UIColor colorWithHexString:@"#222222" withAlpha:1];
    self.layer.borderColor = [UIColor colorWithHexString:@"#444444" withAlpha:1].CGColor;
    self.layer.borderWidth = 0.5;
    self.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _columnHeight)];
    titleLabel.text = @"定位信息";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    //经度Label
    _longitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _columnHeight, _viewWidth, _columnHeight)];
    _longitudeLabel.text = @"经度：--";
    _longitudeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_longitudeLabel];
    
    //纬度Label
    _latitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _columnHeight*2, _viewWidth, _columnHeight)];
    _latitudeLabel.text = @"纬度：--";
    _latitudeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_latitudeLabel];
    
    //海拔Label
    _atitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _columnHeight*3, _viewWidth, _columnHeight)];
    _atitudeLabel.text = @"海拔：--";
    _atitudeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_atitudeLabel];
    
    
    //省份Label
    _provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _columnHeight*4, _viewWidth, _columnHeight)];
    _provinceLabel.text = @"省份：--";
    _provinceLabel.textColor = [UIColor whiteColor];
    [self addSubview:_provinceLabel];
    
    //城市Label
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _columnHeight*5, _viewWidth, _columnHeight)];
    _cityLabel.text = @"城市：--";
    _cityLabel.textColor = [UIColor whiteColor];
    [self addSubview:_cityLabel];
    
    //街道Label
    _streetLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _columnHeight*6, _viewWidth, _columnHeight)];
    _streetLabel.text = @"街道：--";
    _streetLabel.textColor = [UIColor whiteColor];
    [self addSubview:_streetLabel];
    

}

- (void)drawRect:(CGRect)rect {
    //创建图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 1; i <= 6; i ++ ) {
        //设置路径
        CGContextMoveToPoint(context, 0, _columnHeight*i);
    
        CGContextAddLineToPoint(context, _viewWidth, _columnHeight*i);
        //设置线条宽度
        CGContextSetLineWidth(context, 0.5);
        [[UIColor colorWithHexString:@"#444444" withAlpha:1] setStroke];
        //画线
        CGContextDrawPath(context, kCGPathFillStroke);
    }

}


- (void)setCoordinateInfo:(CLLocationCoordinate2D)coordinate altitude:(CLLocationDistance)altitude
{
    _longitudeLabel.text = [NSString stringWithFormat:@"经度： 东经 %.2f°",coordinate.longitude];
    _latitudeLabel.text = [NSString stringWithFormat:@"纬度： 北纬 %.2f°",coordinate.latitude];
    _atitudeLabel.text = [NSString stringWithFormat:@"海拔： %.2f米",altitude];
}

- (void)setProvince:(NSString *)province City:(NSString *)city Street:(NSString *)street
{
    _provinceLabel.text = [NSString stringWithFormat:@"省份： %@",province];
    _cityLabel.text = [NSString stringWithFormat:@"城市： %@",city];
    
    NSString *detailAddress = [[street componentsSeparatedByString:city] lastObject];
    
    _streetLabel.text = [NSString stringWithFormat:@"街道： %@",detailAddress];

}


@end
