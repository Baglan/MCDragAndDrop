//
//  MCDropTargetView.m
//  MCDragAndDrop
//
//  Created by Baglan on 6/10/13.
//  Copyright (c) 2013 MobileCreators. All rights reserved.
//

#import "MCDropTargetView.h"

@implementation MCDropTargetView

- (void)draggingStarted
{
    
}

- (void)draggableViewMovedOver:(MCDraggableView *)draggableView
{
    
}

- (void)draggableViewMovedOut:(MCDraggableView *)draggableView
{
    
}

- (void)draggingEnded
{
    
}

- (void)droppedDraggableView:(MCDraggableView *)draggableView
{
    [draggableView acceptedByDropTargetView:self];
}

@end
