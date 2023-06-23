﻿-- Destroy junk items and filter out bot messages
-- written by X'Genesis Qhulut
-- November 2022

-- This destroys "gray" (poor quality) items in your bags (not your backpack)
-- plus items listed below in otherJunk which tend to drop in instances but are
-- effectively junk when I am trying to fill up my bags with blue/green items.

-- It destroys a maximum of 5 items, so if you are close to a vendor you don't throw away
-- a lot of stuff that might make a few gold.

local YELLOW_TEXT = '|cFFFFFF00' -- (format is |caarrggbb where aa is alpha and should be FF)
-- to detect poor quality items
local GREY_COLOUR = "ff9d9d9d"

-- Normal (quality 1) items to also destroy.
-- These are Lua patterns however we add ^ to the start and $ to the end for you.

local otherJunk = {
  "Tender Wolf Meat",
  "Red Wolf Meat",
 -- "Roasted Quail",
  "Morning Glory Dew",  -- not at level 45
  "Cured Ham Steak",
  "Wicked Claw",
  "Coal",  -- needed for Thorium Brotherhood
  -- "Scroll of [SIP]%a+ [IXV]+",  -- Stamina, Strength, Intellect, Protection, Spirit -- exclude "Mizrael"
  "Slimy Murloc Scale",
  "Murloc Fin",
 -- "Murloc Eye",
  "Shiny Fish Scales",
  "Flask of Oil",
  "Fish Oil",
--  "Boar Intestines",
  "Delicious Cave Mold",
  "Mystery Meat",
  "Raw Black Truffle",
  "Fine Aged Cheddar",
  "Dried King Bolete",
-- "Nightcrawlers",
  "Homemade Cherry Pie",
  "Red Wolf Meat",
  "Black Diamond",
  "Soft Banana Bread",
  "Unadorned Seal of Ascension",

  -- add more here


} -- end of otherJunk

-- trim leading and trailing spaces from a string
local function trim (s)
  return (string.gsub (s, "^%s*(.-)%s*$", "%1"))
end -- trim

-- make a print function to simplify sending messages
local function print(...)
  -- ensure all arguments are strings
  -- we do it without using ipairs because that stops on the first nil
  -- but the nil is still in the table which makes table.concat fail
  -- (in case nil is an argument to the print function)
  for i = 1, table.getn (arg) do
    arg [i] = tostring (arg [i])    -- ensure a string
  end -- for

  -- contcatenate them with a space inbetween
  local s = table.concat (arg, " ")

  -- show them in purple
  DEFAULT_CHAT_FRAME:AddMessage(s, 1.0, 0.2, 0.55)
end -- print



function destroyJunk()
  local count = 0
	for bag = 0, 4 do  -- 0 is backpack, 1 to 4 is each of the 4 bags
  	local slots = GetContainerNumSlots(bag)  -- find how many slots in container
		if slots then
			for slot = 1, slots do
        local texture, itemCount, locked, quality = GetContainerItemInfo(bag, slot)
        -- quality will be nil if there is no item in that slot
        if quality then
          local itemLink = GetContainerItemLink(bag, slot)
          local _, _, colour, linkType, itemID = string.find (itemLink, "^|c(%x+)|?H?([^:]+):(%d+)")
          -- some stuff like "Dripping Spider Mandible" had a quality of -1 for some reason
          local _, _, name = string.find (itemLink, "|h%[(.-)%]|")
          -- check other items if quality white or less
          if quality <= 1 then
            for k, v in ipairs (otherJunk) do
              if string.find (name, "^" .. v .. "$") then
                quality = 0
                break  -- done with checking names
              end -- if match found
            end -- for
          end -- if
          if (quality == 0 or  -- poor quality
             (quality == -1 and colour == GREY_COLOUR and linkType == "item"))
            and count < 5  -- only destroy 5 at a time to save money
            then  -- if poor quality
            --print ("Link is ", string.gsub (itemLink, "|", "`"))
            print ("Destroying " .. itemLink)
            PickupContainerItem(bag, slot)
            DeleteCursorItem()
            count = count + 1
            if count >= 5 then
              print ("Destroyed 5 items, stopping now.")
            end -- if done 5 items
          end  -- if poor quality
        end -- if item in slot
      end -- for each slot
		end  -- if container exists
	end -- for each container
  local s = 's'
  if count == 1 then
    s = ''
  end -- if
  print (count .. " junk item" .. s .. " destroyed.")
  if count <= 0 then  -- if nothing destroyed, warn them
    PlaySound ("igPVPUpdate")
  end -- if
  end  -- function destroyJunk

local function slashHandler (msg)
  if msg and msg ~= "" then
    msg = trim (string.lower (msg))

    if msg == "destroy" then
      local result, err = pcall (destroyJunk)
      if not result then
        print (YELLOW_TEXT .. "Error in destroyJunk: " .. err)
      end -- if failure
    else
      print ("Did not recognise slash command: " .. msg)
    end
  end -- if have a message

end -- slashHandler

-- ---------------------------------------------------------------
--  START HERE
-- ---------------------------------------------------------------

function DestroyJunkInit()
  -- set up a slash command handler
  SLASH_DESTROYJUNK1 = "/dj"
  SlashCmdList["DESTROYJUNK"] = slashHandler
  print ("To destroy your junk:  /dj destroy")
end -- end of DestroyJunkInit

