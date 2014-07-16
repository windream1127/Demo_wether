//
//  WDMManager.h
//  Demo_wether
//
//  Created by Windream on 14-7-16.
//  Copyright (c) 2014年 Windream. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Foundation;
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import "WDMCondition.h"
@interface WDMManager : NSObject<CLLocationManagerDelegate>

+ (instancetype)sharedManager;

@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) WDMCondition *currentCondition;
@property (nonatomic, strong, readonly) NSArray *hourlyForecast;
@property (nonatomic, strong, readonly) NSArray *dailyForecast;

- (void)findCurrentLocation;

@end
