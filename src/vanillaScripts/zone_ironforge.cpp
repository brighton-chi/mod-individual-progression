#include "CreatureAI.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptMgr.h"

// Extends the core's EasternKingdoms/zone_ironforge.cpp; it does not replace it. 
// Only two things could collide: the AddSC_ symbol, and the registered ScriptName string - neither does.

// King Magni's two quest-completion lines. They cannot be SmartAI: his ScriptName owns the AI slot,
enum KingMagniQuestScenes
{
    NPC_KING_MAGNI_BRONZEBEARD      = 2784,

    QUEST_SARA_BALLOOS_PLEA         = 683,
    QUEST_THE_BROKERING_OF_PEACE    = 8484,

    SAY_SARA_BALLOOS_PLEA           = 0,    // already shipped with AzerothCore, nothing fired it
    SAY_THE_BROKERING_OF_PEACE      = 1     // added by zone_ironforge.sql
};

// One spawn world-wide, and the player has to be standing at him to hand in.
constexpr float MAGNI_SEARCH_RANGE = 30.0f;
constexpr Milliseconds BROKERING_OF_PEACE_YELL_DELAY = 1s;

class ipp_zone_ironforge_playerscript : public PlayerScript
{
public:
    ipp_zone_ironforge_playerscript() : PlayerScript("ipp_zone_ironforge_playerscript", { PLAYERHOOK_ON_PLAYER_COMPLETE_QUEST }) { }

    void OnPlayerCompleteQuest(Player* player, Quest const* quest) override
    {
        if (!player || !quest)
            return;

        uint32 questId = quest->GetQuestId();
        if (questId != QUEST_SARA_BALLOOS_PLEA && questId != QUEST_THE_BROKERING_OF_PEACE)
            return;

        Creature* magni = player->FindNearestCreature(NPC_KING_MAGNI_BRONZEBEARD, MAGNI_SEARCH_RANGE);
        if (!magni || !magni->AI())
            return;

        // He studies Sara Balloo's note and sighs, the moment it is handed in.
        if (questId == QUEST_SARA_BALLOOS_PLEA)
        {
            magni->AI()->Talk(SAY_SARA_BALLOOS_PLEA, player);
            return;
        }

        // A second later he yells the player's praise to the hall. The exclamation gesture is on the creature_text row's Emote column, not here. 
		// The player is passed as chat target so the yell's $N resolves; a delayed Talk stores only the guid and re-resolves on firing.
        magni->AI()->Talk(SAY_THE_BROKERING_OF_PEACE, player, BROKERING_OF_PEACE_YELL_DELAY);
    }
};

void AddSC_ipp_zone_ironforge()
{
    new ipp_zone_ironforge_playerscript();
}
