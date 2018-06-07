# TouchIDOrFaceID
简单易用, 实现并兼容iOS Touch ID以及FaceID验证，可以用于登录，

注意支持面容，首先需在info.plist中中添加
权限
    <key>NSFaceIDUsageDescription</key>
    <string>你的App需要您的允许,才能访问面容 ID</string>

使用方法：
引入头文件： #import "MBSTouchID.h"     
 
 
// 先判断是否支持指纹，面容
    [[MBSTouchID shareTouchID] deviceHasTouchID:^(BOOL isSucessed) {
        
        if (isSucessed) {
            
            // 调用生物识别验证
            [[MBSTouchID shareTouchID] touchIDLoginReply:^(MBSTouchIDAuthResult result) {
                
                if (result == MBSTouchIDAuthSucess) {
                    
                        LoginSucessViewController *sucessVC = [[LoginSucessViewController alloc] init];
                        [self presentViewController:sucessVC animated:YES completion:^{
                            
                        }];
                    
                }
                else if (result == MBSTouchIDAuthFail) {
                    
                    NSLog(@"验证失败");
                }
                else{
                    NSLog(@"验证取消");
                }
            }];
            
        }
        
    }];
