--
-- Please see the license.txt file included with this distribution fo
-- attribution and copyright information.
--
-- luacheck: globals onIDChanged onFactionChanged onActiveChanged updateDisplay getRecordType isRecordType
-- luacheck: globals isPC isActive getSectionToggle onSectionChanged
function onInit()
    -- Show active section, if combatant is active
    self.onActiveChanged();

    -- Set up the PC links
    self.onFactionChanged();
end

function onIDChanged()
    local nodeRecord = getDatabaseNode();
    local sClass = link.getValue();
    local sRecordType = RecordDataManager.getRecordTypeFromDisplayClass(sClass);
    local bID = RecordDataManager.getIDState(sRecordType, nodeRecord, true);

    name.setVisible(bID);
    nonid_name.setVisible(not bID); --luacheck: ignore 143

    self.onActiveChanged();
end
function onFactionChanged()
    -- Update the entry frame
    self.updateDisplay();
end
--function onVisibilityChanged()
--    TokenManager.updateVisibility(getDatabaseNode());
--    windowlist.onVisibilityToggle();
--end
function onActiveChanged()
    self.updateDisplay();
end

function updateDisplay()
    local sFaction = friendfoe.getStringValue();

    if initresult then
        local sOptCTSI = OptionsManager.getOption("CTSI");
        local bShowInit = ((sOptCTSI == "friend") and (sFaction == "friend")) or (sOptCTSI == "on");
        initresult.setVisible(bShowInit);
    end

    if active.getValue() == 1 then
        name.setFont("sheetlabel");
        nonid_name.setFont("sheetlabel"); --luacheck: ignore 143

        active_spacer_top.setVisible(true);
        active_spacer_bottom.setVisible(true);

        if sFaction == "friend" then
            setFrame("ctentrybox_friend_active"); --luacheck: ignore 113
        elseif sFaction == "neutral" then
            setFrame("ctentrybox_neutral_active"); --luacheck: ignore 113
        elseif sFaction == "foe" then
            setFrame("ctentrybox_foe_active"); --luacheck: ignore 113
        else
            setFrame("ctentrybox_active"); --luacheck: ignore 113
        end

        windowlist.scrollToWindow(self);
    else
        name.setFont("sheettext");
        nonid_name.setFont("sheettext"); --luacheck: ignore 143

        active_spacer_top.setVisible(false);
        active_spacer_bottom.setVisible(false);

        if sFaction == "friend" then
            setFrame("ctentrybox_friend"); --luacheck: ignore 113
        elseif sFaction == "neutral" then
            setFrame("ctentrybox_neutral"); --luacheck: ignore 113
        elseif sFaction == "foe" then
            setFrame("ctentrybox_foe"); --luacheck: ignore 113
        else
            setFrame("ctentrybox"); --luacheck: ignore 113
        end
    end
end

--
--    HELPERS
--

function getRecordType()
    local sClass = link.getValue();
    return RecordDataManager.getRecordTypeFromDisplayClass(sClass);
end
function isRecordType(s)
    return (self.getRecordType() == s);
end
function isPC()
    return self.isRecordType("charsheet");
end
function isActive()
    return (active.getValue() == 1);
end

--
--    SECTION HANDLING
--

function getSectionToggle(sKey)
    local bResult = false;

    local sButtonName = "button_section_" .. sKey;
    local cButton = self[sButtonName];
    if cButton then
        bResult = (cButton.getValue() == 1);
    end

    return bResult;
end
function onSectionChanged(sKey)
    local bShow = self.getSectionToggle(sKey);

    local sSectionName = "sub_" .. sKey;
    local cSection = self[sSectionName];
    if cSection then
        if bShow then
            local sSectionClassByRecord
            if sKey == "effects" then
                sSectionClassByRecord = string.format("client_ct_section_%s_%s", sKey, self.getRecordType());
                if Interface.isWindowClass(sSectionClassByRecord) then
                    cSection.setValue(sSectionClassByRecord, getDatabaseNode());
                else
                    local sSectionClass = "client_ct_section_" .. sKey;
                    cSection.setValue(sSectionClass, getDatabaseNode());
                end
            else
                sSectionClassByRecord = string.format("ct_section_%s_%s", sKey, self.getRecordType());
                if Interface.isWindowClass(sSectionClassByRecord) then
                    cSection.setValue(sSectionClassByRecord, getDatabaseNode());
                else
                    local sSectionClass = "ct_section_" .. sKey;
                    cSection.setValue(sSectionClass, getDatabaseNode());
                end
            end
        else
            cSection.setValue("", "");
        end
        cSection.setVisible(bShow);
    end

    local sSummaryName = "summary_" .. sKey;
    local cSummary = self[sSummaryName];
    if cSummary then
        cSummary.onToggle();
    end
end
