//
//  MBSTouchID.h
//  MBSiPhone
//
//  Created by llbt on 15/9/18.
//  Copyright (c) 2015年 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MBSTouchIDAuthSucess,
    MBSTouchIDAuthFail,
    MBSTouchIDAuthCancle,
    MBSTouchIDAuthOther,
    
} MBSTouchIDAuthResult;



typedef void(^TouchIDOpen)(BOOL isSucessed);
typedef void(^TouchIDAuth)(MBSTouchIDAuthResult result);


@interface MBSTouchID : NSObject

+ (MBSTouchID *)shareTouchID;
// 设备是否有指纹功能
- (void)deviceHasTouchID:(TouchIDOpen)touchIDOpenBlock;
// 开启指纹识别
- (void)openEvaluatePolicyreply:(TouchIDOpen)touchIDOpenBlock;
// 关闭指纹识别
- (void)closeEvaluatePolicyreply:(TouchIDOpen)touchIDCloseBlock;
// 指纹登录
- (void)touchIDLoginReply:(TouchIDAuth)TouchIDAuthBlock;

@end
