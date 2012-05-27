//
//  DataBase.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-24.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>



@interface DataBase : NSObject {

}


+ (BOOL) updateDateBase;
+ (sqlite3 *)openDataBase;
+ (void)closeDataBase;

@end
