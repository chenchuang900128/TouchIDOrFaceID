//
//  MBSTouchID.m
//  MBSiPhone
//
//  Created by llbt on 15/9/18.
//  Copyright (c) 2015年 China M-World Co.,Ltd. All rights reserved.
//

#import "MBSTouchID.h"
#import "LBXAlertAction.h"

@import UIKit;


@import LocalAuthentication;


@implementation MBSTouchID

#pragma mark 单例方法
+ (MBSTouchID *)shareTouchID {
    
    // 函数执行一次谓语
    static dispatch_once_t once;
    static MBSTouchID *touchID;
    // 单例创建
    dispatch_once(&once, ^ {
        touchID = [[self alloc] init];
    });
    return touchID;
    
}

#pragma mark 设备是否有指纹功能
-(void)deviceHasTouchID:(TouchIDOpen)touchIDOpenBlock{
    
    
    // 先判断系统级别iOS8  再判断设备是否支持64位
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
        
        if (touchIDOpenBlock) {
            touchIDOpenBlock(NO);
        }
    }
    else{
        
#if defined(__LP64__) && __LP64__
        if (touchIDOpenBlock) {
            touchIDOpenBlock(YES);
        }
#else
        if (touchIDOpenBlock) {
            touchIDOpenBlock(NO);
        }
#endif
        
    }
    
}


#pragma mark 开启指纹识别
- (void)openEvaluatePolicyreply:(TouchIDOpen)touchIDOpenBlock;
{
    NSError * authError = nil;
    NSString * reasionStr = @"通过Home键验证已有手机指纹";
    LAContext * context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"";
    if ([context respondsToSelector:@selector(maxBiometryFailures)]) {
        // 最大验证失败次数
        context.maxBiometryFailures = [NSNumber numberWithInteger:5];
    }
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
#if  1
        
        if (@available(iOS 11.0, *)) {
            if (context.biometryType == LABiometryTypeFaceID) {
                reasionStr = @"通过Home键验证已有手机面容";
            }
        }
#endif
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reasionStr reply:^(BOOL success, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (success) {
                    
                }
                else{
                    
                }
                if (touchIDOpenBlock) {
                    touchIDOpenBlock(success);
                }
                
                
            });
            
        }];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (touchIDOpenBlock) {
                touchIDOpenBlock(NO);
            }
            
#if  1
            
            if (@available(iOS 11.0, *)) {
                if (context.biometryType == LABiometryTypeFaceID) {
                    
                    [self alertWithFaceIDError:authError];
                    
                }
                else{
                    [self alertWithError:authError];
                }
            }
            else{
                [self alertWithError:authError];
                
            }
#else
            [self alertWithError:authError];
            
#endif
            
        });
    }
}



#pragma mark 指纹识别登录
- (void)touchIDLoginReply:(TouchIDAuth)TouchIDAuthBlock;
{
    NSError * authError = nil;
    NSString * reasionStr = @"通过Home键验证已有手机指纹";
    LAContext * context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"";
    if ([context respondsToSelector:@selector(maxBiometryFailures)]) {
        // 最大验证失败次数
        context.maxBiometryFailures = [NSNumber numberWithInteger:5];
    }
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
#if  1
        
        if (@available(iOS 11.0, *)) {
            if (context.biometryType == LABiometryTypeFaceID) {
                reasionStr = @"通过Home键验证已有手机面容";
            }
        }
#endif
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reasionStr reply:^(BOOL success, NSError *error) {
            
            NSLog(@"errorCode = %D",[error code]);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (success) {
                    
                    if (TouchIDAuthBlock) {
                        TouchIDAuthBlock(MBSTouchIDAuthSucess);
                    }
                }
                else{
                    
                    if (error.code == LAErrorAuthenticationFailed) {
                        
                        if (TouchIDAuthBlock) {
                            TouchIDAuthBlock(MBSTouchIDAuthFail);
                        }
                    }else if (error.code == LAErrorUserCancel){
                        
                        if (TouchIDAuthBlock) {
                            TouchIDAuthBlock(MBSTouchIDAuthCancle);
                        }
                        
                    }
                    else{
                        
                        if (TouchIDAuthBlock) {
                            TouchIDAuthBlock(MBSTouchIDAuthOther);
                        }
                    }
                }
                
            });
        }];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (TouchIDAuthBlock) {
                TouchIDAuthBlock(MBSTouchIDAuthOther);
            }
            
