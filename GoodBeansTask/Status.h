//
//  Status.h
//  GoodBeansTask
//
//  Created by Michal Thompson on 10/4/12.
//  Copyright (c) 2012 Michal Thompson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Status : NSManagedObject

@property (nonatomic, retain) NSString * currentViewController;
@property (nonatomic, retain) NSString * selectedPersonObjectId;

@end
