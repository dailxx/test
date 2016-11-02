//
//  ABMenuBar1.m
//  TTProject
//
//  Created by 张志恒 on 16/9/8.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABMenuBar.h"

@interface ABMenuBar ()

@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation ABMenuBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitialization {
    _contentView = [[UIScrollView alloc] init];
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_contentView];
    
    [self setTranslucent:NO];
}

- (void)layoutSubviews {
    CGSize frameSize = self.frame.size;
    CGSize contentSize = CGSizeMake(self.itemWidth * self.items.count + self.contentEdgeInsets.left + self.contentEdgeInsets.right, frameSize.height);
    
    [[self contentView] setFrame:self.bounds];
    [[self contentView] setContentSize:contentSize];
    
    NSInteger index = 0;
    
    // Layout items
    
    for (ABMenuItem *item in [self items]) {
        CGFloat itemHeight = frameSize.height;
        
        [item setFrame:CGRectMake(self.contentEdgeInsets.left + (index * self.itemWidth),
                                  self.contentEdgeInsets.top,
                                  self.itemWidth,
                                  itemHeight - self.contentEdgeInsets.bottom - self.contentEdgeInsets.top)];
        
        index++;
    }
}

#pragma mark - Configuration

- (void)setItemWidth:(CGFloat)itemWidth {
    if (itemWidth > 0) {
        _itemWidth = itemWidth;
    }
}

- (void)setItems:(NSArray *)items {
    for (ABMenuItem *item in _items) {
        [item removeFromSuperview];
    }
    
    _items = items;
    for (ABMenuItem *item in _items) {
        [item addTarget:self action:@selector(menuBarItemWasSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:item];
    }
    
}

- (void)setHeight:(CGFloat)height {
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame),
                              CGRectGetWidth(self.frame), height)];
}

- (void)setContentViewOffset:(CGRect)frame
{
    CGRect covertFrame = [self.contentView convertRect:frame toView:self];
    if (covertFrame.origin.x <= 0) {
        // 左边计算偏移量
        CGRect visibleFrame = CGRectMake(CGRectGetMinX(frame)-self.itemWidth, 0, self.itemWidth, CGRectGetHeight(self.frame));
        [self.contentView scrollRectToVisible:visibleFrame animated:YES];
    } else if (covertFrame.origin.x + covertFrame.size.width >= self.frame.size.width) {
        // 右边计算偏移量
        CGRect visibleFrame = CGRectMake(CGRectGetMaxX(frame), 0, self.itemWidth, CGRectGetHeight(self.frame));
        [self.contentView scrollRectToVisible:visibleFrame animated:YES];
    }
}

#pragma mark - Item selection

- (void)menuBarItemWasSelected:(id)sender {
    if ([self.delegate respondsToSelector:@selector(menuBar:shouldSelectItemAtIndex:)]) {
        NSInteger index = [self.items indexOfObject:sender];
        if (![self.delegate menuBar:self shouldSelectItemAtIndex:index]) {
            return;
        }
    }
    
    [self setSelectedItem:sender];
    
    if ([self.delegate respondsToSelector:@selector(menuBar:didSelectItemAtIndex:)]) {
        NSInteger index = [self.items indexOfObject:self.selectedItem];
        [self.delegate menuBar:self didSelectItemAtIndex:index];
    }
}

- (void)setSelectedItem:(ABMenuItem *)selectedItem {
    if (selectedItem == _selectedItem) {
        return;
    }
    
    [_selectedItem setSelected:NO];
    _selectedItem = selectedItem;
    [_selectedItem setSelected:YES];
    
    [self setContentViewOffset:[selectedItem frame]];
}

#pragma mark - Translucency

- (void)setTranslucent:(BOOL)translucent {
    _translucent = translucent;
    
    CGFloat alpha = (translucent ? 0.9 : 1.0);
    
    [_contentView setBackgroundColor:[UIColor colorWithRed:245/255.0
                                                        green:245/255.0
                                                         blue:245/255.0
                                                        alpha:alpha]];
}

@end
