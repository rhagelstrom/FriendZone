--
-- Please see the license.txt file included with this distribution fo
-- attribution and copyright information.
--
-- luacheck: globals onActiveChanged onSectionChanged
function onInit()
    if super and super.onInit then
        super.onInit();
    end
    -- Set up the PC links
    if super and super.onFactionChanged then
        super.onFactionChanged();
    end
end

function onActiveChanged()
    if super and super.onActiveChanged then
        super.onActiveChanged();
    end
    self.onSectionChanged("active", true);
end

--
--    SECTION HANDLING
--

function onSectionChanged(sKey, bTurnChanged)
    if bTurnChanged and (sKey == "active") then
        if Pets.getControllingClient(getDatabaseNode()) == Session.UserName then
            local cButton = self["button_section_" .. sKey];
            if self.isActive() then
                cButton.setValue(1);
            else
                cButton.setValue(0);
            end
        end
    end
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
