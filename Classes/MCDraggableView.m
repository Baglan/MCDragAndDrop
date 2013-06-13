//
//  MCDraggableView.m
//  MCDragAndDrop
//
//  Created by Baglan on 6/10/13.
//  Copyright (c) 2013 MobileCreators. All rights reserved.
//

#import "MCDraggableView.h"
#import "MCDropTargetView.h"

@implementation MCDraggableView {
    CGPoint _initialPoint;
}

- (void)draggingStarted
{
    _initialPoint = self.center;
}

- (void)acceptedByDropTargetView:(id)dropTarget
{
    MCDropTargetView * targetView = dropTarget;
    self.center = targetView.center;
}

- (void)draggingCancelled
{
    self.center = _initialPoint;
}

@end
