//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPJID

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark XMPPJID Class

//-----------------------------------------------------------------------------------------------------------------------------------
+ (BOOL)validateUser:(NSString *)user domain:(NSString *)domain resource:(NSString *)resource {
	// Domain is the only required part of a JID
	if((domain == nil) || ([domain length] == 0)) return NO;
	
	// If there's an @ symbol in the domain it probably means user put @ in their username
	NSRange invalidAtRange = [domain rangeOfString:@"@"];
	if(invalidAtRange.location != NSNotFound) return NO;
	
	// Can't use an empty string resource name
	if((resource != nil) && ([resource length] == 0)) return NO;
	
	return YES;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (BOOL)parse:(NSString*)jidStr outUser:(NSString**)user outDomain:(NSString**)domain outResource:(NSString**)resource {
	*user = nil;
	*domain = nil;
	*resource = nil;
	
	NSString *rawUser = nil;
	NSString *rawDomain = nil;
	NSString *rawResource = nil;
	
	NSRange atRange = [jidStr rangeOfString:@"@"];
	
	if(atRange.location != NSNotFound) {
		rawUser = [jidStr substringToIndex:atRange.location];
		
		NSString *minusUser = [jidStr substringFromIndex:atRange.location+1];
		
		NSRange slashRange = [minusUser rangeOfString:@"/"];
		
		if(slashRange.location != NSNotFound)
		{
			rawDomain = [minusUser substringToIndex:slashRange.location];
			rawResource = [minusUser substringFromIndex:slashRange.location+1];
		}
		else
		{
			rawDomain = minusUser;
		}
	} else {
		NSRange slashRange = [jidStr rangeOfString:@"/"];
				
		if(slashRange.location != NSNotFound)
		{
			rawDomain = [jidStr substringToIndex:slashRange.location];
			rawResource = [jidStr substringFromIndex:slashRange.location+1];
		}
		else
		{
			rawDomain = jidStr;
		}
	}
	
	if([XMPPJID validateUser:rawUser domain:rawDomain resource:rawResource]) {
		*user = rawUser;
		*domain = rawDomain;
		*resource = rawResource;
		
		return YES;
	}
	
	return NO;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPJID*)jidWithString:(NSString*)jidStr {
	NSString *user;
	NSString *domain;
	NSString *resource;
	
	if([XMPPJID parse:jidStr outUser:&user outDomain:&domain outResource:&resource]) {
		XMPPJID *jid = [[XMPPJID alloc] init];
		jid->user = [user copy];
		jid->domain = [domain copy];
		jid->resource = [resource copy];
		
		return [jid autorelease];
	}
	
	return nil;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPJID*)jidWithString:(NSString*)jidStr resource:(NSString*)resource
{
	NSString *user;
	NSString *domain;
	NSString *ignore;
	
	if([XMPPJID parse:jidStr outUser:&user outDomain:&domain outResource:&ignore]) {
		XMPPJID *jid = [[XMPPJID alloc] init];
		jid->user = [user copy];
		jid->domain = [domain copy];
		jid->resource = [resource copy];
		
		return [jid autorelease];
	}
	
	return nil;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (XMPPJID*)jidWithUser:(NSString*)user domain:(NSString*)domain resource:(NSString*)resource
{
	if([XMPPJID validateUser:user domain:domain resource:resource]) {
		XMPPJID *jid = [[XMPPJID alloc] init];
		jid->user = [user copy];
		jid->domain = [domain copy];
		jid->resource = [resource copy];
		
		return [jid autorelease];
	}
	
	return nil;
}

//===================================================================================================================================
#pragma mark Normal Methods:

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)user {
	return user;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)domain {
	return domain;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)resource
{
	return resource;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (XMPPJID*)bareJID {
	if(resource == nil) {
		return [[self retain] autorelease];
	}
	else {
		return [XMPPJID jidWithUser:user domain:domain resource:nil];
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)bare {
	if(user)
		return [NSString stringWithFormat:@"%@@%@", user, domain];
	else
		return domain;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString *)full {
	if(user) {
		if(resource)
			return [NSString stringWithFormat:@"%@@%@/%@", user, domain, resource];
		else
			return [NSString stringWithFormat:@"%@@%@", user, domain];
	} else {
		if(resource)
			return [NSString stringWithFormat:@"%@/%@", domain, resource];
		else
			return domain;
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)pubSubRoot {
    return [NSString stringWithFormat:@"/home/%@/%@", [self domain], [self user]];	
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)pubSubDomain {
    return [NSString stringWithFormat:@"/home/%@", [self domain]];	
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
#if MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_4
- (unsigned)hash {
	return [[self full] hash];
}
#else

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSUInteger)hash {
	return [[self full] hash];
}
#endif

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)isEqual:(id)anObject {
	if([anObject isMemberOfClass:[self class]])
	{
		XMPPJID *aJID = (XMPPJID *)anObject;
		
		return [[self full] isEqualToString:[aJID full]];
	}
	return NO;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSString*)description {
	return [self full];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
	[user release];
	[domain release];
	[resource release];
	[super dealloc];
}

@end
