//
//  Notes.h
//  ThumbHelper
//
//  Created by LiuLei on 12-5-27.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notes : NSObject

@property (assign, nonatomic) NSInteger id_notes;
@property (strong, nonatomic) NSString *title_notes;
@property (strong, nonatomic) NSString *time_notes;
@property (strong, nonatomic) NSString *content_notes;

@end
