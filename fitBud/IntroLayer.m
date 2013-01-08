//
//  IntroLayer.m
//  fitBud
//
//  Created by Mohammod Arafat on 1/6/13.
//  Copyright CUNY City College 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "HelloWorldLayer.h"
#import "oauthMachine.h"

@interface IntroLayer()

@property (strong,nonatomic) UIWebView *googleView;
@property (strong,nonatomic) oauthMachine oauth;

@end

#pragma mark - IntroLayer
// HelloWorldLayer implementation
@implementation IntroLayer
@synthesize googleView;
@synthesize oauth;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//

- (oauthMachine *)oauth
{
    if (!_oauth) _oauth = [[oauthMachine alloc] init];
    return _oauth;
}

-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
		//	background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
    
    /*
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Announcement"
                          message: @"It turns out that you are playing Addicus!"
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];*/
    
    UIAlertView *search = [[UIAlertView alloc] initWithTitle:@"title" message:@"iGoogle" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Search", nil];
    googleView = [[UIWebView alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];

    [search addSubview:googleView];
    [search show];
    [search release];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] ]];
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *URLString = [[request URL] absoluteString];
    //detects if Oauth_verifier appears in the url
    if ([URLString rangeOfString:@"verifier"].location!= NSNotFound) {
        //possible replace here with a segue or use NSWorkspace
        NSString *goog = @"http://www.google.com";
        NSURL *googurl = [NSURL URLWithString:goog];
        NSURLRequest *googrequest = [NSURLRequest requestWithURL:googurl];
        [googleView loadRequest:googrequest];
        NSLog(URLString);
        [self.oauth requestAcessToken:URLString];
        NSLog(@"too");}
    
    return YES;
}

@end
