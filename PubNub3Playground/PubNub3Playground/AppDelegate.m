//
//  AppDelegate.m
//  PubNub3Playground
//
//  Created by Jordan Zucker on 5/28/15.
//  Copyright (c) 2015 pubnub. All rights reserved.
//
#import <PubNub/PNImports.h>

#import "AppDelegate.h"

@interface AppDelegate () <PNDelegate>
@property (nonatomic) PubNub *client;
@property (nonatomic) PNChannel *testChannel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    usleep(100);
    self.client = [PubNub clientWithConfiguration:[PNConfiguration configurationWithPublishKey:@"demo-36" subscribeKey:@"demo-36" secretKey:nil]];
    [self.client setDelegate:self];
    self.testChannel = [PNChannel channelWithName:@"test-jordan"];
    [self.client connect];
    [self.client subscribeOn:@[self.testChannel] withClientState:@{@"jordan" : @YES}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.client updateClientState:self.client.clientIdentifier state:@{@"jordan" : @YES} forObject:testChannel withCompletionHandlingBlock:^(PNClient *client, PNError *error) {
//            NSLog(@"client: %@", client);
//            NSLog(@"error: %@", error);
//        }];
        [self.client requestClientState:self.client.clientIdentifier forObject:self.testChannel withCompletionHandlingBlock:^(PNClient *client, PNError *error) {
            NSLog(@"client: %@", client);
            NSLog(@"error: %@", error);
        }];
    });
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - PNDelegate

- (void)pubnubClient:(PubNub *)client clientStateRetrieveDidFailWithError:(PNError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client clientStateUpdateDidFailWithError:(PNError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client connectionDidFailWithError:(PNError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client didConnectToOrigin:(NSString *)origin {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client didFailMessageSend:(PNMessage *)message withError:(PNError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client didReceiveClientState:(PNClient *)remoteClient {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"client: %@", client);
    NSLog(@"remoteClient: %@", remoteClient);
    NSDictionary *testClientDict = @{@"hey" : @"ho", @"test" : @{@"test" : @"again"}};
    NSLog(@"testClientDict: %@", testClientDict);
    [self.client updateClientState:remoteClient.identifier state:testClientDict forObject:self.testChannel withCompletionHandlingBlock:^(PNClient *client, PNError *error) {
        NSLog(@"client: %@", client);
        NSLog(@"error: %@", error);
    }];
}

- (void)pubnubClient:(PubNub *)client didReceiveMessage:(PNMessage *)message {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client didRestoreSubscriptionOn:(NSArray *)channelObjects {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client didSendMessage:(PNMessage *)message {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client didSubscribeOn:(NSArray *)channelObjects {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client didUpdateClientState:(PNClient *)remoteClient {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client error:(PNError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client subscriptionDidFailWithError:(PNError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"error: %@", error);
}

- (void)pubnubClient:(PubNub *)client willConnectToOrigin:(NSString *)origin {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client willDisconnectWithError:(PNError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client willRestoreSubscriptionOn:(NSArray *)channelObjects {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pubnubClient:(PubNub *)client willSendMessage:(PNMessage *)message {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
