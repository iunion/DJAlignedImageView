//
//  ViewController.m
//  DJAlignedImageViewSample
//
//  Created by DJ on 2018/3/1.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *contentModeStrings;
}

@property (weak, nonatomic) IBOutlet DJAlignedImageView *alignedImageView;

- (IBAction)changeImage:(id)sender;

- (IBAction)verticallyAlignChanged:(id)sender;
- (IBAction)horizontallyAlignChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *contentModeBtn;
- (IBAction)changeContentMode:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    contentModeStrings = [NSArray arrayWithObjects:
                          @"UIViewContentModeScaleToFill",
                          @"UIViewContentModeScaleAspectFit",      // contents scaled to fit with fixed aspect. remainder is transparent
                          @"UIViewContentModeScaleAspectFill",     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
                          @"UIViewContentModeRedraw",              // redraw on bounds change (calls -setNeedsDisplay)
                          @"UIViewContentModeCenter",              // contents remain same size. positioned adjusted.
                          @"UIViewContentModeTop",
                          @"UIViewContentModeBottom",
                          @"UIViewContentModeLeft",
                          @"UIViewContentModeRight",
                          @"UIViewContentModeTopLeft",
                          @"UIViewContentModeTopRight",
                          @"UIViewContentModeBottomLeft",
                          @"UIViewContentModeBottomRight", nil];

    self.alignedImageView.image = [UIImage imageNamed:@"1.jpg"];
    //self.alignedImageView.enableScaleUp = NO;
    self.alignedImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self refreshContentModeButtonTitle];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeImage:(id)sender
{
    static BOOL change = NO;
    
    if (change)
    {
        self.alignedImageView.image = [UIImage imageNamed:@"1.jpg"];
    }
    else
    {
        self.alignedImageView.image = [UIImage imageNamed:@"2.jpg"];
    }
    
    change = !change;
}

- (IBAction)verticallyAlignChanged:(UISegmentedControl *)sender
{
    self.alignedImageView.alignmentMask &= ~(DJImageViewAlignmentMaskTop | DJImageViewAlignmentMaskBottom);

    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.alignedImageView.alignmentMask |= DJImageViewAlignmentMaskTop;
            break;
            
        case 2:
            self.alignedImageView.alignmentMask |= DJImageViewAlignmentMaskBottom;
            break;

        default:
            break;
    }
}

- (IBAction)horizontallyAlignChanged:(UISegmentedControl *)sender
{
    self.alignedImageView.alignmentMask &= ~(DJImageViewAlignmentMaskLeft | DJImageViewAlignmentMaskRight);

    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.alignedImageView.alignmentMask |= DJImageViewAlignmentMaskLeft;
            break;
            
        case 2:
            self.alignedImageView.alignmentMask |= DJImageViewAlignmentMaskRight;
            break;
            
        default:
            break;
    }
}

- (void)refreshContentModeButtonTitle
{
    [self.contentModeBtn setTitle:contentModeStrings[self.alignedImageView.contentMode] forState:UIControlStateNormal];
}

- (IBAction)changeContentMode:(id)sender
{
    self.alignedImageView.contentMode = (self.alignedImageView.contentMode + 1) % (UIViewContentModeBottomRight+1);
    [self refreshContentModeButtonTitle];
}

@end
