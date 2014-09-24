#import "SDEditor.h"
#import "SDSnippet.h"

@interface SDEditor ()
@property (strong) COAttributedStringWrapper *storage;
@property (assign) IBOutlet NSTextView *view;
@end

@implementation SDEditor

@synthesize context;
@synthesize storage;
@synthesize view;

- (instancetype)initWithPath:(NSString *)path
{
  self = [super initWithWindowNibName: @"SDEditor"];
  context = [COEditingContext contextWithURL:[NSURL fileURLWithPath:path]];
  if ([[context persistentRoots] count] == 0)
  {
    [context insertNewPersistentRootWithEntityName: @"SDSnippet"];
    [context commit];
  }
  return self;
}

- (COPersistentRoot *)root
{
  return [[context persistentRoots] anyObject];
}

- (COBranch *)branch
{
  return [[self root] currentBranch];
}

- (SDSnippet *)snippet
{
  return [[self root] rootObject];
}

- (void)windowDidLoad
{
  NSLog(@"Initial string: %@", [[[self snippet] string] string]);
  storage = [[COAttributedStringWrapper alloc] initWithBacking: [[self snippet] string]];
  [[[view textContainer] layoutManager] replaceTextStorage:storage];
  [view setDelegate:self];
}

- (IBAction)commit:(id)sender
{
  NSLog(@"Commiting");
  [context commit];
}

@end
