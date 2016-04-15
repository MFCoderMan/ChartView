//
//  ChartDefine.h
//  ChartDemo
//
//  Created by ZhangYunguang on 16/4/15.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#ifndef ChartDefine_h
#define ChartDefine_h


#define kChartBorderColer  [UIColor lightGrayColor].CGColor  //表格外框线颜色
#define kLineInsideColer   [UIColor lightGrayColor]          //表格内部线的颜色
#define kContentTitleColor [UIColor blackColor]              //表格内文字的颜色
#define kTopTitleColor     [UIColor blackColor]              //顶部标题文字颜色
#define kLeftTitleColor    [UIColor blackColor]              //左边标题文字颜色

static CGFloat   const kChartBorderLineWidth  = 1.0f;        //表格外宽线的宽度
static CGFloat   const kLeftItemWidth         = 100.0f;      //左边item宽度
static CGFloat   const kContentItemWidth      = 43.0f;       //表格内容item的宽度
static CGFloat   const kContentItemHeight     = 43.0f;       //表格内容item的高度
static CGFloat   const kTitleContentSeperateLineWidth = 0.5f;//表格左边标题与表格内容分界线的宽度
static CGFloat   const kContentLineWidth      = 0.25f;       //表格内容线的宽度
static CGFloat   const kChartCornerRadius     = 3.0f;        //表格外框的圆角
static CGFloat   const kLeftTitleFont         = 12.0f;       //左边title字体的大小
static CGFloat   const kTopTitleFont          = 10.0f;       //顶部title字体的大小
static CGFloat   const kContentTitleFont      = 10.0f;       //表格内容字体的大小
static NSString *const kLeftTableViewCellId   = @"leftTableViewCellId";
static NSString *const kContentCollectionId   = @"contentCollectionId";



#endif /* ChartDefine_h */
