//
//  LoginViewController.m
//  ThirdLibraryUse
//
//  Created by 史练练 on 16/3/9.
//  Copyright © 2016年 史练练. All rights reserved.
//


#import "LoginViewController.h"
#import <ReactiveCocoa.h>

static NSTimeInterval const kAFViewShakerDefaultDuration = 0.5;
static NSString * const kAFViewShakerAnimationKey = @"kAFViewShakerAnimationKey";

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *accountTF; //账号
@property (nonatomic, strong) UITextField *passwordTF;  // 密码
@property (nonatomic, strong) UIButton    *loginBtn;    // 登陆按钮

@property (nonatomic, assign) BOOL accountIsValid;
@property (nonatomic, assign) BOOL passWordIsValid;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"Login";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initSubViews];
    
    // 
    [[self.accountTF.rac_textSignal filter:^BOOL(id value) {
        
        NSString *text  = value;
        return text.length > 3;
        
    }] subscribeNext:^(id x) {
        
         NSLog(@"%@", x);
    }];
    
}

#pragma mark  - 视图创建
- (void)initSubViews{

    _accountTF = [[UITextField alloc] init];
    _accountTF.placeholder     = @"用户名至少三位";
    _accountTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    _accountTF.layer.borderWidth = 1;
    _accountTF.layer.cornerRadius = 5;
    _accountTF.textColor = [UIColor whiteColor];
    _accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountTF.delegate        = self;

    [self.view addSubview:_accountTF];
    
    [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
                    make.top.equalTo(self.view.mas_top).with.offset(160);
                    make.left.equalTo(self.view.mas_left).with.offset(55);
                    make.right.equalTo(self.view.mas_right).with.offset(- 55);
                    make.height.mas_equalTo(@45);

    }];
    

    _passwordTF = [[UITextField alloc] init];
    _passwordTF.placeholder     = @"密码至少六位";
    _passwordTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    _passwordTF.layer.borderWidth = 1;
    _passwordTF.layer.cornerRadius = 5;
    _passwordTF.textColor = [UIColor whiteColor];
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTF.delegate        = self;
    [self.view addSubview:_passwordTF];
    
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_accountTF.mas_bottom).with.offset(25);
        make.centerX.equalTo(_accountTF.mas_centerX);
        make.width.equalTo(_accountTF);
        make.height.mas_equalTo(@45);
      
    }];
    
    _loginBtn = [[UIButton alloc] init];
    _loginBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    _loginBtn.layer.borderWidth = 1;
    _loginBtn.layer.cornerRadius = 5;
    self.loginBtn.enabled = NO;
    [_loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [_loginBtn setTintColor:[UIColor whiteColor]];
    [_loginBtn addTarget:self
                  action:@selector(checkForLogin)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_passwordTF.mas_bottom).with.offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(_passwordTF.mas_left).with.offset(35);
        make.right.equalTo(_passwordTF.mas_right).with.offset(- 35);
        /**
         *      equalTo 和 mas_equalTo的区别？
                mas_equalTo只是对其参数进行了一个BOX操作(装箱) MASBoxValue的定义具体可以看看源代码 太长就不贴出来了
                所支持的类型 除了NSNumber支持的那些数值类型之外 就只支持CGPoint CGSize UIEdgeInsets
         */

        make.height.mas_equalTo(@35);
    }];
    
}

#pragma mark 信息监测 登陆
- (void)checkForLogin{
    
        if (self.accountIsValid && self.passWordIsValid) {
            
            [self addShakeAnimationForView:_loginBtn
                              withDuration:kAFViewShakerDefaultDuration];
        }
    [self.view layoutIfNeeded];
}

/** 输入框 按钮UI的更改 */
- (void)updateUIState:(UITextField *)TF :(BOOL)flag{
  
    TF.backgroundColor = flag? [UIColor clearColor] : [UIColor redColor];
    if (!flag) {
        
        [self addShakeAnimationForView:TF withDuration:kAFViewShakerDefaultDuration];
    }

    self.loginBtn.enabled = self.accountIsValid && self.passWordIsValid;
    self.loginBtn.backgroundColor = self.loginBtn.enabled? [UIColor redColor]:[UIColor clearColor];

}


- (void)usernameTextFieldChanged {
    
    self.accountIsValid = [self isValidAccount:self.accountTF.text];
    
    [self updateUIState:_accountTF :self.accountIsValid];
}

- (void)passwordTextFieldChanged {
    
    self.passWordIsValid = [self isValidPassword:self.passwordTF.text];
    
    [self updateUIState:_passwordTF :self.passWordIsValid];
}

/** 用户名 密码的正则判断需求*/
- (BOOL)isValidAccount:(NSString *)account{
 
    return account.length >= 3;
}

- (BOOL)isValidPassword:(NSString *)pwd{

    return pwd.length >= 6;
}

- (void)addShakeAnimationForView:(UIView *)view withDuration:(NSTimeInterval)duration {
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat currentTx = view.transform.tx;
    
    animation.delegate = self;
    animation.duration = duration;
    animation.values = @[ @(currentTx), @(currentTx + 10), @(currentTx-8), @(currentTx + 8), @(currentTx -5), @(currentTx + 5), @(currentTx) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:kAFViewShakerAnimationKey];
}

#pragma mark - UITextFieldDelegate 实现键盘出现 视图上移部分 方便输入文本框

//在UITextField 编辑之前调用方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.20];
    [UIView setAnimationBeginsFromCurrentState: YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 35, self.view.frame.size.width, self.view.frame.size.height);
    //设置动画结束
    [UIView commitAnimations];
}
//在UITextField 编辑完成调用方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _accountTF) {
        [self usernameTextFieldChanged];
    }else if(textField == _passwordTF){
    
        [self passwordTextFieldChanged];
    }
    
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.20];
    [UIView setAnimationBeginsFromCurrentState: YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 35, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    return YES;
}

// 点击空白处移除键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    [self.view endEditing:YES];
}

- (void)dealloc
{

}

@end
