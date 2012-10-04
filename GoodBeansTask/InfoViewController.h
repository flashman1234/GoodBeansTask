//
//  InfoViewController.h
//  GoodBeansTask
//
//  Created by Michal Thompson on 10/4/12.
//  Copyright (c) 2012 Michal Thompson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)moc;

@end
