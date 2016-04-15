//
//  ChartView.h
//  ChartDemo
//
//  Created by ZhangYunguang on 16/4/14.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth      [[UIScreen mainScreen] bounds].size.width
#define kscreenHeight     [[UIScreen mainScreen] bounds].size.height


@protocol ChartDelegate;

@interface ChartView : UIView

@property (nonatomic, assign) id<ChartDelegate>delegate;
/**
 *  表格内容全是图片
 *
 *  @param frame      表格的frame
 *  @param leftTitles 左边title数组
 *  @param topTitles  顶部title数组
 *  @param allImages  图片数组，直接放图片的名字即可（但是，图片名字的个数不能少于表格的个数，否则会崩溃）
 *
 *  @return ChartView对象
 */
-(instancetype)initWithFrame:(CGRect)frame leftTitles:(NSArray *)leftTitles topTitles:(NSArray *)topTitles itemAllImageDatas:(NSArray *)allImages;
/**
 *  表格内容全是文字
 *
 *  @param frame      表格的frame
 *  @param leftTitles 左边title数组
 *  @param topTitles  顶部title数组
 *  @param allTitles  文字数组，直接放需要展示的文字（文字的个数同样不能少于表格的个数，否则会崩溃）
 *
 *  @return ChartView对象
 */
-(instancetype)initWithFrame:(CGRect)frame leftTitles:(NSArray *)leftTitles topTitles:(NSArray *)topTitles itemAllTitleDatas:(NSArray *)allTitles;
/**
 *  表格中只有特定的几个表格是图片，其他item为空
 *
 *  @param frame      表格的frame
 *  @param leftTitles 左边title数组
 *  @param topTitles  顶部title数组
 *  @param imageItems 图片数组，格式：数组中全是字典，其中key为该item在表格中的坐标，行和列用“：”隔开，“：”前为行，后为列，表格除开标题外从0行0列开始计算，value为该item对应的图片名称，例：@[@{@"0:1":@"fullOrdered"},@{@"3:3":@"ordered"}]，则0为行，1为列，fullOrdered为图片名称
 *
 *  @return ChartView对象
 */
-(instancetype)initWithFrame:(CGRect)frame leftTitles:(NSArray *)leftTitles topTitles:(NSArray *)topTitles itemImageDatas:(NSArray *)imageItems;
/**
 *  表格中只有特定的几个表格是文字，其他item为空
 *
 *  @param frame      表格的frame
 *  @param leftTitles 左边的title数组
 *  @param topTitles  顶部的title数组
 *  @param titleItems 文字数组，格式同上，value为该item对应的文字
 *
 *  @return ChartView对象
 */
-(instancetype)initWithFrame:(CGRect)frame leftTitles:(NSArray *)leftTitles topTitles:(NSArray *)topTitles itemTitleDatas:(NSArray *)titleItems;

@end

@protocol ChartDelegate <NSObject>
/**
 *  可选，若需要表格中的某个item时的点击事件，则需要设置代理，实现代理方法,否则不需要
 */
@optional
/**
 *  选中的某个item
 *
 *  @param row    该item所在的行
 *  @param column 该item所在的列
 */
-(void)chartViewDidSelecteItemAtRow:(NSInteger )row column:(NSInteger )column;
/**
 *  选中的左边title
 *
 *  @param row 选中的左边item的row
 */
-(void)chartViewDidSelecteTitleAtRow:(NSInteger )row;

@end