#if  1
            
            if (@available(iOS 11.0, *)) {
                if (context.biometryType == LABiometryTypeFaceID) {
                    
                    [self alertWithFaceIDError:authError];
                    
                }
                else{
                    [self alertWithError:authError];
                }
            }
            else{
                [self alertWithError:authError];
                
            }
#else
            [self alertWithError:authError];
            
#endif
        });
        
    }
    
}


#pragma mark 关闭指纹识别
- (void)closeEvaluatePolicyreply:(TouchIDOpen)touchIDOpenBlock;
{
    NSError * authError = nil;
    NSString * reasionStr = @"指纹登录关闭";
    LAContext * context = [[LAContext alloc] init];
    
    // 取消enter password按钮
    context.localizedFallbackTitle = @"";
    if ([context respondsToSelector:@selector(maxBiometryFailures)]) {
        // 最大验证失败次数
        context.maxBiometryFailures = [NSNumber numberWithInteger:5];
    }
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
#if  1
        
        if (@available(iOS 11.0, *)) {
            if (context.biometryType == LABiometryTypeFaceID) {
                reasionStr = @"面容登录关闭";
            }
        }
#endif
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reasionStr reply:^(BOOL success, NSError *error) {
            
            if (success) {
                
            }
            else{
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (touchIDOpenBlock) {
                    touchIDOpenBlock(success);
                }
            });
            
            
        }];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (touchIDOpenBlock) {
                touchIDOpenBlock(NO);
            }
            
#if  1
            
            if (@available(iOS 11.0, *)) {
                if (context.biometryType == LABiometryTypeFaceID) {
                    
                    [self alertWithFaceIDError:authError];
                    
                }
                else{
                    [self alertWithError:authError];
                }
            }
            else{
                [self alertWithError:authError];
                
            }
#else
            [self alertWithError:authError];
            
#endif
            
        });
    }
}

#pragma mark 弹出错误信息（默认指纹）
- (void)alertWithError:(NSError *)authError{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([authError code] == LAErrorPasscodeNotSet) {
            
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"您的设备未设置锁屏密码" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];

           
        }
        else if([authError code] == LAErrorTouchIDNotEnrolled){
            
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"您的设备未录入指纹" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
           
        }
        else if ([authError code] == LAErrorAuthenticationFailed){
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"指纹验证失败，请录入有效的指纹信息" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
           
        }
        else if ([authError code] == LAErrorTouchIDNotAvailable){
            
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"指纹信息在设备上不可用" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
            //            MBSAlertWithBlock(@"温馨提示", @"指纹信息在设备上不可用", nil, ^(id sender) {
            //
            //            });
        }
        else if ([authError code] == LAErrorTouchIDLockout){
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"指纹验证失败次数过多，指纹验证已锁定，请在iPhone手机－设置－Touch ID与密码中输入密码，即可解锁指纹验证" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
         
        }
        else{
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"指纹验证失败" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
            
        
        }
        
        
    });
    
}

#pragma mark 弹出面容错误信息
- (void)alertWithFaceIDError:(NSError *)authError{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([authError code] == LAErrorPasscodeNotSet) {
            
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"您的设备未设置锁屏密码" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
            
            
        }
        else if([authError code] == LAErrorTouchIDNotEnrolled){
            
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"您的设备未录入面容" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
            
        }
        else if ([authError code] == LAErrorAuthenticationFailed){
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"面容验证失败，请录入有效的面容信息" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
            
        }
        else if ([authError code] == LAErrorTouchIDNotAvailable){
            
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"面容信息在设备上不可用" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
           
        }
        else if ([authError code] == LAErrorTouchIDLockout){
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"面容验证失败次数过多，面容验证已锁定，请在iPhone手机－设置－Face ID与密码中输入密码，即可解锁面容验证" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
            
        }
        else{
            [LBXAlertAction showAlertWithTitle:@"温馨提示" msg:@"面容验证失败" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            }];
            
            
        }
        
        
    });
}


/*  keychain Touch id 支持指纹识别与锁屏密码 */

@end
