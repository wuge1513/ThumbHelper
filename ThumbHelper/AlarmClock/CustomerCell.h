//
//  CustomerCell.h
//  GeiniableClock
//
//  Created by yuan jun on 11-8-9.
//  Copyright 2011 the9. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomerCell : UITableViewCell {

	UILabel *displayName;
	UILabel *languageSet;
	UISwitch *customerSwitch;
}

@property (nonatomic, retain) IBOutlet UILabel *displayName;
@property (nonatomic, retain) IBOutlet UILabel *languageSet;
@property (nonatomic, retain) IBOutlet UISwitch *customerSwitch;

- (IBAction)cusSwitchAction:(UISwitch *)sender;

@end
