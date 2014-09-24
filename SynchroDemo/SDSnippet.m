#import "SDSnippet.h"

@interface SDSnippet ()
@end

@implementation SDSnippet

@synthesize string;

+ (ETEntityDescription*)newEntityDescription
{
  ETEntityDescription *entity = [ETEntityDescription descriptionWithName: @"SDSnippet"];
  [entity setParent: (id)@"COObject"];
  ETPropertyDescription *string = [ETPropertyDescription descriptionWithName: @"string" type: (id)@"COAttributedString"];
  [string setPersistent: YES];
  [entity setPropertyDescriptions: @[string]];
  return entity;
}

- (instancetype)initWithObjectGraphContext:(COObjectGraphContext *)context
{
  self = [super initWithObjectGraphContext: context];
  string = [[COAttributedString alloc] initWithObjectGraphContext: context];
  return self;
}

@end

