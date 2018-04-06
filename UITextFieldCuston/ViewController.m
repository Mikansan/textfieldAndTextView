//
//  ViewController.m
//  UITextFieldCuston
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 KaoLaMall. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Custon.h"
#import "UITextView+Custom.h"
@interface ViewController ()<UITextViewDelegate,UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake(10, 100, 300, 180)];
//    text.font=[UIFont systemFontOfSize:20];
    text.backgroundColor=[UIColor yellowColor];
    text.placehloderColor=[UIColor redColor];
    text.placehloder=@"palcehloder";
    text.delegate=self;
    [self.view addSubview:text];
    
    UITextField *field=[[UITextField alloc]initWithFrame:CGRectMake(10, 300, 300, 40)];
    field.borderStyle=UITextBorderStyleRoundedRect;
    field.delegate=self;
    field.space=20;
    field.placeholder=@"palcehloder";
    field.placehloderFont=10;
    field.placehloderColor=[UIColor redColor];
    [self.view addSubview:field];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
