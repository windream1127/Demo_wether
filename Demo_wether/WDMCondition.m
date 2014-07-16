//
//  WDMCondition.m
//  Demo_wether
//
//  Created by Windream on 14-7-16.
//  Copyright (c) 2014年 Windream. All rights reserved.
//

#import "WDMCondition.h"

@implementation WDMCondition

+ (NSDictionary *)imageMap {
    static NSDictionary *_imageMap = nil;
    if (! _imageMap) {
        _imageMap = @{
                      @"01d" : @"weather-clear",
                      @"02d" : @"weather-few",
                      @"03d" : @"weather-few",
                      @"04d" : @"weather-broken",
                      @"09d" : @"weather-shower",
                      @"10d" : @"weather-rain",
                      @"11d" : @"weather-tstorm",
                      @"13d" : @"weather-snow",
                      @"50d" : @"weather-mist",
                      @"01n" : @"weather-moon",
                      @"02n" : @"weather-few-night",
                      @"03n" : @"weather-few-night",
                      @"04n" : @"weather-broken",
                      @"09n" : @"weather-shower",
                      @"10n" : @"weather-rain-night",
                      @"11n" : @"weather-tstorm",
                      @"13n" : @"weather-snow",
                      @"50n" : @"weather-mist",
                      };
    }
    return _imageMap;
}

- (NSString *)imageName {
    return [WDMCondition imageMap][self.icon];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"date": @"dt",
             @"locationName": @"name",
             @"humidity": @"main.humidity",
             @"temperature": @"main.temp",
             @"tempHigh": @"main.temp_max",
             @"tempLow": @"main.temp_min",
             @"sunrise": @"sys.sunrise",
             @"sunset": @"sys.sunset",
             @"conditionDescription": @"weather.description",
             @"condition": @"weather.main",
             @"icon": @"weather.icon",
             @"windBearing": @"wind.deg",
             @"windSpeed": @"wind.speed",
             };
}

//#define MPS_TO_MPH 2.23694f
//
//+ (NSValueTransformer *)windSpeedJSONTransformer {
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num) {
//        return @(num.floatValue*MPS_TO_MPH);
//    } reverseBlock:^(NSNumber *speed) {
//        return @(speed.floatValue/MPS_TO_MPH);
//    }];
//}

#define DEG360  360.0f             //一圈的度数
#define DEG225  22.5f            //8个方向分割线的度数
+(NSValueTransformer *)windBearingJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num) {
        NSString *direction;
        CGFloat deg = num.floatValue;
        //北
        if (deg>DEG360-DEG225 || deg<=DEG225) {
            direction = @"北";
        }
        //东北
        else if (DEG225 < deg && deg<= 90 -DEG225){
            direction = @"东北";
        }
        //东
        else if (90 -DEG225 < deg && deg<= 90 +DEG225){
            direction = @"东";
        }
        //东南
        else if (90 +DEG225 < deg && deg <= 180 -DEG225){
            direction = @"东南";
        }
        //南
        else if (180 -DEG225 < deg && deg <= 180 + DEG225){
            direction = @"南";
        }
        //西南
        else if (180 + DEG225 < deg && deg <= 270 - DEG225){
            direction = @"西南";
        }
        //西
        else if (270 - DEG225 < deg && deg <= 270 + DEG225){
            direction = @"西";
        }
        //西北
        else if (270 + DEG225 < deg && deg <= DEG360-DEG225){
            direction = @"西北";
        }
        else{
            direction = @" ";
        }
        return direction;
    } reverseBlock:^(NSString *str) {
        
        
        return @(0);
    }];
}
+ (NSValueTransformer *)conditionDescriptionJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        return [values firstObject];
    } reverseBlock:^(NSString *str) {
        return @[str];
    }];
}

+ (NSValueTransformer *)conditionJSONTransformer {
    return [self conditionDescriptionJSONTransformer];
}

+ (NSValueTransformer *)iconJSONTransformer {
    return [self conditionDescriptionJSONTransformer];
}

+ (NSValueTransformer *)dateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
    } reverseBlock:^(NSDate *date) {
        return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    }];
}

+ (NSValueTransformer *)sunriseJSONTransformer {
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *)sunsetJSONTransformer {
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *)tempJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *Ftemp) {
        return @(5  *(Ftemp.floatValue - 32)/ 9);    // C=5/9(F-32)
    } reverseBlock:^(NSNumber *Ctemp) {
        return @(9 * Ctemp.floatValue/ 5 + 32 );    // F=9/5c+32
    }];
}

+ (NSValueTransformer *)temperatureJSONTransformer {
    return [self tempJSONTransformer];
}

+ (NSValueTransformer *)tempLowJSONTransformer {
    return [self tempJSONTransformer];
}

+ (NSValueTransformer *)tempHighJSONTransformer {
    return [self tempJSONTransformer];
}

@end
