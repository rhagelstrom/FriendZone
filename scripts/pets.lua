--
-- Please see the license.txt file included with this distribution for
-- attribution and copyright information.
--
-- luacheck: globals AssistantGMManager HpManagerPets HpManager
-- luacheck: globals notifyAddHolderOwnership onLevelChanged levelUpCohort addCohort
-- luacheck: globals getCommanderNode addUnit addVehicle isCohort
-- luacheck: globals getControllingClient getRootCommander
local notifyAddHolderOwnershipOriginal;

function onInit()
    if AssistantGMManager then
        notifyAddHolderOwnershipOriginal = AssistantGMManager.NotifyAddHolderOwnership;
        AssistantGMManager.NotifyAddHolderOwnership = notifyAddHolderOwnership;
    end
    if Session.IsHost then
        DB.addHandler('charsheet.*.level', 'onUpdate', onLevelChanged)
    end
end

function onClose()
    if Session.IsHost then
        DB.removeHandler('charsheet.*.level', 'onUpdate', onLevelChanged)
    end
end

function onLevelChanged(nodeLevel)
    local nodeChar = nodeLevel.getChild('..');
    for _, nodeCohort in pairs(DB.getChildren(nodeChar, 'cohorts')) do
        levelUpCohort(nodeCohort);
    end
end

function addCohort(nodeChar, nodeNPC)
    local nodeCohorts = nodeChar.createChild('cohorts');
    if not nodeCohorts then
        return;
    end

    local nodeNewCohort = nodeCohorts.createChild();
    if not nodeNewCohort then
        return;
    end

    DB.copyNode(nodeNPC, nodeNewCohort);
    HpManagerPets.updateNpcHitPoints(nodeNewCohort);
    DB.setValue(nodeNewCohort, 'hptotal', 'number', DB.getValue(nodeNewCohort, 'hp', 0));
end

function addUnit(nodeChar, nodeUnit)
    local nodeUnits = nodeChar.createChild('units');
    if not nodeUnits then
        return;
    end

    local nodeNewUnit = nodeUnits.createChild();
    if not nodeNewUnit then
        return;
    end

    DB.copyNode(nodeUnit, nodeNewUnit);

    DB.setValue(nodeNewUnit, 'commander', 'string', DB.getValue(nodeChar, 'name', ''));
end

function addVehicle(nodeChar, nodeVehicle)
    local nodeVehicles = nodeChar.createChild('vehicles');
    if not nodeVehicles then
        return;
    end

    local nodeNewVehicle = nodeVehicles.createChild();
    if not nodeNewVehicle then
        return;
    end

    DB.copyNode(nodeVehicle, nodeNewVehicle);
end

function isCohort(vRecord)
    local rActor = ActorManager.resolveActor(vRecord);
    if rActor and rActor.sCreatureNode and
        (rActor.sCreatureNode:match('%.cohorts%.') or rActor.sCreatureNode:match('%.vehicles%.')) then
        return true;
    end

    return false;
end

function notifyAddHolderOwnership(node, sUserName, bOwner, bForceAccessRemoval)
    local rActor = ActorManager.resolveActor(node);
    if isCohort(rActor) then
        if bOwner then
            ChatManager.SystemMessage(Interface.getString('assistant_gm_cohort_ownership'));
        end
    else
        notifyAddHolderOwnershipOriginal(node, sUserName, bOwner, bForceAccessRemoval);
    end
end

function getCommanderNode(vCohort)
    local nodeCohort = ActorManager.getCreatureNode(vCohort);
    return DB.getChild(nodeCohort, '...');
end

function levelUpCohort(nodeCohort)
    if HpManager then
        HpManager.updateNpcHitDice(nodeCohort);
    end
    HpManagerPets.updateNpcHitPoints(nodeCohort);
end

--Returns nil for inactive identities and those owned by the GM
function getControllingClient(nodeCT)
    if not nodeCT then
        Debug.console("Pets.getControllingClient - nodeCT doesn't exist")
        return
    end
    local sPCNode = nil;
    local rActor = ActorManager.resolveActor(nodeCT);
    local sNPCowner
    if ActorManager.isPC(rActor) then
        sPCNode = ActorManager.getCreatureNodeName(rActor);
    else
        sNPCowner = DB.getValue(nodeCT, "NPCowner", "");
        if sNPCowner == "" then
            sPCNode = getRootCommander(rActor);
        end
    end

    if sPCNode or sNPCowner then
        for _, value in pairs(User.getAllActiveIdentities()) do
            if sPCNode then
                if "charsheet." .. value == sPCNode then
                    return User.getIdentityOwner(value)
                    --return DB.getOwner(sPCNode);
                end
            end
            if sNPCowner then
                local sIDOwner = User.getIdentityOwner(value)
                if sIDOwner == sNPCowner then
                    return sIDOwner
                end
            end
        end
    end
    return nil;
end

---For a given cohort actor, determine the root character node that owns it
function getRootCommander(rActor)
    if not rActor then
        Debug.console("Pets.getRootCommander - rActor doesn't exist")
        return
    end
    local sRecord = ActorManager.getCreatureNodeName(rActor);
    local sRecordSansModule = StringManager.split(sRecord, "@")[1];
    local aRecordPathSansModule = StringManager.split(sRecordSansModule, ".");
    if aRecordPathSansModule[1] and aRecordPathSansModule[2] then
        return aRecordPathSansModule[1] .. "." .. aRecordPathSansModule[2];
    end
    return nil;
end