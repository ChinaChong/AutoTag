//
//  AutoTag.h
//  AutoTag
//
//  Created by chinachong on 16/6/3.
//  Copyright © 2016年 chinachong. All rights reserved.
//  觉醒1.3

#import <UIKit/UIKit.h>

#pragma mark - CollectionView
#define BACKCOLOR_BLUE HexColor(0x77C7F7)
typedef void(^chooseFinish)(NSArray *category);
@interface AutoTag : UIViewController
@property (nonatomic,strong) NSMutableArray *allCategory;  // 所有标签文本
@property (nonatomic,strong) NSMutableArray *haveSelected; // 未进入页面前已选的
@property (nonatomic,copy) chooseFinish chooseFinish;      // 选择完成的文本数组
@property (nonatomic,assign) BOOL canMultipleChoice;       // 是否可以多选(超过5个)
@property (nonatomic,copy) NSString *titleText;            // 选择页面控制器的标题
@property (nonatomic,copy) NSString *tipText;              // 多于5个时的提示语(非多选)
@end

#pragma mark - CollectionView
@interface GCCollectionView : UIView

@property (nonatomic,strong) NSMutableArray *selectedDataArray;
@property (strong,nonatomic) NSMutableArray *dataArrray;
@property (nonatomic,assign) BOOL canMultipleChoice;
@property (nonatomic,copy)   NSString *tipText;
-(void)reloadData;

@end

#pragma mark - Cell
@interface CategoryCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *contentTextLabel;
@property (nonatomic,strong) UIImageView *backgroundImgView;
@property (nonatomic,assign) BOOL isSelected;

@end

#pragma mark - CollectionViewLayout
@interface GCCollectionViewLayout : UICollectionViewFlowLayout
@property (nonatomic,strong) NSArray *allWidth;
@end

#pragma mark - Model
@interface GCCollectionModel : NSObject

@property (nonatomic,copy) NSString *contentText;
@property (nonatomic,assign) BOOL isSelected;

@end

#pragma mark - NSStringWidth

@interface NSString (NSStringWidth)
- (CGFloat)stringWidthWithFont:(UIFont *)font height:(CGFloat)height;
@end

#pragma mark - UIViewCategory

@interface UIView (fetchViewController)
- (UIViewController*)viewController;
@end
