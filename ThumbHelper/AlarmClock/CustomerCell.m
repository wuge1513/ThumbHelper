//
//  CustomerCell.m
//  GeiniableClock
//
//  Created by yuan jun on 11-8-9.
//  Copyright 2011 the9. All rights reserved.
//

#import "CustomerCell.h"

#define CN @"简体中文"
#define EN @"English"

@implementation CustomerCell
@synthesize displayName;
@synthesize languageSet;
@synthesize customerSwitch;

- (IBAction)cusSwitchAction:(UISwitch *)sender
{
	switch (sender.tag) {
		case 1000:
			
			break;
		case 1001:
			
			break;
		case 1002:
			if (sender.on)
				languageSet.text = CN;
			else
				languageSet.text = EN;
			break;
		default:
			break;
	}
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

@end
