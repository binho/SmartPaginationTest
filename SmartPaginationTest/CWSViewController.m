//
//  CWSViewController.m
//  SmartPaginationTest
//
//  Created by Cleber Santos on 23/10/13.
//  Copyright (c) 2013 Cleber Santos. All rights reserved.
//

#import "CWSViewController.h"

#define NUMBER_OF_ITEMS 20


@interface CWSViewController ()
    @property (nonatomic, assign) NSInteger lastContentOffset;
@end

@implementation CWSViewController


//http://stackoverflow.com/questions/16788657/ios-scrollview-infinite-paging-duplicate-end-caps


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    contentViews = [[NSMutableArray alloc] init];
    totalItems = 0;
    currentPage = 0;
    imageWidth = 1024.0f;
    imageHeight = 768.0f;
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1024.0f, 768.0f)];
    scrollview.canCancelContentTouches = NO;
    scrollview.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    scrollview.scrollEnabled = YES;
    scrollview.pagingEnabled = YES;
    scrollview.scrollsToTop = NO;
    scrollview.bounces = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.delegate = self;

    for (int i = 0; i < 3; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidth * i, 0.0f, imageWidth, imageHeight)];
        
        UILabel *pageNumber = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 50.0f, 200.0f, 200.0f)];
        pageNumber.text = [NSString stringWithFormat:@"%i", i];
        pageNumber.font = [UIFont systemFontOfSize: 100.0f];
        pageNumber.textColor = [UIColor whiteColor];
        pageNumber.backgroundColor = [UIColor blackColor];
        pageNumber.textAlignment = NSTextAlignmentCenter;
        [imageview addSubview: pageNumber];
        
        imageview.backgroundColor = [UIColor clearColor];
        imageview.tag = (i + 1);
        
        imageview.userInteractionEnabled = YES;
        [scrollview addSubview: imageview];
        
        // Adiciona pagina ao array de conteudos
        [contentViews addObject: imageview];
        
        totalItems++;
    }
    
    [self.view addSubview: scrollview];
    
    // Define dimensoes do scrollview
    [scrollview setContentSize:CGSizeMake(imageWidth * 3, [scrollview bounds].size.height)];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Detecta direcao do scroll
    if (_lastContentOffset > scrollView.contentOffset.x) {
        scrollDirection = ScrollDirectionRight;
    } else if (_lastContentOffset < scrollView.contentOffset.x) {
        scrollDirection = ScrollDirectionLeft;
    }
    _lastContentOffset = scrollView.contentOffset.x;

    if (scrollView.contentOffset.x == 0) {
        CGPoint newOffset = CGPointMake(scrollView.bounds.size.width + scrollView.contentOffset.x, scrollView.contentOffset.y);
        [scrollView setContentOffset:newOffset];
        [self rotateViewsRight];
    } else if(scrollView.contentOffset.x == scrollView.bounds.size.width * 2) {
        CGPoint newOffset = CGPointMake(scrollView.contentOffset.x-scrollView.bounds.size.width, scrollView.contentOffset.y);
        [scrollView setContentOffset:newOffset];
        [self rotateViewsLeft];
    }
}

- (void)rotateViewsRight
{
    UIView *endView = [contentViews lastObject];
    [contentViews removeLastObject];
    [contentViews insertObject:endView atIndex: 0];
    [self setContentViewFrames];
}

- (void)rotateViewsLeft
{
    UIView *endView = contentViews[0];
    [contentViews removeObjectAtIndex:0];
    [contentViews addObject:endView];
    [self setContentViewFrames];
}

- (void) setContentViewFrames
{
    for (int i = 0; i < 3; i++) {
        UIView * view = contentViews[i];
        [view setFrame:CGRectMake(self.view.bounds.size.width * i, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollDirection == ScrollDirectionLeft) {
        NSLog(@"RIGHT");
        currentPage++;
    } else if (scrollDirection == ScrollDirectionRight) {
        NSLog(@"LEFT");
        if (currentPage > 0) currentPage--;
    }
    NSLog(@"current page: %i", currentPage);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
