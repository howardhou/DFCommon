//
//  StatisticUtil.m
//  RongziTong
//
//  Created by HouHoward on 11/30/15.
//  Copyright © 2015 rongzi. All rights reserved.
//

#import "StatisticUtil.h"
#import "TalkingData.h"
#import <UMMobClick/MobClick.h>

@implementation StatisticUtil

+(void) statisticWithUmengKey:(NSString *) umengKey{
    //统计分析功能
    UMAnalyticsConfig * config = [[UMAnalyticsConfig alloc] init];
    config.appKey = umengKey;
    config.ePolicy = BATCH;
    
#ifndef UMeng_Statistic
#define UMeng_Statistic
#endif
    
#ifdef DEBUG
    config.channelId = @"DEBUG";
    
    [MobClick startWithConfigure: config];
    [MobClick setAppVersion: @"Debug"];
    [MobClick setCrashReportEnabled:YES];
    [MobClick setLogEnabled:YES];
    
#elif AdHoc
    config.channelId = @"AdHoc";
    [MobClick startWithConfigure: config];
    [MobClick setAppVersion: @"AdHoc"];
    [MobClick setCrashReportEnabled:YES];
    
#else
    config.channelId = @"AppStore";
    [MobClick startWithConfigure: config];
    [MobClick setAppVersion: [self getAppVersion]];
    [MobClick setCrashReportEnabled:YES];
    
#endif
}

+(NSString *) getAppVersion {
    NSString *build_version_text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return build_version_text;
}

+(void)statisticWithTalkingDataKey:(NSString *)talkingDataKey{
   
#ifndef TalkingData_Statistic
#define TalkingData_Statistic
#endif
    
#ifdef DEBUG
    [TalkingData sessionStarted:talkingDataKey withChannelId:@"DEBUG"];
    [TalkingData setExceptionReportEnabled:YES];
#elif AdHoc
    
    [TalkingData sessionStarted:talkingDataKey withChannelId:@"AdHoc"];
    [TalkingData setExceptionReportEnabled:YES];
#else
    
    [TalkingData sessionStarted:talkingDataKey withChannelId:@"AppStore"];
    [TalkingData setExceptionReportEnabled:YES];
#endif
}


+(void) beginLogPage:(NSString *) name{
#ifdef TalkingData_Statistic
    [TalkingData trackPageBegin: name];
#endif
    
#ifdef UMeng_Statistic
    [MobClick beginLogPageView: name];
#endif
}

+(void) endLogPage:(NSString *) name{
    
#ifdef TalkingData_Statistic
    [TalkingData trackPageEnd: name];
#endif
    
#ifdef UMeng_Statistic
    [MobClick endLogPageView: name];
#endif

}


+(void) logEvent:(NSString *) eventId{

#ifdef TalkingData_Statistic
    [TalkingData trackEvent: eventId];
#endif
    
#ifdef UMeng_Statistic
    [MobClick event: eventId];
#endif

}

+(void) logEvent:(NSString *) eventId label:(NSString *) label{

#ifdef TalkingData_Statistic
    [TalkingData trackEvent: eventId label: label];
#endif
    
#ifdef UMeng_Statistic
    [MobClick event:eventId label: label];
#endif

}

@end
