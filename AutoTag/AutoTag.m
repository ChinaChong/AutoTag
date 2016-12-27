//
//  AutoTag.m
//  AutoTag
//
//  Created by chinachong on 16/6/3.
//  Copyright © 2016年 chinachong. All rights reserved.
//

#import "AutoTag.h"

//****************常量及宏****************//
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define HexColor(hexValue)  [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]
#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
static CGFloat const shadowHeight = 20;
static CGFloat const marginLabelToCell = 15;
static CGFloat const labelHeight = 17;
//****************常量及宏****************//

@interface AutoTag ()
@property (nonatomic,strong) GCCollectionView *collectionView;
@end

@implementation AutoTag

- (void)loadView {
    self.collectionView = [[GCCollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.collectionView;
}

- (NSMutableArray *)allCategory {
    if (_allCategory == nil) {
        _allCategory = [NSMutableArray array];
    }
    return _allCategory;
}

- (NSMutableArray *)haveSelected {
    if (_haveSelected == nil) {
        _haveSelected = [NSMutableArray array];
    }
    return _haveSelected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 67, 18)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    if (self.titleText && self.titleText.length > 0) {
        titleLabel.text = self.titleText;
    }else{
        titleLabel.text = @"自适应标签"; // 默认
    }
    if (self.tipText && self.tipText.length > 0) {
        self.collectionView.tipText = self.tipText;
    }
    titleLabel.textColor = RGBCOLOR(3, 3, 3);
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.navigationItem setTitleView:titleLabel];
    
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *arr2 = [NSMutableArray array];
    for (NSString *category in self.allCategory) {
        GCCollectionModel *model = [[GCCollectionModel alloc] init];
        model.contentText = category;
        if ([_haveSelected containsObject:model.contentText]) {
            model.isSelected = YES;
            [arr2 addObject:model.contentText];
        }
        [arr addObject:model];
    }
    self.collectionView.dataArrray = arr;
    self.collectionView.selectedDataArray = arr2;
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(saveAndExit:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    [saveBtn setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(29, 161, 242)} forState:(UIControlStateNormal)];
    [saveBtn setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(204, 204, 204)} forState:(UIControlStateDisabled)];
    
//    [self addBackView];
    self.collectionView.canMultipleChoice = self.canMultipleChoice;
}

//- (void)addBackView{
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 9, 16)];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    backItem.title = @"Back";
//    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = backItem;
//}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAndExit:(UIBarButtonItem *)sender {
    
    self.chooseFinish(self.collectionView.selectedDataArray);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


@interface GCCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic) UICollectionView *collection;
@end

@implementation GCCollectionView

