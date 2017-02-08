//
//  StatisticUtil.h
//  RongziTong
//
//  Created by HouHoward on 11/30/15.
//  Copyright © 2015 rongzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticUtil : NSObject

+(void) statisticWithUmengKey:(NSString *) umengKey;

+(void) statisticWithTalkingDataKey:(NSString *) talkingDataKey;

+(void) logEvent:(NSString *) eventId;
+(void) logEvent:(NSString *) eventId label:(NSString *) label;

+(void) beginLogPage:(NSString *) name;
+(void) endLogPage:(NSString *) name;
@end
