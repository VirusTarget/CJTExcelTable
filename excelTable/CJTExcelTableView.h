//
//  CJTExcelTableView.h
//  ExcelTable
//
//  Created by chenjintian on 16/11/22.
//  Copyright © 2016年 CJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJTExcelTableView : UIView

typedef NS_ENUM(NSInteger,separatorStyle) {
    titleOnly   =   1,
    rowOnly     =   2,
    titleAndRow =   3,
    None        =   4
};

@property (nonatomic, strong) UIView    *titleView;

@property (nonatomic, strong) UITableView    *tableView;

@property (nonatomic, assign) separatorStyle showSeparatorLine;

@property (nonatomic, assign) separatorStyle showBottomLine;

/**
 初始化

 @param frame table尺寸
 @param textArray 标题文字
 */
- (instancetype)initWithFrame:(CGRect)frame AndTextArr:(NSArray *)textArray;

/**
 设置标题文字（View）
 */
- (void)titleArrWithViewArr:(NSArray *)textArray;

/**
 设置标题文字（文字）
 */
- (void)titleArrWithTextArr:(NSArray *)textArray;

/**
 修改宽度（固定宽度）
 */
- (void)excelWidthWithWidthArr:(NSArray *)widthArr;

/**
 修改宽度（与table的比例）
 */
- (void)excelWidthWithRatioArr:(NSArray *)rationArr;

/**
 返回行cell（行内容文字）
 */
- (UITableViewCell *)cellForRowTextArr:(NSArray *)array;

/**
 返回行cell (行view内容)
 */
- (UITableViewCell *)cellForRowLabelArr:(NSArray *)array;
/**
 标题高度
 */
- (void)heightOfTitle:(double)height;

@end
