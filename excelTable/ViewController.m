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
    
    excel  =   [[CJTExcelTableView alloc] initWithFrame:self.view.bounds AndTextArr:@[@"1",@"2",@"3",@"4"]];
    excel.tableView.delegate    =   self;
    excel.tableView.dataSource  =   self;
    excel.showSeparatorLine =   titleAndRow;
    excel.showBottomLine =   titleAndRow;
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
    UITableViewCell *cell   =   [excel cellForRowTextArr:@[@"2",@"2",@"3",@"4"]];
    return cell;
}
@end
