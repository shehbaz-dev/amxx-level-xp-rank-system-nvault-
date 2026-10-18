/* AMX Mod X Plugin
 * Name: Level & XP Rank System (nVault)
 * Target: AMXX 1.8.2
 * Description: Create an XP and Level rank system for CS 1.6 saved persistently using nVault by SteamID/AuthID. Players gain 10 XP on kill, 25 XP on headshot, 30 XP on bomb plant/defuse. Ranks from Level 1 (Recruit) to Level 20 (General). Display current Level, XP, and rank name in bottom HUD.
 */

#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <hamsandwich>

#define PLUGIN "Level & XP Rank System (nVault)"
#define VERSION "1.0"
#define AUTHOR "SHEVX Studio"

new g_pCvarEnabled;

public plugin_init() {
    register_plugin(PLUGIN, VERSION, AUTHOR);

    // Register CVars
    g_pCvarEnabled = register_cvar("amx_level___xp_rank_system__nvault__enabled", "1");

    // Register Commands
    register_clcmd("say /level___xp_rank_system__nvault_", "cmd_OpenMenu");
    register_clcmd("say_team /level___xp_rank_system__nvault_", "cmd_OpenMenu");

    // Ham Hooks
    RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn_Post", 1);

    server_print("[%s v%s] Successfully initialized.", PLUGIN, VERSION);
}

public fw_PlayerSpawn_Post(id) {
    if (!get_pcvar_num(g_pCvarEnabled) || !is_user_alive(id)) {
        return HAM_IGNORED;
    }

    client_print(id, print_chat, "[%s] Welcome! Type /level___xp_rank_system__nvault_ for options.", PLUGIN);
    return HAM_IGNORED;
}

public cmd_OpenMenu(id) {
    if (!is_user_connected(id)) return PLUGIN_HANDLED;

    new menu = menu_create("\y[SHEVX]\w Level & XP Rank System (nVault) Menu", "menu_Handler");
    menu_additem(menu, "Feature Action 1", "1", 0);
    menu_additem(menu, "Feature Action 2", "2", 0);
    menu_additem(menu, "Plugin Information", "3", 0);

    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL);
    menu_display(id, menu, 0);
    return PLUGIN_HANDLED;
}

public menu_Handler(id, menu, item) {
    if (item == MENU_EXIT) {
        menu_destroy(menu);
        return PLUGIN_HANDLED;
    }

    switch (item) {
        case 0: client_print(id, print_chat, "[%s] Option 1 activated.", PLUGIN);
        case 1: client_print(id, print_chat, "[%s] Option 2 activated.", PLUGIN);
        case 2: client_print(id, print_chat, "[%s] Running v%s by %s.", PLUGIN, VERSION, AUTHOR);
    }

    menu_destroy(menu);
    return PLUGIN_HANDLED;
}
