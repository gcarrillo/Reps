//
//  CalendarViewController.m
//  Reps
//
//  Created by Gabriel Carrillo on 12/29/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//

#import "CalendarViewController.h"
#import "RSDFDatePickerView.h"
#import "Set.h"
#import "Exercise.h"
#import "AppDelegate.h"

@interface CalendarViewController ()

@property (nonatomic, strong) NSMutableDictionary *allSetsDict;
@property (nonatomic, strong) NSMutableArray *setsForDay;

@end

@implementation CalendarViewController

- (IBAction)todayButtonTapped:(id)sender {
    [self.datePickerView scrollToToday:YES];
    [self.datePickerView selectDate:[NSDate date]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datePickerView.delegate = self;
    self.datePickerView.dataSource = self;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(mocDidChange)
     name:NSManagedObjectContextObjectsDidChangeNotification
     object:self.managedObjectContext];
    
    [self fetchSets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mocDidChange {
    [self fetchSets];
    [self.datePickerView reloadData];
    [self.tableView reloadData];
}

- (void)fetchSets {
    self.allSetsDict = [[NSMutableDictionary alloc] init];
    
    // Do the CoreData fetch
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Set" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    unsigned units = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    for (Set *s in results) {
        NSDateComponents *components = [calendar components:units fromDate:s.date];
        NSDate *setDate = [calendar dateFromComponents:components];
        
        if ([self.allSetsDict objectForKey:setDate] == nil) {
            [self.allSetsDict setObject:[[NSMutableArray alloc] init] forKey:setDate];
        }
        
        [((NSMutableArray *)[self.allSetsDict objectForKey:setDate]) addObject:s];
    }
    
    self.setsForDay = [self.allSetsDict objectForKey:self.datePickerView.selectedDate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - RSDFDatePickerViewDelegate

// Returns YES if the date should be highlighted or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date {
    return YES;
}

// Returns YES if the date should be selected or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date {
    return YES;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date {
    self.setsForDay = [self.allSetsDict objectForKey:date];
    
    [self.tableView reloadData];
}

#pragma mark - RSDFDatePickerViewDataSource

// Returns YES if the date should be marked or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldMarkDate:(NSDate *)date {
    return ([self.allSetsDict objectForKey:date] == nil) ? NO : YES;
}

// Returns the color of the default mark image for the specified date.
- (UIColor *)datePickerView:(RSDFDatePickerView *)view markImageColorForDate:(NSDate *)date {
    //return [UIColor grayColor];
    return [UIColor greenColor];
}

// Returns the mark image for the specified date.
//- (UIImage *)datePickerView:(RSDFDatePickerView *)view markImageForDate:(NSDate *)date
//{
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.setsForDay count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell" forIndexPath:indexPath];
    
    Set *set = [self.setsForDay objectAtIndex:indexPath.row];
    cell.textLabel.text = set.exercise.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ reps x %@ lbs", set.reps, set.weight];
    return cell;
}

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.selectedExercise = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    [self performSegueWithIdentifier: @"showDetail" sender: self];
//}


@end
