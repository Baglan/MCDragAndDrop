//
//  MCDraggableView.h
//  MCDragAndDrop
//
//  Created by Baglan on 6/10/13.
//  Copyright (c) 2013 MobileCreators. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCDraggableView : UIView

- (void)draggingStarted;
- (void)acceptedByDropTargetView:(id)dropTarget;
- (void)draggingCancelled;

@end
