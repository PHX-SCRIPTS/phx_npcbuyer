# phx_npcbuyer

NPC buyer for FiveM. Players walk up to a ped, choose items from their
inventory and sell them for cash, with a hand-to-hand trade animation.

## Features
- Ped with ox_target interaction
- Context menu with only the items the player actually owns
- Quantity input and server-side price/distance validation
- Hand-to-hand trade animation
- Easy config for items and prices

## Requirements
- ox_lib
- ox_inventory
- ox_target
- ESX (for QBCore change the payout line in server.lua)

## Installation
1. Put `phx-buyerped` into your resources folder.
2. Add the items to `ox_inventory/data/items.lua`.
3. Add `ensure phx-buyerped` to `server.cfg` after the dependencies.
4. Edit `config.lua` (ped model, coordinates, item prices).