-(void)reloadData{
    [_collection reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        GCCollectionViewLayout *flow = [[GCCollectionViewLayout alloc] init];
        
        self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flow];
        
        self.collection.backgroundColor = RGBCOLOR(255, 255, 255);
        
        [self addSubview:self.collection];
        
        self.collection.dataSource = self;
        self.collection.delegate = self;
        
        [self.collection registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    _collection.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GCCollectionModel *model = self.dataArrray[indexPath.item];
    CGFloat width = [model.contentText stringWidthWithFont:[UIFont systemFontOfSize:14] height: 17000];
    return CGSizeMake(width + 15 * 2, 56);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GCCollectionModel *model = self.dataArrray[indexPath.item];
    model.isSelected = !model.isSelected;
    CategoryCollectionViewCell *cell = (CategoryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (model.isSelected) {
        if (!self.canMultipleChoice) {
            if (self.selectedDataArray.count >= 5) {
                if (self.tipText.length == 0) {
                    self.tipText = @"您最多可以选择5个标签";// 默认提示
                }
                [self showAlertWithMessage:self.tipText];
                return;
            }
        }
        cell.backgroundImgView.image = [UIImage imageNamed:@"tag_bg_selected"];
        cell.contentTextLabel.textColor = [UIColor whiteColor];
        if (![self.selectedDataArray containsObject:model.contentText]) {
            [self.selectedDataArray addObject:model.contentText];
        }
    }else{
        cell.backgroundImgView.image = [UIImage imageNamed:@"tag_bg"];
        cell.contentTextLabel.textColor = HexColor(0xFF5C5C5C);
        if ([self.selectedDataArray containsObject:model.contentText]) {
            [self.selectedDataArray removeObject:model.contentText];
        }
    }
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"知道了" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:act];
    [[self viewController] presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArrray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GCCollectionModel *model = self.dataArrray[indexPath.item];
    
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentTextLabel.text = model.contentText;
    
    if (model.isSelected) {
        cell.backgroundImgView.image = [UIImage imageNamed:@"tag_bg_selected"];
        cell.contentTextLabel.textColor = [UIColor whiteColor];
        model.contentText = cell.contentTextLabel.text;
    }else{
        cell.backgroundImgView.image = [UIImage imageNamed:@"tag_bg"];
        cell.contentTextLabel.textColor = HexColor(0xFF5C5C5C);
    }
    return cell;
}

- (NSMutableArray *)dataArrray {
    if (_dataArrray == nil) {
        _dataArrray = [NSMutableArray array];
    }
    return _dataArrray;
}

- (NSMutableArray *)selectedDataArray {
    if (_selectedDataArray == nil) {
        _selectedDataArray = [NSMutableArray array];
    }
    return _selectedDataArray;
}

@end

@implementation CategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _contentTextLabel = [[UILabel alloc] init];
        self.backgroundImgView = [[UIImageView alloc] init];
        self.backgroundImgView.image = [UIImage imageNamed:@"tag_bg"];
        [self.contentView addSubview:self.backgroundImgView];
        [self.contentView addSubview:_contentTextLabel];
        self.contentTextLabel.textAlignment = NSTextAlignmentCenter;
        self.contentTextLabel.backgroundColor = [UIColor clearColor];
        self.contentTextLabel.font = [UIFont systemFontOfSize:14];
        self.contentTextLabel.textColor = RGBCOLOR(92, 92, 92);
        self.isSelected = NO;
        [self.contentView addSubview:self.contentTextLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    _contentTextLabel.frame = CGRectMake(marginLabelToCell, (frame.size.height - shadowHeight - labelHeight) / 2, frame.size.width - marginLabelToCell * 2, labelHeight);
    CGPoint center = _contentTextLabel.center;
    center.y = frame.size.height / 2.2;
    _contentTextLabel.center = center;
    _backgroundImgView.frame = self.contentView.bounds;
}

@end

@interface GCCollectionViewLayout ()
@property (nonatomic,strong) NSMutableArray *attrArray;
@end

@implementation GCCollectionViewLayout

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (NSMutableArray *)attrArray {
    if (!_attrArray) {
        _attrArray = [NSMutableArray array];
    }
    return _attrArray;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    self.minimumInteritemSpacing = 3;
    self.minimumLineSpacing = 3;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(10, 18, 10, 18);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    // 重点!!!
    NSArray *attributes = [[NSArray alloc] initWithArray:original copyItems:YES];// 重点!!!
    //从第二个循环到最后一个attributes
    for(int i = 1; i < [attributes count]; i++) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        //我们想设置的最大间距，可根据需要改
        CGFloat maximumSpacing = 3;
        //前一个cell的最右边
        CGFloat origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width + 18 <= ScreenWidth) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }else{
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = 18;
            frame.origin.y = CGRectGetMaxY(prevLayoutAttributes.frame) + 3;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}

@end

@implementation GCCollectionModel

@end

@implementation NSString (NSStringWidth)
- (CGFloat)stringWidthWithFont:(UIFont *)font height:(CGFloat)height {
    if (self == nil || self.length == 0) {
        return 0;
    }
    
    NSString *copyString = [NSString stringWithFormat:@"%@", self];
    
    CGSize constrainedSize = CGSizeMake(999999, height);
    
    NSDictionary * attribute = @{NSFontAttributeName:font};
    CGSize size = [copyString boundingRectWithSize:constrainedSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return ceilf(size.width);
}
@end

@implementation UIView (fetchViewController)

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end