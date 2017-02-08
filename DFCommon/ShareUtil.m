//
//  ShareUtil.m
//  RongziTong
//
//  Created by HouHoward on 2017/1/12.
//  Copyright © 2017年 rongzi. All rights reserved.
//

#import "ShareUtil.h"

#import <UMSocialCore/UMSocialCore.h>

@implementation ShareUtil

+ (void) shareWithAppKey:(NSString *) appKey{

    #ifdef DEBUG
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    #endif
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey: appKey];
}

+ (void)setPlaform:(SharePlateform)plateform appKey:(NSString *)appKey appSecret:(NSString *)appSecret{
    switch (plateform) {
        case SharePlateformSina:
            //设置新浪的appKey和appSecret
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey: appKey appSecret: appSecret redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
            break;
            
        case SharePlateformWeChatSession:
        case SharePlateformWeChatTimeline:
            //设置微信的appKey和appSecret
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey: appKey appSecret: appSecret redirectURL:@"http://mobile.umeng.com/social"];
          
        case SharePlateformQQ:
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey: appKey appSecret: appSecret redirectURL:@"http://mobile.umeng.com/social"];
            break;
        default:
            break;
    }
}


+(BOOL)handleOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

+(void)shareToPlateform:(SharePlateform) plateform controller:(UIViewController *)controller shareImage:(UIImage *)image completion:(void (^)(NSError *error)) completion{
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //创建分享消息对象
    UMShareImageObject *imageObject = [[UMShareImageObject alloc] init];
    imageObject.shareImage = image;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = imageObject;
    
    [self shareToPlateform: plateform controller:controller messageObject:messageObject completion:completion];

}

+(void)shareToPlateform:(SharePlateform) plateform controller:(UIViewController *)controller title:(NSString *) title text:(NSString *)text url:(NSString *) url thumbImage:(UIImage *)image completion:(void (^)(NSError *error)) completion{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *webpageObject = [UMShareWebpageObject shareObjectWithTitle: title descr: text thumImage: image];
    //设置网页地址
    webpageObject.webpageUrl = url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = webpageObject;
    
    if (plateform == SharePlateformSina) {
        messageObject.title = title;
        messageObject.text = text; // [NSString stringWithFormat:@"[%@]%@%@", title, text, url];
    }
    
    [self shareToPlateform: plateform controller:controller messageObject:messageObject completion:completion];
}

+(void) shareToPlateform:(SharePlateform)plateform controller:(UIViewController *)controller messageObject:(UMSocialMessageObject *) messageObject completion:(void (^)(NSError *))completion{
    UMSocialPlatformType type;
    
    switch (plateform) {
        case SharePlateformSina:{
            type = UMSocialPlatformType_Sina;
            break;
        }
        case SharePlateformWeChatSession:{
            type = UMSocialPlatformType_WechatSession;
            
            break;
        }
        case SharePlateformWeChatTimeline:{
            type = UMSocialPlatformType_WechatTimeLine;
            
            break;
        }
        case SharePlateformQQ:{
            type = UMSocialPlatformType_QQ;
            
            break;
        }
        default:
            break;
    }
    
    [[UMSocialManager defaultManager] shareToPlatform: type messageObject:messageObject currentViewController: controller completion:^(id result, NSError *error) {
        
        if (completion) {
            completion(error);
        }
    }];
}
@end
