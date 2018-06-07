//
//  LoginSucessViewController.m
//  TouchIDORFaceID
//
//  Created by chc on 2018/6/7.
//  Copyright © 2018年 chc. All rights reserved.
//

#import "LoginSucessViewController.h"
#import "MBSTouchID.h"

@interface LoginSucessViewController ()

@end

@implementation LoginSucessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 100, 150, 30)];
    myLabel.text = @"登录成功！";
    myLabel.textColor = [UIColor redColor];
    [self.view addSubview:myLabel];
    
    
    
    // 退出
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setFrame:CGRectMake(120, 300, 100, 50)];
    exitBtn.backgroundColor = [UIColor greenColor];
    [exitBtn setTitle:@"退出" forState:UIControlStateNormal];
    [self.view addSubview:exitBtn];
    
    [exitBtn addTarget:self action:@selector(exitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

- (void)exitClick:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// 指纹设置关闭方法
- (void)openTouchID{
    
    [[MBSTouchID shareTouchID] deviceHasTouchID:^(BOOL isSucessed) {
        
        if (isSucessed) {
            
            [[MBSTouchID shareTouchID] closeEvaluatePolicyreply:^(BOOL isSucessed) {
                
                if (isSucessed) {
                    NSLog(@"关闭成功");
                }
                else{
                  
                    NSLog(@"关闭失败");
                }
            }];
            
        }
        else{
            NSLog(@"不支持指纹or面容");
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
