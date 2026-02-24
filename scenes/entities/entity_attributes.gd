class_name EntityAttributes extends AttributeSet

@export var strength: Attribute
@export var agility: Attribute
@export var intelligence: Attribute
@export var willpower: Attribute
@export var fortitude: Attribute
@export var charisma: Attribute

static func create(values: Dictionary[String, int]) -> EntityAttributes:
	var entity_attributes: EntityAttributes = EntityAttributes.new()
	entity_attributes.strength = Attribute.create("strength", Data.dict_get_or_default(values, "strength", 0))
	entity_attributes.agility = Attribute.create("agility", Data.dict_get_or_default(values, "agility", 0))
	entity_attributes.intelligence = Attribute.create("intelligence", Data.dict_get_or_default(values, "intelligence", 0))
	entity_attributes.willpower = Attribute.create("willpower", Data.dict_get_or_default(values, "willpower", 0))
	entity_attributes.fortitude = Attribute.create("fortitude", Data.dict_get_or_default(values, "fortitude", 0))
	entity_attributes.charisma = Attribute.create("charisma", Data.dict_get_or_default(values, "charisma", 0))
	breakpoint
	return entity_attributes


static func default() -> EntityAttributes:
	var entity_attributes: EntityAttributes = EntityAttributes.new()
	entity_attributes.strength = Attribute.create("strength", 0)
	entity_attributes.agility = Attribute.create("agility", 0)
	entity_attributes.intelligence = Attribute.create("intelligence", 0)
	entity_attributes.willpower = Attribute.create("willpower", 0)
	entity_attributes.fortitude = Attribute.create("fortitude", 0)
	entity_attributes.charisma = Attribute.create("charisma", 0)
	return entity_attributes

func to_dict() -> Dictionary[String, int]:
	return {
		"strength": strength.value,
		"agility": agility.value,
		"intelligence": intelligence.value,
		"willpower": willpower.value,
		"fortitude": fortitude.value,
		"charisma": charisma.value
	}
