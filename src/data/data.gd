class_name Data extends RefCounted

## Gets the provided prop value from a dictionary if available, or return a provided default
##
## WARN: This feels like it could be pretty expensive. Probably only good for initialization of big dictionaries
static func dict_get_or_default(dictionary: Dictionary, prop: String, default):
	var v = dictionary.get(prop)
	return v if v != null else default
