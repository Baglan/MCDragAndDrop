//
//  MCDragAndDropView.m
//  MCDragAndDrop
//
//  Created by Baglan on 6/10/13.
//  Copyright (c) 2013 MobileCreators. All rights reserved.
//

#import "MCDragAndDropView.h"
#import "MCDraggableView.h"
#import "MCDropTargetView.h"

@implementation MCDragAndDropView {
    MCDraggableView * _draggable;
    MCDropTargetView * _dropTarget;
}

- (MCDraggableView *)firstDraggableAtPoint:(CGPoint)point
{
    __block MCDraggableView * draggable = nil;
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView * view = obj;
        if ([view isKindOfClass:[MCDraggableView class]] && CGRectContainsPoint(view.frame, point)) {
            draggable = (MCDraggableView *)view;
            *stop = YES;
        }
    }];
    return draggable;
}

- (MCDropTargetView *)firstDropTargetAtPoint:(CGPoint)point
{
    __block MCDropTargetView * dropTarget = nil;
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView * view = obj;
        if ([view isKindOfClass:[MCDropTargetView class]] && CGRectContainsPoint(view.frame, point)) {
            dropTarget = (MCDropTargetView *)view;
            *stop = YES;
        }
    }];
    return dropTarget;
}

- (NSArray *)dropTargets
{
    NSMutableArray * dropTargets = [NSMutableArray array];
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MCDropTargetView class]]) {
            [dropTargets addObject:obj];
        }
    }];
    return dropTargets;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    _draggable = [self firstDraggableAtPoint:[touch locationInView:self]];
    if (_draggable) {
        NSArray * dropTargets = [self dropTargets];
        [dropTargets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MCDropTargetView * dropTarget = obj;
            [dropTarget draggingStarted];
        }];
        [_draggable draggingStarted];
    }
}

- (void)draggingFinished
{
    _draggable = nil;
    _dropTarget = nil;
    
    NSArray * dropTargets = [self dropTargets];
    [dropTargets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MCDropTargetView * dropTarget = obj;
        [dropTarget draggingEnded];
    }];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self draggingFinished];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_dropTarget) {
        [_dropTarget droppedDraggableView:_draggable];
    } else {
        [_draggable draggingCancelled];
    }
    
    
    [self draggingFinished];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_draggable) {
        UITouch * touch = [touches anyObject];
        MCDropTargetView * dropTarget = [self firstDropTargetAtPoint:[touch locationInView:self]];
        if (dropTarget != _dropTarget) {
            [_dropTarget draggableViewMovedOut:_draggable];
            _dropTarget = dropTarget;
            [_dropTarget draggableViewMovedOver:_draggable];
        }
        
        _draggable.center = [touch locationInView:self];
    }
}

@end
