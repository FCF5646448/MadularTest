//
//  ViewController.m
//  TestUseFramework
//
//  Created by 冯才凡 on 2018/9/1.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

#import <BTCoreTestFramework/BTCoreTestFramework.h>
#import "ViewController.h"
#import "Test01ViewController.h"
#import "Test02ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor brownColor];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"jump01" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 100, 100)];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"jump02" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClicked2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 500, 100, 100)];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 setTitle:@"jump03" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClicked3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btnClicked1{
    Test01ViewController * vc = [[Test01ViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)btnClicked2{
    SwiftViewController * vc = [SwiftViewController new];
    [self presentViewController:vc animated:YES completion:nil];

}

- (void)btnClicked3 {
    Test02ViewController * vc = [Test02ViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
