//
//  ExerciseDetailTableViewController.h
//  Reps
//
//  Created by Gabriel Carrillo on 12/28/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Exercise;

@interface ExerciseDetailTableViewController : UITableViewController

@property (nonatomic, strong) Exercise *exercise;

@end
