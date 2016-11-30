//
//  CJTExcelTableView.m
//  ExcelTable
//
//  Created by chenjintian on 16/11/22.
//  Copyright © 2016年 CJT. All rights reserved.
//

#import "CJTExcelTableView.h"

#define lineTag 11111
@interface CJTExcelTableView ()
{
    NSArray *_widthArr;
    double _height;
}
@property (nonatomic, strong) NSArray   *titleLabels;//头部label数组
@end
@implementation CJTExcelTableView

#pragma mark-   初始化
- (instancetype)initWithFrame:(CGRect)frame AndTextArr:(NSArray *)textArray {
    if (self = [super initWithFrame:frame]) {
        NSMutableArray  *array  =   [NSMutableArray array];
        double titleWidth   =   CGRectGetWidth(frame)/textArray.count;
        _height  =   44;
        NSMutableArray  *widtharr   =   [NSMutableArray array];
        for (int i=0; i<textArray.count; i++) {
            UILabel *label  =   [[UILabel alloc] initWithFrame:CGRectMake(i*titleWidth, 0, titleWidth, 44)];
            label.text  =   textArray[i];
            label.textAlignment =   NSTextAlignmentCenter;
            [array addObject:label];
            [widtharr addObject:@(titleWidth)];
            [self.titleView addSubview:label];
        }
        _widthArr   =   widtharr;
        self.titleLabels    =   array;
    }
    return self;
}

#pragma mark   列宽度设置
- (void)excelWidthWithWidthArr:(NSArray *)widthArr {
    _widthArr    =   widthArr;
    [self setuptitleLabelFrame];
}

- (void)excelWidthWithRatioArr:(NSArray *)rationArr {
    NSMutableArray *widtharr  =   [NSMutableArray array];
    for (int i=0; i<rationArr.count; i++) {
        double width    =   [rationArr[i] doubleValue]*CGRectGetWidth(self.frame);
        [widtharr addObject:@(width)];
    }
    _widthArr   =   widtharr;
    [self setuptitleLabelFrame];
}
#pragma mark-   标题设置
#pragma mark   标题内容
- (void)titleArrWithTextArr:(NSArray *)textArray {
    NSMutableArray  *array  =   [NSMutableArray array];
    double titleWidth   =   CGRectGetWidth(self.frame)/textArray.count;
    for (int i=0; i<textArray.count; i++) {
        UILabel *label  =   [[UILabel alloc] initWithFrame:CGRectMake(i*titleWidth, 0, titleWidth, 44)];
        label.text  =   textArray[i];
        label.textAlignment =   NSTextAlignmentCenter;
        [array addObject:label];
        [self.titleView addSubview:label];
    }
    if (!_widthArr) {
        NSMutableArray  *widthArray  =  [NSMutableArray array];
        for (int i=0; i<textArray.count; i++) {
            [widthArray addObject:@(titleWidth)];
        }
        _widthArr   =   widthArray;
    }
    self.titleLabels    =   array;
    [self setuptitleLabelFrame];
}

- (void)titleArrWithViewArr:(NSArray *)textArray {
    NSMutableArray  *array  =   [NSMutableArray array];
    double titleWidth   =   CGRectGetWidth(self.frame)/textArray.count;
    for (int i=0; i<textArray.count; i++) {
        UIView *label =   textArray[i];
        label.frame =   CGRectMake(i*titleWidth, 0, titleWidth, 44);
        [self.titleView addSubview:label];
        [array addObject:label];
    }
    if (!_widthArr) {
        NSMutableArray  *widthArray  =  [NSMutableArray array];
        for (int i=0; i<textArray.count; i++) {
            [widthArray addObject:@(titleWidth)];
        }
        _widthArr   =   widthArray;
    }
    self.titleLabels    =   array;
    [self setuptitleLabelFrame];
}

#pragma mark   标题高度设置
- (void)heightOfTitle:(double)height{
    _height  =   height;
    [self setuptitleLabelFrame];
}

#pragma mark   标题尺寸设置
- (void)setuptitleLabelFrame {
    if (self.titleView) {
        if (!_height || _height ==0) {
            _height  =   44;
        }
        
        //重新设置titleView的高度以及tableview的y轴值与高度
        CGRect titleViewRect    =   self.titleView.frame;
        titleViewRect.size.height   =   _height;
        self.titleView.frame    =   titleViewRect;
        
        CGRect tableViewRect    =   self.tableView.frame;
        tableViewRect.size.height   =   self.frame.size.height-_height;
        tableViewRect.origin.y      =   _height;
        self.tableView.frame    =   tableViewRect;
        
        double sum=0;
        for (int i=0; i<self.titleLabels.count; i++) {
            
            UILabel *title  =   self.titleLabels[i];
            CGRect rect     =   title.frame;
            rect.origin.x       =   sum;
            rect.size.height    =   _height;
            if (i>=_widthArr.count) {
                break;
            }
            else {
                rect.size.width =   [_widthArr[i] doubleValue];
                sum +=  [_widthArr[i] doubleValue];
                title.frame =   rect;
            }
            
            //设置分割线
            [self setupTitleSeparatorLine];
            
        }
        
        if (self.showBottomLine == titleOnly || self.showBottomLine == titleAndRow) {
            UIView *bottomLine   =   [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.titleView.frame)-1, CGRectGetWidth(self.titleView.frame), 1)];
            bottomLine.backgroundColor    =   [UIColor blackColor];
            [self.titleView addSubview:bottomLine];
        }
    }
}

