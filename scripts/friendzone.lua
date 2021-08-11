--todo cleanup
--add list for npcs on charsheet
	--what should each item look like? PS as template?
	--what about temporary summons?
		--conentratrion consideration?
		--and those that get angry?
--add summon spell type
	--distinguish between charsheet (summon individual) and record (summon instance)
		--prevent... something? (finish your notes man)
	--for instance, add to list?
--add npc linking
	--account for cohort spell slots
	--mulitples and naming?
--add handler for PB changing
	--add support for NPC stats that use PB
--add extra hp fields to cohort?
	--or use charsheet
		--CR vs lvl?

local onShortcutDropOriginal;

function onInit()
	if Session.IsHost then
		-- todo move to specific manager
		CharacterListManager.registerDropHandler(onShortcutDrop);
		onShortcutDropOriginal = CharacterListManager.onShortcutDrop;
		CharacterListManager.onShortcutDrop = onShortcutDrop;
	end
end

function onShortcutDrop(sIdentity, draginfo)
	--todo stuff i need
	local sClass, sRecord = draginfo.getShortcutData();
	local nodeSource = draginfo.getDatabaseNode();
	if nodesource and (sClass == "npc") then

	end

	return onShortcutDropOriginal(sIdentity, draginfo);
end

function addCohort(nodeChar, nodeNPC)
	local nodeCohorts = nodeChar.createChild("cohorts");
	if not nodeCohorts then
		return;
	end

	local nodeNewCohort = nodeCohorts.createChild();
	if not nodeNewCohort then
		return;
	end

	DB.copyNode(nodeNPC, nodeNewCohort);

	--todo stats
	-- DB.setValue(nodeNewCohort, "hp.total", "number", DB.getValue(nodeNewCohort, "hp", 0));
	--hp
	--ac
	--speed
	--??
end

function addUnit(nodeChar, nodeUnit)
	local nodeUnits = nodeChar.createChild("units");
	if not nodeUnits then
		return;
	end

	local nodeNewUnit = nodeUnits.createChild();
	if not nodeNewUnit then
		return;
	end

	DB.copyNode(nodeUnit, nodeNewUnit);

	DB.setValue(nodeNewUnit, "commander", "string", DB.getValue(nodeChar, "name", ""));
end

function isCohort(vRecord)
	if not vRecord then
		return false;
	end

	local sType = type(vRecord);
	if sType == "databasenode" then
		return StringManager.startsWith(vRecord.getPath(), "charsheet");
	elseif sType == "string" then
		return StringManager.startsWith(vRecord, "charsheet");
	else
		return false;
	end
end