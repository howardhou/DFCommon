//
//  ShareUtil.h
//  RongziTong
//
//  Created by HouHoward on 2017/1/12.
//  Copyright © 2017年 rongzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SharePlateform){
    SharePlateformSina = 0,         //Sina微博
    SharePlateformWeChatSession,  //微信聊天
    SharePlateformWeChatTimeline, //朋友圈
    SharePlateformQQ    //QQ
};

/**
 * 封装了Umeng分享，目前支持 微信，新浪微博，QQ；目的是避免UMeng API改变时，导致项目不必要的修改，，也为了统一不同APP 针对远程推送的处理
 * 如果只需要使用微信分享，则不需要将新浪微博和QQ分享的SDK添加到项目中，这样APP打包的时候就不会带上这部分的SDK
 * 具体项目如何配置，请看Umeng文档：http://dev.umeng.com/social/ios/operation
 */
@interface ShareUtil : NSObject

/**
 初始化分享，目前只支持 Umeng Share

 @param appKey Umeng App Key
 */
+ (void) shareWithAppKey:(NSString *) appKey;

/**
 设置支持的共享平台，目前只支持 Sina，微信，QQ，支持的平台，在 SharePlateform 枚举中有定义

 @param plateform 社交平台，关于微信的两个平台 SharePlateformWeChatSession 和 SharePlateformWeChatTimeline 只需要设置 SharePlateformWeChatSession
 @param appKey 社交平台的app key, 如：sina app key
 @param appSecret 社交平台的app secret, 如：sina app secret
 */
+ (void) setPlaform: (SharePlateform) plateform appKey: (NSString *) appKey appSecret: (NSString *)appSecret;

/**
 处理打开URL

 @param url URL
 @return 是否成功
 */
+ (BOOL) handleOpenURL:(NSURL *) url;


/**
 图片分享

 @param plateform 社交平台
 @param controller 控制器
 @param image 被分享的图片
 @param completion 分享完成 Block
 */
+(void)shareToPlateform:(SharePlateform) plateform controller:(UIViewController *)controller shareImage:(UIImage *)image completion:(void (^)(NSError *error)) completion;

/**
 网页分享，新浪微博使用的是文字分享

 @param plateform 社交平台
 @param controller 控制器
 @param title 分享标题
 @param text 分享文本
 @param url 分享URL
 @param completion 分享完成 Block
 */
+ (void)shareToPlateform:(SharePlateform) plateform controller:(UIViewController *)controller title:(NSString *) title text:(NSString *)text url:(NSString *) url thumbImage:(UIImage *)image completion:(void (^)(NSError *error)) completion;
@end
