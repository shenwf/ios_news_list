//
//  RootViewController.h
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"
@interface RootViewController : UIViewController <MKHorizMenuDataSource, MKHorizMenuDelegate,UITableViewDelegate, UITableViewDataSource> {

    MKHorizMenu *_horizMenu;
    NSMutableArray *_items;
    UILabel *_selectionItemLabel;
}

@property (nonatomic, retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, assign) IBOutlet UILabel *selectionItemLabel;
@property (retain, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *listData;
@property (retain, nonatomic) NSMutableArray *constantData;
@property (retain, nonatomic) NSString *type;
@end
