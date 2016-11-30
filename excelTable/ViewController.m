//
//  ViewController.m
//  excelTable
//
//  Created by 陈晋添 on 2016/11/28.
//  Copyright © 2016年 陈晋添. All rights reserved.
//

#import "ViewController.h"
#import "CJTExcelTableView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CJTExcelTableView *excel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    excel  =   [[CJTExcelTableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20) AndTextArr:@[@"标题1",@"标题2",@"标题3",@"标题4"]];
    excel.tableView.delegate    =   self;
    excel.tableView.dataSource  =   self;
    excel.showSeparatorLine =   None;
    excel.showBottomLine =   None;
    [self.view addSubview:excel];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell   =   [excel cellForRowTextArr:@[@"内容1",@"内容2",@"内容3",@"内容4"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
@end
