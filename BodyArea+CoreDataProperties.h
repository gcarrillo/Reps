//
//  BodyArea+CoreDataProperties.h
//  Reps
//
//  Created by Gabriel Carrillo on 12/20/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BodyArea.h"

NS_ASSUME_NONNULL_BEGIN

@interface BodyArea (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<MuscleGroup *> *muscleGroups;

@end

@interface BodyArea (CoreDataGeneratedAccessors)

- (void)addMuscleGroupsObject:(MuscleGroup *)value;
- (void)removeMuscleGroupsObject:(MuscleGroup *)value;
- (void)addMuscleGroups:(NSSet<MuscleGroup *> *)values;
- (void)removeMuscleGroups:(NSSet<MuscleGroup *> *)values;

@end

NS_ASSUME_NONNULL_END
