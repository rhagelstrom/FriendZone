--
-- Please see the license.txt file included with this distribution fo
-- attribution and copyright information.
--
-- luacheck: globals Pets HpManager
-- luacheck: globals onLinkChanged linkNPCOrVehicleFields

function onInit()
	super.onInit();
	onLinkChanged(); -- call the overload.
end

function onLinkChanged()
	-- If a cohort NPC, then set up the links
	local sClass, sRecord = link.getValue();
	if Pets.isCohort(sRecord) then
		if sClass == "npc" or sClass == "vehicle" then
			linkNPCOrVehicleFields();
		end
		name.setLine(false);
	end

	super.onLinkChanged();
end

function linkNPCOrVehicleFields()
	local nodeChar = link.getTargetDatabaseNode();
	if nodeChar then
		self.name.setLink(nodeChar.createChild("name", "string"), true);
		self.senses.setLink(nodeChar.createChild("senses", "string"), true);

		if HpManager then
			self.hp.setLink(nodeChar.createChild("hp", "number"));
			self.hptotal.setLink(nodeChar.createChild("hptotal", "number"));
			self.hpadjust.setLink(nodeChar.createChild("hpadjust", "number"));
		else
			hptotal.setLink(nodeChar.createChild("hp", "number"));
		end
		self.hptemp.setLink(nodeChar.createChild("hptemp", "number"));
		self.wounds.setLink(nodeChar.createChild("wounds", "number"));
		self.deathsavesuccess.setLink(nodeChar.createChild("deathsavesuccess", "number"));
		self.deathsavefail.setLink(nodeChar.createChild("deathsavefail", "number"));

		self.type.setLink(nodeChar.createChild("race", "string"));
		self.size.setLink(nodeChar.createChild("size", "string"));
		self.alignment.setLink(nodeChar.createChild("alignment", "string"));

		self.strength.setLink(nodeChar.createChild("abilities.strength.score", "number"), true);
		self.dexterity.setLink(nodeChar.createChild("abilities.dexterity.score", "number"), true);
		self.constitution.setLink(nodeChar.createChild("abilities.constitution.score", "number"), true);
		self.intelligence.setLink(nodeChar.createChild("abilities.intelligence.score", "number"), true);
		self.wisdom.setLink(nodeChar.createChild("abilities.wisdom.score", "number"), true);
		self.charisma.setLink(nodeChar.createChild("abilities.charisma.score", "number"), true);

		if CombatManagerTF then
			self.init.setLink(nodeChar.createChild("init", "number"), true);
		else
			self.init.setLink(nodeChar.createChild("abilities.dexterity.bonus", "number"), true);
		end
		self.ac.setLink(nodeChar.createChild("ac", "number"), true);
		self.damagethreshold.setLink(nodeChar.createChild("damagethreshold", "number"), true);
		self.speed.setLink(nodeChar.createChild("speed", "string"), true);

		self.damagevulnerabilities.setLink(nodeChar.createChild("damagevulnerabilities", "string"), true);
		self.damageresistances.setLink(nodeChar.createChild("damageresistances", "string"), true);
		self.damageimmunities.setLink(nodeChar.createChild("damageimmunities", "string"), true);
		self.conditionimmunities.setLink(nodeChar.createChild("conditionimmunities", "string"), true);
	end
end