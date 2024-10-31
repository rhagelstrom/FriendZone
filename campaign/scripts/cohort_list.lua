--
-- Please see the license.txt file included with this distribution fo
-- attribution and copyright information.
--
-- luacheck: globals addEntry createWindow

function addEntry(bFocus)
	local w = createWindow();
	if bFocus then
		w.name.setFocus();
	end
	return w;
end
