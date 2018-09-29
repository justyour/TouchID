//
//  ViewController.m
//  touchIdTest
//
//  Created by kms on 16/11/18.
//  Copyright © 2016年 KMS. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
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
- (IBAction)touchIDButClick:(UIButton *)sender {
    
    LAContext *laContext = [[LAContext alloc] init];
    if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        laContext.localizedFallbackTitle = @"验证密码";
        [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Touch Id Test" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                
                NSLog(@"验证成功");
                
            }else{
            
                switch (error.code) {
                    case LAErrorUserCancel:
                        NSLog(@"用户取消");
                        break;
                    case LAErrorUserFallback:
                        NSLog(@"Authentication was canceled, because the user tapped the fallback button (Enter Password).");
                        break;
                    case LAErrorAuthenticationFailed:
                        NSLog(@"Authentication was not successful, because user failed to provide valid credentials.");
                        break;
                    case LAErrorSystemCancel:
                        NSLog(@"Authentication was canceled by system (e.g. another application went to foreground)");
                        break;
                    case LAErrorPasscodeNotSet:
                        NSLog(@"Authentication could not start, because passcode is not set on the device");
                        break;
                    case LAErrorTouchIDNotAvailable:
                        NSLog(@"Authentication could not start, because Touch ID is not available on the device");
                        break;
                    case LAErrorTouchIDNotEnrolled:
                      
                        NSLog(@"Authentication could not start, because Touch ID has no enrolled fingers.");
                        break;
                    default:
                        break;
                }
                 NSLog(@"%@==验证失败",error.description);
            }
            
        }];
        
    }else{
    
        NSLog(@"手机不支持Touch ID");
    }
}


@end
