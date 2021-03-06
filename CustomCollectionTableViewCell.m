//
//  CustomCollectionTableViewCell.m
//  RGButterfly
//
//  Created by Stuart Pineo on 7/13/15.
//  Copyright (c) 2015 Stuart Pineo. All rights reserved.
//
#import "CustomCollectionTableViewCell.h"


@interface CustomCollectionTableViewCell()

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation CustomCollectionTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)cellHeight collectViewInset:(CGFloat)collectViewInset padding:(CGFloat)padding backgroundColor:(UIColor *)backgroundColor {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    // Ensure that values are set
    //
    _backgroundColor  = backgroundColor;
    _tableCellHeight  = cellHeight;
    _fieldPadding     = padding;
    _collectViewInset = collectViewInset;
    
    _layout = [self setFlowLayout:_collectViewInset padding:_fieldPadding cellWidth:_tableCellHeight cellHeight:_tableCellHeight];
    [self setCollectionView:_layout backgroundColor:_backgroundColor];

    return self;
}

- (void)setCollectionView:(UICollectionViewFlowLayout *)layout backgroundColor:(UIColor *)backgroundColor {
    if (self.collectionView)
        [self.collectionView removeFromSuperview];

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    [self.collectionView setBackgroundColor:backgroundColor];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    
    [self.contentView addSubview:self.collectionView];
}

- (UICollectionViewFlowLayout *)setFlowLayout:(CGFloat)inset padding:(CGFloat)padding cellWidth:(CGFloat)width cellHeight:(CGFloat)height {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setSectionInset:UIEdgeInsetsMake(inset * 2.0, padding, inset, padding)];
    [layout setMinimumInteritemSpacing:padding];
    [layout setItemSize: CGSizeMake(width, height)];
    [layout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    [layout setHeaderReferenceSize:CGSizeMake(padding, padding)];
    
    return layout;
}

- (void)addLabel:(UILabel *)label {
    [self.contentView addSubview:label];
}

- (void)setNoLabelLayout {
    [self.layout setSectionInset:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (! _xOffset) {
        _xOffset = self.contentView.bounds.origin.x;
    }

    [self.collectionView setFrame:CGRectMake(_xOffset, self.contentView.bounds.origin.y, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    
    CGFloat yCrop  = (self.contentView.bounds.size.height - _tableCellHeight) / 2.0;
    //CGFloat offset = _fieldPadding * 2.0;

    [self.imageView setFrame:CGRectMake(_fieldPadding, self.contentView.bounds.origin.y + 0.0, _tableCellHeight, self.contentView.bounds.size.height)];
    self.imageView.bounds = CGRectInset(self.imageView.frame, 0.0, yCrop);
}

// TableView controller will handle the Collection methods
//
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index {
    [self.collectionView setDataSource:dataSourceDelegate];
    [self.collectionView setDelegate:dataSourceDelegate];
    [self.collectionView setTag:index];
    
    [self.collectionView reloadData];
}


@end
