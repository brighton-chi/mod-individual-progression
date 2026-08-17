#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"

enum Karynaku
{
    QUEST_ALLY_OF_NETHER = 10870,
    QUEST_ZUHULED_THE_WACK = 10866,
    NPC_ZUHULED_THE_WACKED = 11980,
    TAXI_PATH_ID = 649
};

class npc_karynaku_ipp : public CreatureScript
{
public:
    npc_karynaku_ipp() : CreatureScript("npc_karynaku_ipp") {}

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_ALLY_OF_NETHER)
            player->ActivateTaxiPathTo(TAXI_PATH_ID);

        if (quest->GetQuestId() == QUEST_ZUHULED_THE_WACK)
        {
            if (!player->FindNearestCreature(NPC_ZUHULED_THE_WACKED, 100.0f))
                creature->SummonCreature(NPC_ZUHULED_THE_WACKED, -4204.94f, 316.397f, 122.508f, 1.309f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
        }

        return true;
    }
};

void AddSC_npc_karynaku_70()
{
    new npc_karynaku_ipp();
}
