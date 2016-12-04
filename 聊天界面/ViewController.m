//
//  ViewController.m
//  聊天界面
//
//  Created by  王伟 on 2016/12/4.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "ViewController.h"
#import "CustomerController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    [btn setTitle:@"进入界面" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(enterCustom) forControlEvents:UIControlEventTouchUpInside];
}

- (void) enterCustom {
    CustomerController *CV = [CustomerController new];
    [self.navigationController pushViewController:CV animated:YES];
}

@end
