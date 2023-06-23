# DestroyJunk

## Purpose

This is intended for when you are running dungeons on Vanilla (or Classic) WoW - and your bags are filling up with useless
junk that is taking room that you want for "green" or "blue" items.

---

## How to use

Just install this and then type:

```
/dj destroy
```

Without warning, gray (poor quality) items, **and** ones listed in the DestroyJunk.lua file will be destroyed. They cannot be retrieved.

---

## Extra junk that will be destroyed

The list of "white" items that are also destroyed looks like this:

```lua
local otherJunk = {
  "Tender Wolf Meat",
  "Red Wolf Meat",
 -- "Roasted Quail",
  "Morning Glory Dew",  -- not at level 45
  "Cured Ham Steak",
  "Wicked Claw",
  "Coal",  -- warning, needed for Thorium Brotherhood
  -- "Scroll of [SIP]%a+ [IXV]+",  -- Stamina, Strength, Intellect, Protection, Spirit -- exclude "Mizrael"
  "Slimy Murloc Scale",
  "Murloc Fin",
  "Murloc Eye",
  "Shiny Fish Scales",
  "Flask of Oil",
  "Fish Oil",
  "Boar Intestines",
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

```


You can remove them all for safety, by changing the above lines to an empty table:

```lua
local otherJunk = {
} -- end of otherJunk

```

Or, add more items, or comment-out ones you want to keep. While you are levelling, for example, you may want to keep "Fine Aged Cheddar", but not when you are level 60 and running dungeons. Lines starting with "--" are comments, and therefore inactive.

The items in the list are Lua patterns (similar to regular expression) so for example "Scroll of [SIP]%a+ [IXV]+" would match "Scroll of Stamina IV". If you wanted to match different sorts of wolf meat you might use: "%a+ Wolf Meat" because "%a+" matches one or more alphabetic characters.

---

## Make a macro

Personally I made a macro with "/dj destroy" in it and bound it to a key, so when doing a dungeon I just hit that key to get rid of junk.

---

## Limit to number destroyed


To save destroying lots of things, when you just need room for a couple of new items, the addon stops after destroying five items. To remove that behaviour change this line:

```lua
local ITEM_LIMIT = 5
```

Make the limit some other number (eg. 10) or zero for no limit to how much it will destroy.


---

## How to install

* Go to <https://github.com/X-Genesis-Qhulut/DestroyJunk/tree/master>

* Click on the "\< \> Code" button

* Click on "Download ZIP"

* Unzip the resulting .zip file into your WoW folder: /Interface/AddOns/

* Rename the folder "DestroyJunk-master" to be "DestroyJunk"

* Close WoW, and re-open it.

* The addon should be installed and working. You should see a message in chat: "To destroy your junk:  /dj destroy"
