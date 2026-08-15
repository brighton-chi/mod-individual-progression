#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"

enum Karynaku
{
    QUEST_ALLY_OF_NETHER    = 10870,
    QUEST_ZUHULED_THE_WACK  = 10866,

    NPC_ZUHULED_THE_WACKED  = 11980,
    NPC_DRAGONMAW_ELITE     = 22331,

    TAXI_PATH_ID            = 649
};

class npc_karynaku_ipp : public CreatureScript
{
public:
    npc_karynaku_ipp() : CreatureScript("npc_karynaku_ipp") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_ALLY_OF_NETHER)
            player->ActivateTaxiPathTo(TAXI_PATH_ID);

        if (quest->GetQuestId() == QUEST_ZUHULED_THE_WACK)
        {
            if (!player->FindNearestCreature(NPC_ZUHULED_THE_WACKED, 100.0f))
            {
                creature->SummonCreature(NPC_ZUHULED_THE_WACKED, -4204.94f, 316.397f, 122.508f, 1.309f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
              
                creature->SummonCreature(NPC_DRAGONMAW_ELITE, -4205.27f, 310.496f, 137.986f, 1.08210f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                creature->SummonCreature(NPC_DRAGONMAW_ELITE, -4191.67f, 314.663f, 136.221f, 2.07694f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                creature->SummonCreature(NPC_DRAGONMAW_ELITE, -4182.75f, 320.651f, 135.659f, 1.76278f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                creature->SummonCreature(NPC_DRAGONMAW_ELITE, -4221.03f, 356.127f, 137.067f, 5.86431f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                creature->SummonCreature(NPC_DRAGONMAW_ELITE, -4222.08f, 348.025f, 136.504f, 5.95157f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                creature->SummonCreature(NPC_DRAGONMAW_ELITE, -4224.61f, 339.775f, 135.599f, 6.19592f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                creature->SummonCreature(NPC_DRAGONMAW_ELITE, -4167.83f, 353.686f, 138.958f, 2.89725f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                creature->SummonCreature(NPC_DRAGONMAW_ELITE, -4169.85f, 341.298f, 135.938f, 3.15905f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);
                creature->SummonCreature(NPC_DRAGONMAW_ELITE, -4172.63f, 330.287f, 135.958f, 2.86234f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);			
            }
        }

        return true;
    }
};

void AddSC_npc_karynaku_70()
{
    new npc_karynaku_ipp();
}
