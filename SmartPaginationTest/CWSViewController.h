//
//  CWSViewController.h
//  SmartPaginationTest
//
//  Created by Cleber Santos on 23/10/13.
//  Copyright (c) 2013 Cleber Santos. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;


@interface CWSViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollview;
    
    int totalItems;
    
    int currentPage;
    
    // Subview dimensions
    float imageWidth, imageHeight;
    
    // All subviews of the scrollview
    NSMutableArray *contentViews;
    
    // Direction of scroll in scrollview
    ScrollDirection scrollDirection;
}

@end
