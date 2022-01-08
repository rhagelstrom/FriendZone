-- 
-- Please see the license.txt file included with this distribution for 
-- attribution and copyright information.
--

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

local onShortcutDropOriginal;
local notifyAddHolderOwnershipOriginal;

function onInit()
	if AssistantGMManager then
		notifyAddHolderOwnershipOriginal = AssistantGMManager.NotifyAddHolderOwnership;
		AssistantGMManager.NotifyAddHolderOwnership = notifyAddHolderOwnership;
	end
	if Session.IsHost then
		DB.addHandler("charsheet.*.level", "onUpdate", onLevelChanged)
	end
end

function onClose()
	if Session.IsHost then
		DB.removeHandler("charsheet.*.level", "onUpdate", onLevelChanged)
	end
end


function onLevelChanged(nodeLevel)
	local nodeChar = nodeLevel.getChild("..");
	for _,nodeCohort in pairs(DB.getChildren(nodeChar, "cohorts")) do
		levelUpCohort(nodeCohort);
	end
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
	HpManagerFZ.updateNpcHitPoints(nodeNewCohort);
	DB.setValue(nodeNewCohort, "hptotal", "number", DB.getValue(nodeNewCohort, "hp", 0));
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
	local rActor = ActorManager.resolveActor(vRecord);
	if rActor and rActor.sCreatureNode and rActor.sCreatureNode:match("%.cohorts%.") then
		return true;
	end

	return false;
end

function notifyAddHolderOwnership(node, sUserName, bOwner, bForceAccessRemoval)
	local rActor = ActorManager.resolveActor(node);
	if isCohort(rActor) then
		if bOwner then
			ChatManager.SystemMessage(Interface.getString("assistant_gm_cohort_ownership"));
		end
	else
		notifyAddHolderOwnershipOriginal(node, sUserName, bOwner, bForceAccessRemoval);
	end
end

function getCommanderNode(vCohort)
	local nodeCohort = ActorManager.getCreatureNode(vCohort);
	return DB.getChild(nodeCohort, "...");
end

function levelUpCohort(nodeCohort)
	if HpManager then
		HpManager.updateNpcHitDice(nodeCohort);
	end
	HpManagerFZ.updateNpcHitPoints(nodeCohort);
end