#pragma mark   标题分割线设置
- (void)setupTitleSeparatorLine {
    if (!(self.showSeparatorLine == titleOnly || self.showSeparatorLine == titleAndRow)) {
        return;
    }
    for (int i=0; i<_widthArr.count-1; i++) {
        
        UILabel *title  =   self.titleLabels[i];
        
        UIView *line    =   [title viewWithTag:lineTag+i];
        [line removeFromSuperview];
        
        line   =   [[UIView alloc] initWithFrame:CGRectMake([_widthArr[i] doubleValue]-1, 0, 1, _height)];
        line.backgroundColor    =   [UIColor blackColor];
        [title addSubview:line];
        line.tag   =   lineTag+i;
    }
}

#pragma mark-   每行内容格式化
#pragma mark   返回行内容
- (UITableViewCell *)cellForRowTextArr:(NSArray *)array {
    UITableViewCell *cell   =   [UITableViewCell new];
    UIView *rowView  =   [self setupExcelRowViewWithTextArr:array];
    [cell.contentView addSubview:rowView];
    return cell;
}

- (UITableViewCell *)cellForRowLabelArr:(NSArray *)array {
    UITableViewCell *cell   =   [UITableViewCell new];
    UIView *rowView  =   [self setupExcelRowViewWithViewArr:array];
    [cell.contentView addSubview:rowView];
    return cell;
}

#pragma mark   配置行内容与尺寸
- (UIView *)setupExcelRowViewWithTextArr:(NSArray *)array {
    double sum=0;
    UIView *rowView =   [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.tableView.rowHeight)];
    NSMutableArray *rowArray    =   [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        UILabel *rowLabel   =   [[UILabel alloc] initWithFrame:CGRectMake(sum, 0, [_widthArr[i] doubleValue], 45)];
        rowLabel.text       =   array[i];
        [rowView addSubview:rowLabel];
        rowLabel.textAlignment  =   NSTextAlignmentCenter;
        rowLabel.numberOfLines  =       0;
        rowLabel.lineBreakMode  =   NSLineBreakByCharWrapping;
        sum +=  [_widthArr[i] doubleValue];
        [rowArray addObject:rowLabel];
    }
    //设置分割线
    if (self.showSeparatorLine == rowOnly || self.showSeparatorLine == titleAndRow) {
        [self setupRowSeparatorLineWithRowArray:rowArray];
    }
    
    if (self.showBottomLine == rowOnly || self.showBottomLine == titleAndRow) {
        UIView *bottomLine   =   [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(rowView.frame)-1, CGRectGetWidth(rowView.frame), 1)];
        bottomLine.backgroundColor    =   [UIColor blackColor];
        
        [rowView addSubview:bottomLine];
    }
    return rowView;
}

- (UIView *)setupExcelRowViewWithViewArr:(NSArray *)array {
    double sum=0;
    UIView *rowView =   [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.tableView.rowHeight)];
    for (int i=0; i<array.count; i++) {
        UIView  *rowLabel   =   array[i];
        rowLabel.frame = CGRectMake(sum, 0, [_widthArr[i] doubleValue], 45);
        [rowView addSubview:rowLabel];
        sum +=  [_widthArr[i] doubleValue];
    }
    //设置分割线
    if (self.showSeparatorLine == rowOnly || self.showSeparatorLine == titleAndRow) {
        [self setupRowSeparatorLineWithRowArray:array];
    }
    
    //设置底部分割线
    if (self.showBottomLine == rowOnly || self.showBottomLine == titleAndRow) {
        UIView *bottomLine   =   [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(rowView.frame)-1, CGRectGetWidth(rowView.frame), 1)];
        bottomLine.backgroundColor    =   [UIColor blackColor];
        [rowView addSubview:bottomLine];
    }
    return rowView;
}

#pragma mark    设置行分割
- (void)setupRowSeparatorLineWithRowArray:(NSArray *)rowArray {
    
    for (int i=0; i<_widthArr.count-1; i++) {
        
        UILabel *rowLabel  =   rowArray[i];
        
        UIView *line   =   [[UIView alloc] initWithFrame:CGRectMake([_widthArr[i] doubleValue]-1, 0, 1, self.tableView.rowHeight)];
        
        line.backgroundColor    =   [UIColor blackColor];
        
        [rowLabel addSubview:line];
    }
}

#pragma mark-   懒加载
- (UIView *)titleView {
    if (!_titleView) {
        _titleView  =   [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        [self addSubview:_titleView];
    }
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView    =   [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44) style:1];
        _tableView.rowHeight    =   44;
        
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (void)setShowSeparatorLine:(separatorStyle)showSeparatorLine {
    _showSeparatorLine  =   showSeparatorLine;
    [self setupTitleSeparatorLine];
}

- (void)setShowBottomLine:(separatorStyle)showBottomLine {
    _showBottomLine =   showBottomLine;
    self.tableView.separatorStyle   =   UITableViewCellSeparatorStyleNone;
    [self setuptitleLabelFrame];
}
@end
