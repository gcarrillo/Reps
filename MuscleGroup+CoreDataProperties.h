//
//  MuscleGroup+CoreDataProperties.h
//  Reps
//
//  Created by Gabriel Carrillo on 12/20/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MuscleGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface MuscleGroup (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Exercise *> *exercises;
@property (nullable, nonatomic, retain) NSManagedObject *bodyArea;

@end

@interface MuscleGroup (CoreDataGeneratedAccessors)

- (void)addExercisesObject:(Exercise *)value;
- (void)removeExercisesObject:(Exercise *)value;
- (void)addExercises:(NSSet<Exercise *> *)values;
- (void)removeExercises:(NSSet<Exercise *> *)values;

@end

NS_ASSUME_NONNULL_END
