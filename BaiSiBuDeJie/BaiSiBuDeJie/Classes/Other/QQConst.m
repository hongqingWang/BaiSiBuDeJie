#import <UIKit/UIKit.h>

/**************************************** URL ****************************************/
/// 通用 URL
NSString * const QQCommonURL = @"http://api.budejie.com/api/api_open.php";
/// 推荐
NSString * const QQRecommendURL = @"http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.5.9/";
/// 视频
NSString * const QQVideoURL = @"http://s.budejie.com/topic/list/jingxuan/41/bs0315-iphone-4.5.9/";
/// 图片
NSString * const QQPictureURL = @"http://s.budejie.com/topic/list/jingxuan/10/bs0315-iphone-4.5.9/";
/// 笑话
NSString * const QQWordURL = @"http://s.budejie.com/topic/tag-topic/63674/hot/bs0315-iphone-4.5.9/";
/// 排行
NSString * const QQRankURL = @"http://s.budejie.com/topic/list/remen/1/bs0315-iphone-4.5.9/";

/// 标题栏高度
CGFloat const QQTitlesViewHeight = 35;
/// TabBar 高度
CGFloat const QQTabBarHeight = 49;
/// Navigation 最大Y值
CGFloat const QQNavigationMaxY = 64;
/// Margin
CGFloat const QQMargin = 10;
/// 内容字体大小
CGFloat const QQContentTextFontSize = 16;

/// TabBarButton 被重复点击的通知
NSString * const QQTabBarButtonDidRepeatClickNotification = @"QQTabBarButtonDidRepeatClickNotification";
/// TitleButton 被重复点击的通知
NSString * const QQTitlerButtonDidRepeatClickNotification = @"QQTitlerButtonDidRepeatClickNotification";
