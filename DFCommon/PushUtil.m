//
//  PushUtil.m
//  RongziTong
//
//  Created by HouHoward on 2017/1/13.
//  Copyright © 2017年 rongzi. All rights reserved.
//

#import "PushUtil.h"
#import "UMessage.h"

@implementation PushUtil

+ (void)pushWithAppKey:(NSString *) appKey andLaunchOptions:(NSDictionary *)launchOptions{
    
    //消息推送功能
    [UMessage startWithAppkey:appKey launchOptions:launchOptions httpsenable:YES];
    
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
#ifdef DEBUG
    //Log消息推送功能
    [UMessage setLogEnabled:YES];
#endif
    
    //#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    //    if( iOS8){
    //        //register remoteNotification types
    //        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    //        action1.identifier = @"action1_identifier";
    //        action1.title=@"Accept";
    //        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    //
    //        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
    //        action2.identifier = @"action2_identifier";
    //        action2.title=@"Reject";
    //        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    //        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    //        action2.destructive = YES;
    //
    //        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    //        categorys.identifier = @"category1";//这组动作的唯一标示
    //        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
    
    //        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObject:categorys]];
    //
    //        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
    
    //    }
    //    else{
    //        //register remoteNotification types
    //        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert];
    //    }
    //#else
    //    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert];
    //#endif
}

+(void)registerDeviceToken:(NSData *)deviceToken{
    
    [UMessage registerDeviceToken:deviceToken];
}

+(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    [UMessage setAutoAlert:YES];
    [UMessage didReceiveRemoteNotification:userInfo];
}

+(void)addAlias:(NSString *)alias type:(NSString *) type{
    if (!type || type.length == 0) {
        type = @"all";
    }
    [UMessage addAlias: alias type: type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        
    }];
}

+(void)removeAlias:(NSString *) alias type:(NSString *) type{
    if (!type || type.length == 0) {
        type = @"all";
    }
    [UMessage removeAlias: alias type: type response:^(id responseObject, NSError *error) {
        
    }];
}

+ (void)addTag:(NSString*)tag {
    [UMessage addTag:tag response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
        
    }];
}

+ (void)removeTag:(NSString*)tag {
    [UMessage removeTag:tag response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
        
    }];
}

+ (void)removeAllTags {
    [UMessage removeAllTags:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
        
    }];
}

@end
