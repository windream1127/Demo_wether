//
//  WDMDailyForecast.m
//  Demo_wether
//
//  Created by Windream on 14-7-16.
//  Copyright (c) 2014年 Windream. All rights reserved.
//

#import "WDMDailyForecast.h"

@implementation WDMDailyForecast

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *paths = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    paths[@"tempHigh"] = @"temp.max";
    paths[@"tempLow"] = @"temp.min";
    return paths;
}

@end
