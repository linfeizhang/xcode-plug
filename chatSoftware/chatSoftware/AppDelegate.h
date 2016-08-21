//
//  AppDelegate.h
//  chatSoftware
//
//  Created by zhanglf on 16/3/24.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,XMPPStreamDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@property (nonatomic, assign) BOOL regist;
@property (nonatomic, strong, readonly) XMPPStream * xmppStream;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) FMDatabase * db;

- (BOOL)connectWithUsername:(NSString *)uname password:(NSString *)upass;

- (void)disconnect;

- (void)sendMessage:(NSString *)_msg to:(NSString *)_to;



















@end

