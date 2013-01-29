#import "cocos2d.h"

@interface MaskTo : IntervalAction <NSCopying>
{
	CGRect endRect;
	CGRect startRect;
	CGRect delta;
}
/** creates the action */
+(id) actionWithDuration:(ccTime)duration rect:(CGRect)rect;
/** initializes the action */
-(id) initWithDuration:(ccTime)duration rect:(CGRect)rect;
@end