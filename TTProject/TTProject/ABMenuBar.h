//
//  ABMenuBar1.h
//  TTProject
//
//  Created by 张志恒 on 16/9/8.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABMenuBar;
@compatibility_alias ABMenuItem UIButton;

@protocol ABMenuBarDelegate <NSObject>

/**
 * Asks the delegate if the specified menu bar item should be selected.
 */
- (BOOL)menuBar:(ABMenuBar *)menuBar shouldSelectItemAtIndex:(NSInteger)index;

/**
 * Tells the delegate that the specified menu bar item is now selected.
 */
- (void)menuBar:(ABMenuBar *)menuBar didSelectItemAtIndex:(NSInteger)index;

@end

@interface ABMenuBar : UIView
/**
 * The menu bar’s delegate object.
 */
@property (nonatomic, weak) id<ABMenuBarDelegate> delegate;

/**
 * The items displayed on the menu bar.
 */
@property (nonatomic, copy) NSArray *items;

/**
 * The currently selected item on the menu bar.
 */
@property (nonatomic, weak) ABMenuItem *selectedItem;

/**
 * Sets the width of menu bar item.
 */
@property (nonatomic) CGFloat itemWidth;

/*
 * contentEdgeInsets can be used to center the items in the middle of the menuBar.
 */
@property UIEdgeInsets contentEdgeInsets;

/**
 * Sets the height of menu bar.
 */
- (void)setHeight:(CGFloat)height;

/*
 * Enable or disable menuBar translucency. Default is NO.
 */
@property (nonatomic, getter=isTranslucent) BOOL translucent;

@end
