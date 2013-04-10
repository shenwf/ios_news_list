//
//  RootViewController.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize horizMenu = _horizMenu;
@synthesize items = _items;
@synthesize selectionItemLabel = _selectionItemLabel;
@synthesize table = _table;
@synthesize tableView;
@synthesize listData;
@synthesize constantData;
@synthesize type;

- (void)viewDidLoad
{
    self.items = [NSArray arrayWithObjects:@"dota", @"诛仙", @"赤壁", @"魔兽世界", @"风行游戏", @"第九维", @"愤怒的小鸟", @"我叫MT", @"完美时空", @"其他", nil];    
    [self.horizMenu reloadData];
    self.title = @"游戏资讯";
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"熊猫酒仙", @"仙女龙",@"撼地神牛",
                      @"巫医",@"巫妖", @"神灵武士", @"萨尔",@"沉默术士",
                      @"beijing",@"shanghai",@"changsha",@"guangzhou",@"shenzhen",nil];
    self.listData = array;
    constantData = listData;
    [super viewDidLoad];
}

- (void)refresh {
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

//下拉刷新 copy from pulltorefresh
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self refreshData];
}

- (void)refreshData {
    NSMutableArray *arrayCategory = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    
    for(NSString *obj in constantData) {
        NSString *str = [[NSString alloc] initWithFormat:@"%@-%@",obj,type];
        [arrayCategory addObject: str];
        
        i = i + 1;
    }
    
    listData = arrayCategory;
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.selectionItemLabel = nil;
    self.listData = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.horizMenu setSelectedIndex:0 animated:YES];
    [super viewWillAppear:animated];
}

- (void)dealloc
{
    [_table release];
    [super dealloc];
}

#pragma mark -
#pragma mark HorizMenu Data Source
- (UIImage*) selectedItemImageForMenu:(MKHorizMenu*) tabMenu
{
    return [[UIImage imageNamed:@"ButtonSelected"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
}

- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView
{
    return [self.items count];
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
{
    return [self.items objectAtIndex:index];
}

#pragma mark -
#pragma mark HorizMenu Delegate
-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{
    NSString *text = [self.items objectAtIndex:index];
    type = text;
    [self refreshData];
}



- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table View Data Source Methods

-(NSInteger) tableView:(UITableView *) tableView
 numberOfRowsInSection:(NSInteger)section{
    self.tableView = tableView;
    return [self.listData count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSUInteger row = [indexPath row];
    
    NSString *SimpleTableIdentifier = [[NSString alloc] initWithFormat:@"SimpleTableIdentifier %d", row]; 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    }
    if(row < [listData count] ) {
       cell.textLabel.text = [listData objectAtIndex:row];
    }
    
    if(row < 5 ) {
        cell.detailTextLabel.text = @"Mr, Disneiy";
    } else {
        cell.detailTextLabel.text = @"Mr, Tolkien";
    }
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    if(row ==0) {
        return nil;
    }
    
    return  indexPath;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSString *rowValue = [listData objectAtIndex:row];
    NSString *message = [[NSString alloc] initWithFormat:@"You selected %@", rowValue];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Row selected"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"Yes I did"
                          otherButtonTitles:nil];
    [alert show];
}
@end
