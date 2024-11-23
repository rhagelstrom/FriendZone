--
-- Please see the license.txt file included with this distribution for
-- attribution and copyright information.
--
-- luacheck: globals setCommanderProfBonus getCommanderProfBonus

local nCommanderProfBonus = 0;

function setCommanderProfBonus(nProfBonus)
    nCommanderProfBonus = nProfBonus;
end

function getCommanderProfBonus()
    local nReturn = nCommanderProfBonus;
    nCommanderProfBonus = 0;
    return nReturn;
end
