#import "CoreObject/CoreObject.h"
#import "CoreObject/COAttributedString.h"

@interface SDSnippet : COObject
@property (nonatomic, readwrite, retain) COAttributedString *string;
@end
