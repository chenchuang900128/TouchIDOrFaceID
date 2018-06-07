//
//  ViewController.m
//  TouchIDORFaceID
//
//  Created by chc on 2018/6/7.
//  Copyright © 2018年 chc. All rights reserved.
//

#import "ViewController.h"
#import "LoginSucessViewController.h"
#import "MBSTouchID.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginBtnClick:(id)sender {

    // 先判断是否支持指纹，面容
    [[MBSTouchID shareTouchID] deviceHasTouchID:^(BOOL isSucessed) {
        
        if (isSucessed) {
            
            // 登录验证
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
    
    
    
}
@end
