# DestroyJunk

## Purpose

This is intended for when you are running dungeons on Vanilla (or Classic) WoW - and your bags are filling up with useless
junk that is taking room that you want for "green" or "blue" items.

It also has the functionality inspired by the "CrapAway" plugin. If you visit a vendor it automatically sells those
same items (gray items, and items in the list described below). This is useful while levelling, as you kill mobs you
may find your bags full of junk, and it is tedious to sell them one-by-one at the vendor.


---

## How to use

Just install this and then when your bags have filled up, type:

```
/dj destroy
```

Without warning, gray (poor quality) items, **and** normal quality (white) ones listed in the DestroyJunk.lua file will be destroyed. They cannot be retrieved.

Also, if you visit a vendor the same items will be sold (not destroyed) automatically when you open the vendor window.

---

## Extra junk that will be destroyed

The list of "white" items that are also destroyed looks like this (in alphabetic order):

```lua
local otherJunk = {
  "Alterac Swiss",
  "Black Diamond",
  "Boar Intestines",
  "Coal",  -- warning: needed for Thorium Brotherhood
  "Cured Ham Steak",
  "Delicious Cave Mold",
  "Dried King Bolete",
  "Fine Aged Cheddar",
  "Fish Oil",
  "Flask of Oil",
  "Heavy Stone",
  "Homemade Cherry Pie",
  "Moonberry Juice",
  "Moon Harvest Pumpkin",
  "Morning Glory Dew",  -- not at level 45
  "Murloc Eye",
  "Murloc Fin",
  "Mystery Meat",
-- "Nightcrawlers",
  "Raw Black Truffle",
  "Red Wolf Meat",
 -- "Roasted Quail",
  -- "Scroll of [SIP]%a+ [IXV]+",  -- Stamina, Strength, Intellect, Protection, Spirit -- exclude "Mizrael"
  "Shiny Fish Scales",
  "Slimy Murloc Scale",
  "Soft Banana Bread",
  "Tender Wolf Meat",
  "Unadorned Seal of Ascension",
  "Wicked Claw",

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

Some information about Lua patterns [here](https://www.lua.org/pil/20.2.html).

The code automatically puts "^" at the start of each item and "$" at the end, so the item has to match exactly what is in the pattern (and not have the
pattern be *part* of the item name).

If you are levelling an alt you may want to check that you aren't destroying or selling items that are useful at that level. For example, "Tender Wolf Meat" is useful for cooking, if you happen to be at that level in your cooking profession.

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

* Unzip the resulting .zip file (DestroyJunk-master.zip) into your WoW Interface -> Addons folder: (Install folder)/Interface/AddOns/

* Rename the folder "DestroyJunk-master" to be "DestroyJunk"

* Close WoW, and re-open it.

* The addon should be installed and working. You should see a message in chat: "To destroy your junk:  /dj destroy"
