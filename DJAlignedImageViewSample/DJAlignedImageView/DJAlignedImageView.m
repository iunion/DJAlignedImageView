//
//  DJAlignedImageView.m
//  DJAlignedImageViewSample
//
//  Created by DJ on 2018/3/1.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#import "DJAlignedImageView.h"

@interface DJAlignedImageView ()

@property (nonatomic, strong) UIImageView *realImageView;

@end

@implementation DJAlignedImageView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInitWithImage:nil highlightedImage:nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInitWithImage:nil highlightedImage:nil];
    }
    return self;
}

- (instancetype)initWithImage:(nullable UIImage *)image
{
    CGSize size = image.size;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInitWithImage:image highlightedImage:nil];
    }
    return self;
}

- (instancetype)initWithImage:(nullable UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage
{
    CGSize size = image.size;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInitWithImage:image highlightedImage:highlightedImage];
    }
    return self;
}

- (void)commonInitWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self.backgroundColor = [UIColor redColor];
    
    _enableScaleDown = YES;
    _enableScaleUp = YES;
    
    _alignmentMask = DJImageViewAlignmentMaskCenter;
    
    _realImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _realImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _realImageView.contentMode = self.contentMode;
    [self addSubview:_realImageView];
    
    _realImageView.image = image;
    _realImageView.highlightedImage = highlightedImage;
}

//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    
//    [self setNeedsLayout];
//}

- (UIImage *)image
{
    return self.realImageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.realImageView.image = image;
    [self setNeedsLayout];
}

- (UIImage *)highlightedImage
{
    return self.realImageView.highlightedImage;
}

- (void)setHighlightedImage:(UIImage *)highlightedImage
{
    self.realImageView.highlightedImage = highlightedImage;
    [self setNeedsLayout];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    self.realImageView.userInteractionEnabled = userInteractionEnabled;
}

- (BOOL)isHighlighted
{
    return [self.realImageView isHighlighted];
}

- (void)setHighlighted:(BOOL)highlighted
{
    self.realImageView.highlighted = highlighted;
}

- (void)setAnimationImages:(NSArray<UIImage *> *)animationImages
{
    self.realImageView.animationImages = animationImages;
}

- (NSArray<UIImage *> *)animationImages
{
    return self.realImageView.animationImages;
}

- (void)setHighlightedAnimationImages:(NSArray<UIImage *> *)highlightedAnimationImages
{
    self.realImageView.highlightedAnimationImages = highlightedAnimationImages;
}

- (NSArray<UIImage *> *)highlightedAnimationImages
{
    return self.realImageView.highlightedAnimationImages;
}

- (void)setAnimationDuration:(NSTimeInterval)animationDuration
{
    self.realImageView.animationDuration = animationDuration;
}

- (NSTimeInterval)animationDuration
{
    return self.realImageView.animationDuration;
}

- (void)setAnimationRepeatCount:(NSInteger)animationRepeatCount
{
    self.realImageView.animationRepeatCount = animationRepeatCount;
}

- (NSInteger)animationRepeatCount
{
    return self.realImageView.animationRepeatCount;
}

- (void)setTintColor:(UIColor *)tintColor
{
    self.realImageView.tintColor = tintColor;
}

- (UIColor *)tintColor
{
    return self.realImageView.tintColor;
}

- (void)startAnimating
{
    [self.realImageView startAnimating];
}

- (void)stopAnimating
{
    [self.realImageView stopAnimating];
}

- (BOOL)isAnimating
{
    return [self.realImageView isAnimating];
}

- (void)setContentMode:(UIViewContentMode)contentMode
{
    [super setContentMode:contentMode];
    _realImageView.contentMode = contentMode;
    [self setNeedsLayout];
}

- (void)setEnableScaleUp:(BOOL)enableScaleUp
{
    if (_enableScaleUp == enableScaleUp)
    {
        return ;
    }
    
    _enableScaleUp = enableScaleUp;
    [self setNeedsLayout];
}

- (void)setEnableScaleDown:(BOOL)enableScaleDown
{
    if (_enableScaleDown == enableScaleDown)
    {
        return ;
    }
    
    _enableScaleDown = enableScaleDown;
    [self setNeedsLayout];
}

- (void)setAlignmentMask:(DJImageViewAlignmentMask)alignmentMask
{
    if (_alignmentMask == alignmentMask)
    {
        return ;
    }
    
    _alignmentMask = alignmentMask;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize realsize = [self realContentSize];
    
    CGRect realframe = CGRectMake((self.bounds.size.width - realsize.width)/2, (self.bounds.size.height - realsize.height) / 2, realsize.width, realsize.height);
    
    if ((self.alignmentMask & DJImageViewAlignmentMaskLeft) != 0)
    {
        realframe.origin.x = 0;
    }
    else if ((self.alignmentMask & DJImageViewAlignmentMaskRight) != 0)
    {
        realframe.origin.x = CGRectGetMaxX(self.bounds) - realframe.size.width;
    }
    
    if ((self.alignmentMask & DJImageViewAlignmentMaskTop) != 0)
    {
        realframe.origin.y = 0;
    }
    else if ((self.alignmentMask & DJImageViewAlignmentMaskBottom) != 0)
    {
        realframe.origin.y = CGRectGetMaxY(self.bounds) - realframe.size.height;
    }
    
    self.realImageView.frame = realframe;
}

- (CGSize)realContentSize
{
    CGSize size = self.bounds.size;
    
    if (self.image == nil)
    {
        return size;
    }
    
    CGSize imageSize = self.realImageView.image.size;
    if (CGSizeEqualToSize(imageSize, CGSizeZero))
    {
        return size;
    }
    
    switch (self.contentMode)
    {
        case UIViewContentModeScaleAspectFit:
        {
            float scalex = self.bounds.size.width / imageSize.width;
            float scaley = self.bounds.size.height / imageSize.height;
            float scale = MIN(scalex, scaley);
            
            if ((scale > 1.0f && !self.enableScaleUp) ||
                (scale < 1.0f && !self.enableScaleDown))
            {
                scale = 1.0f;
            }
            size = CGSizeMake(imageSize.width * scale, imageSize.height * scale);
            break;
        }
            
        case UIViewContentModeScaleAspectFill:
        {
            float scalex = self.bounds.size.width / imageSize.width;
            float scaley = self.bounds.size.height / imageSize.height;
            float scale = MAX(scalex, scaley);
            
            if ((scale > 1.0f && !self.enableScaleUp) ||
                (scale < 1.0f && !self.enableScaleDown))
            {
                scale = 1.0f;
            }
            
            size = CGSizeMake(imageSize.width * scale, imageSize.height * scale);
            break;
        }
            
        case UIViewContentModeScaleToFill:
        {
            float scalex = self.bounds.size.width / imageSize.width;
            float scaley = self.bounds.size.height / imageSize.height;
            
            if ((scalex > 1.0f && !self.enableScaleUp) ||
                (scalex < 1.0f && !self.enableScaleDown))
            {
                scalex = 1.0f;
            }
            if ((scaley > 1.0f && !self.enableScaleUp) ||
                (scaley < 1.0f && !self.enableScaleDown))
            {
                scaley = 1.0f;
            }
            
            size = CGSizeMake(imageSize.width * scalex, imageSize.height * scaley);
            break;
        }
            
        default:
            //size = imageSize;
            break;
    }
    
    return size;
}


@end

