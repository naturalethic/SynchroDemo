#import "SDApplication.h"

@interface SDApplication ()
@property (strong) SDEditor *editorOne;
@property (strong) SDEditor *editorTwo;
@property (strong) COSynchronizerClient *client;
@property (strong) COSynchronizerServer *server;
@end

@implementation SDApplication
@synthesize editorOne;
@synthesize editorTwo;
@synthesize client;
@synthesize server;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  int top = [[[NSScreen screens] objectAtIndex:0] frame].size.height - 100;
  editorOne = [[SDEditor alloc] initWithPath:@"editorOne"];
  editorTwo = [[SDEditor alloc] initWithPath:@"editorTwo"];
  [[editorOne window] setTitle:@"Editor One"];
  [[editorTwo window] setTitle:@"Editor Two"];
  [[editorOne window] setFrameTopLeftPoint:NSMakePoint(400, top)];
  [[editorTwo window] setFrameTopLeftPoint:NSMakePoint(1020, top)];
  [[editorTwo window] orderFrontRegardless];
  [[editorOne window] makeKeyAndOrderFront:nil];
  client = [[COSynchronizerClient alloc] initWithClientID:@"client" editingContext:[editorTwo context]];
  server = [[COSynchronizerServer alloc] initWithBranch:[editorOne branch]];
  [server setDelegate:self];
  [client setDelegate:self];
  [server addClientID:@"client"];
}

- (void)sendPersistentRootInfoMessage: (COSynchronizerPersistentRootInfoToClientMessage *)message toClient:(NSString *)jabberId
{
  NSLog(@"Server Root [%@]: %@", jabberId, message);
  [client handleSetupMessage:message];
}

- (void)sendResponseMessage: (COSynchronizerResponseToClientForSentRevisionsMessage *)message toClient:(NSString *)jabberId
{
  NSLog(@"Server Response [%@]: %@", jabberId, message);
  [client handleResponseMessage:message];
}

- (void)sendPushedRevisions: (COSynchronizerPushedRevisionsToClientMessage *)message toClients:(NSArray *)jabberIds
{
  NSLog(@"Server Pushed [%@]: %@", [jabberIds objectAtIndex:0], message);
  [client handlePushMessage:message];
}

- (void)sendPushToServer:(COSynchronizerPushedRevisionsFromClientMessage *)message
{
  NSLog(@"Client Push: %@", message);
  [server handlePushedRevisionsFromClient:message];
}

@end
