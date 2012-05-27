//
//  DataBase.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-24.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Notes.h"

#define kSecondsDay 86400
#define CTTHUMBSIZE_WIDTH 186.0
#define LCTTHUMBSIZE_WIDTH 350.0
#define SIZE_WIDTH 300.0
#define LSIZE_WIDTH 460.0

@interface ManageDB: NSObject {

}
//            database table operate                   ///


+ (BOOL) shouldUpDate:(NSString *) tablename;    //just if should update

+ (BOOL) createTablediary;
+ (BOOL) updateTablediary;
+ (BOOL) updateAnotherData;
+ (BOOL) updatebgImage;
+ (BOOL) deleteTablediary;
+ (BOOL) renameTablediary;

+ (BOOL) renameTablectimage;

+ (BOOL) createTablediyimage;
+ (BOOL) updateTablediyimage;
+ (BOOL) deleteTablediyimage;
+ (BOOL) renameTablediyimage;
//+ (BOOL) deleteTabletmpimage;


+ (BOOL) createTablesound;
+ (BOOL) updateTablesound;

+ (BOOL) addTable;

+ (BOOL) deleteTable;

+ (BOOL) alertTable;

+ (BOOL) renameColumn;



//            diary table operate                   ///
+ (BOOL) insertIntoDiarywithID:(NSInteger ) ID withType:(NSInteger ) type withMdType:(NSInteger ) mdtype withWeather:(NSInteger) weather 
					  withFont:(NSString *) font withBG:(NSInteger ) bgID withContent:(NSString *) content;


+ (NSMutableArray *) getAllDiarys;

+ (Notes *) getNotes:(NSInteger ) ID;

//+ (NSMutableArray *) getDiary:(NSInteger ) ID;

+ (NSInteger) getFirstDiaryDate;
+ (NSInteger) getLastDiaryDate;

+ (BOOL) deleteDiary:(NSInteger) ID;

+ (NSMutableArray *) getDiarysfrom:(NSInteger) startDate to: (NSInteger) endDate;
+ (BOOL) deleteDiarysfrom:(NSInteger) startDate to: (NSInteger) endDate;

+ (NSInteger) getDiaryCountfrom:(NSInteger) startDate to: (NSInteger) endDate;

+ (BOOL) updateDiaryWithID:(NSInteger)ID withID:(NSInteger)newID;

+ (BOOL) updateDiaryWithID:(NSInteger ) ID withType:(NSInteger) type;
+ (BOOL) updateDiaryWithID:(NSInteger ) ID withMdType:(NSInteger) mdtype;
+ (BOOL) updateDiaryWithID:(NSInteger ) ID withWeather:(NSInteger) weather;
+ (BOOL) updateDiaryWithID:(NSInteger ) ID withFont:(NSString *) font;
+ (BOOL) updateDiaryWithID:(NSInteger ) ID withBG:(NSInteger ) bgID;
+ (BOOL) updateDiaryWithID:(NSInteger ) ID withContent:(NSString *) content;


+ (BOOL) insertIntoCtImageWithDate:(NSInteger) date withImage:(NSData *) data;
+ (NSMutableArray *) getCtImage:(NSInteger ) date;
+ (NSInteger) getCtImageCount:(NSInteger ) date;
+ (NSInteger) getCtImageID:(NSInteger ) date;

+ (BOOL) updateCtImageWithDate:(NSInteger)oldDate withDate:(NSInteger)newDate;

+ (BOOL) deleteCtImageWithID:(NSInteger) ID;
+ (BOOL) deleteCtImageWithDate:(NSInteger) date;
+ (BOOL) deleteCtImagefromDate:(NSInteger) startdate toDate:(NSInteger ) enddate;


+ (BOOL) insertIntoDiyImagewithID:(NSInteger )ID withDate:(NSInteger) date withImage:(NSData *) data;
+ (BOOL) updateDiyImageWithID:(NSInteger ) ID withDate:(NSInteger) date withImage:(NSData *) data;
+ (NSMutableArray *) getDiyImage:(NSInteger ) date;
+ (NSInteger) getDiyImageCount:(NSInteger ) date;

+ (BOOL) updateDiyImageWithDate:(NSInteger)oldDate withDate:(NSInteger)newDate;
+ (BOOL) deleteDiyImageWithID:(NSInteger) ID withDate:(NSInteger) date;
+ (BOOL) deleteDiyImageWithDate:(NSInteger) date;
+ (BOOL) deleteDiyImagefromDate:(NSInteger) startdate toDate:(NSInteger ) enddate;

+ (BOOL) insertIntoSoundWithDate:(NSInteger) date withName:(NSString *) name;
+ (NSMutableArray *) getSound:(NSInteger ) date;
+ (NSMutableArray *) getSoundfromDate:(NSInteger ) startdate toDate:(NSInteger ) enddate;
+ (NSInteger) getSoundCount:(NSInteger ) date;

+ (BOOL) updateSoundeWithDate:(NSInteger)oldDate withDate:(NSInteger)newDate;

+ (BOOL) deleteSoundWithID:(NSInteger) ID;
+ (BOOL) deleteSoundWithDate:(NSInteger) date;
+ (BOOL) deleteSoundfromDate:(NSInteger) startdate toDate:(NSInteger ) enddate;

@end
