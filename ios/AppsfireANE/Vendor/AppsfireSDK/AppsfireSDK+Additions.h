/*!
 *  @header    AppsfireAdSDK+Additions.h
 *  @abstract  Appsfire Advertising SDK Additions Header
 *  @version   2.2.0
 */

#import "AppsfireSDK.h"

@interface AppsfireSDK (Additions)

/*!
 *  @brief Register the push token for APNS (Apple Push Notification Service).
 *
 *  @note You should call this method in the "application:didRegisterForRemoteNotificationsWithDeviceToken:" method in your application delegate.
 *
 *  @param deviceToken NSString representation of the push token.
 */
+ (void)registerPushTokenString:(NSString *)deviceTokenString;

@end
