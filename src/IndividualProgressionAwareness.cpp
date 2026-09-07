#include "IndividualProgression.h"
#include "WorldState.h"
#include "TemporarySummon.h"
#include <algorithm>
#include <array>

class gobject_ipp_preaq : public GameObjectScript
{
public:
    gobject_ipp_preaq() : GameObjectScript("gobject_ipp_preaq") { }

    struct gobject_ipp_preaqAI: GameObjectAI
    {
        explicit gobject_ipp_preaqAI(GameObject* object) : GameObjectAI(object) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_BLACKWING_LAIR))
                return true;
            else
                return false;
        }
    };

    GameObjectAI* GetAI(GameObject* object) const override
    {
        return new gobject_ipp_preaqAI(object);
    }
};

class gobject_ipp_aqwar : public GameObjectScript
{
public:
    gobject_ipp_aqwar() : GameObjectScript("gobject_ipp_aqwar") { }

    struct gobject_ipp_aqwarAI: GameObjectAI
    {
        explicit gobject_ipp_aqwarAI(GameObject* object) : GameObjectAI(object) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster())
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_PRE_AQ) && !sIndividualProgression->hasPassedProgression(target, PROGRESSION_AQ_WAR))
                return true;
            else
                return false;
        }
    };

    GameObjectAI* GetAI(GameObject* object) const override
    {
        return new gobject_ipp_aqwarAI(object);
    }
};

class gobject_ipp_si : public GameObjectScript
{
public:
    gobject_ipp_si() : GameObjectScript("gobject_ipp_si") { }

    struct gobject_ipp_siAI: GameObjectAI
    {
        explicit gobject_ipp_siAI(GameObject* object) : GameObjectAI(object) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster())
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_AQ) && !sIndividualProgression->hasPassedProgression(target, PROGRESSION_NAXX40))
                return true;
            else
                return false;
        }
    };

    GameObjectAI* GetAI(GameObject* object) const override
    {
        return new gobject_ipp_siAI(object);
    }
};

class gobject_ipp_naxx40 : public GameObjectScript
{
public:
    gobject_ipp_naxx40() : GameObjectScript("gobject_ipp_naxx40") { }

    struct gobject_ipp_naxx40AI: GameObjectAI
    {
        explicit gobject_ipp_naxx40AI(GameObject* object) : GameObjectAI(object) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_AQ))
                return true;
            else
                return false;
        }
    };

    GameObjectAI* GetAI(GameObject* object) const override
    {
        return new gobject_ipp_naxx40AI(object);
    }
};

class gobject_ipp_pre_tbc : public GameObjectScript
{
public:
    gobject_ipp_pre_tbc() : GameObjectScript("gobject_ipp_pre_tbc") { }

    struct gobject_ipp_pre_tbcAI: GameObjectAI
    {
        explicit gobject_ipp_pre_tbcAI(GameObject* object) : GameObjectAI(object) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster())
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->isBeforeProgression(target, PROGRESSION_PRE_TBC))
                return true;
            else
                return false;
        }
    };

    GameObjectAI* GetAI(GameObject* object) const override
    {
        return new gobject_ipp_pre_tbcAI(object);
    }
};

class gobject_ipp_tbc : public GameObjectScript
{
public:
    gobject_ipp_tbc() : GameObjectScript("gobject_ipp_tbc") { }

    struct gobject_ipp_tbcAI: GameObjectAI
    {
        explicit gobject_ipp_tbcAI(GameObject* object) : GameObjectAI(object) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_PRE_TBC))
                return true;
            else
                return false;
        }
    };

    GameObjectAI* GetAI(GameObject* object) const override
    {
        return new gobject_ipp_tbcAI(object);
    }
};

class gobject_ipp_tbc_t4 : public GameObjectScript
{
public:
    gobject_ipp_tbc_t4() : GameObjectScript("gobject_ipp_tbc_t4") { }

    struct gobject_ipp_tbc_t4AI: GameObjectAI
    {
        explicit gobject_ipp_tbc_t4AI(GameObject* object) : GameObjectAI(object) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_TBC_TIER_4))
                return true;
            else
                return false;
        }
    };

    GameObjectAI* GetAI(GameObject* object) const override
    {
        return new gobject_ipp_tbc_t4AI(object);
    }
};

class gobject_ipp_wotlk : public GameObjectScript
{
public:
    gobject_ipp_wotlk() : GameObjectScript("gobject_ipp_wotlk") { }

    struct gobject_ipp_wotlkAI: GameObjectAI
    {
        explicit gobject_ipp_wotlkAI(GameObject* object) : GameObjectAI(object) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_TBC_TIER_5))
                return true;
            else
                return false;
        }
    };

    GameObjectAI* GetAI(GameObject* object) const override
    {
        return new gobject_ipp_wotlkAI(object);
    }
};

class npc_ipp_preaq : public CreatureScript
{
public:
    npc_ipp_preaq() : CreatureScript("npc_ipp_preaq") { }

    struct npc_ipp_preaqAI: ScriptedAI
    {
        explicit npc_ipp_preaqAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_BLACKWING_LAIR))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_preaqAI(creature);
    }
};

class npc_ipp_zg : public CreatureScript
{
public:
    npc_ipp_zg() : CreatureScript("npc_ipp_zg") { }

    struct npc_ipp_zgAI: ScriptedAI
    {
        explicit npc_ipp_zgAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            uint32 PLAYER_PROGRESSION = sIndividualProgression->GetPlayerProgressionFromQuests(target);
            ProgressionState REQUIRED_ZG_PROGRESSION = static_cast<ProgressionState>(sIndividualProgression->RequiredZulGurubProgression);

            if (PLAYER_PROGRESSION >= REQUIRED_ZG_PROGRESSION)
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_zgAI(creature);
    }
};

class npc_ipp_we : public CreatureScript
{
public:
    npc_ipp_we() : CreatureScript("npc_ipp_we") { }

    struct npc_ipp_weAI: ScriptedAI
    {
        explicit npc_ipp_weAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster())
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_BLACKWING_LAIR) && !sIndividualProgression->hasPassedProgression(target, PROGRESSION_PRE_AQ))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_weAI(creature);
    }
};

class npc_ipp_aq : public CreatureScript
{
public:
    npc_ipp_aq() : CreatureScript("npc_ipp_aq") { }

    struct npc_ipp_aqAI: ScriptedAI
    {
        explicit npc_ipp_aqAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_AQ_WAR))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_aqAI(creature);
    }
};

class npc_ipp_aqwewar : public CreatureScript
{
public:
    npc_ipp_aqwewar() : CreatureScript("npc_ipp_aqwewar") { }

    struct npc_ipp_aqwewarAI: ScriptedAI
    {
        explicit npc_ipp_aqwewarAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster())
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_BLACKWING_LAIR) && !sIndividualProgression->hasPassedProgression(target, PROGRESSION_AQ_WAR))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_aqwewarAI(creature);
    }
};

class npc_ipp_aqwar : public CreatureScript
{
public:
    npc_ipp_aqwar() : CreatureScript("npc_ipp_aqwar") { }

    struct npc_ipp_aqwarAI: ScriptedAI
    {
        explicit npc_ipp_aqwarAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster())
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_PRE_AQ) && !sIndividualProgression->hasPassedProgression(target, PROGRESSION_AQ_WAR))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_aqwarAI(creature);
    }
};

class npc_ipp_si : public CreatureScript
{
public:
    npc_ipp_si() : CreatureScript("npc_ipp_si") { }

    struct npc_ipp_siAI: ScriptedAI
    {
        explicit npc_ipp_siAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster())
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_AQ) && !sIndividualProgression->hasPassedProgression(target, PROGRESSION_NAXX40))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_siAI(creature);
    }
};

class npc_ipp_pre_naxx40 : public CreatureScript
{
public:
    npc_ipp_pre_naxx40() : CreatureScript("npc_ipp_pre_naxx40") { }

    struct npc_ipp_pre_naxx40AI: ScriptedAI
    {
        explicit npc_ipp_pre_naxx40AI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->isBeforeProgression(target, PROGRESSION_AQ))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_pre_naxx40AI(creature);
    }
};

class npc_ipp_naxx40 : public CreatureScript
{
public:
    npc_ipp_naxx40() : CreatureScript("npc_ipp_naxx40") { }

    struct npc_ipp_naxx40AI: ScriptedAI
    {
        explicit npc_ipp_naxx40AI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_AQ) || sIndividualProgression->isExcludedAccount(target))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_naxx40AI(creature);
    }
};

class npc_ipp_pre_tbc : public CreatureScript
{
public:
    npc_ipp_pre_tbc() : CreatureScript("npc_ipp_pre_tbc") { }

    struct npc_ipp_pre_tbcAI: ScriptedAI
    {
        explicit npc_ipp_pre_tbcAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->isBeforeProgression(target,PROGRESSION_PRE_TBC))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_pre_tbcAI(creature);
    }
};

class npc_ipp_tbc : public CreatureScript
{
public:
    npc_ipp_tbc() : CreatureScript("npc_ipp_tbc") { }

    struct npc_ipp_tbcAI: ScriptedAI
    {
        explicit npc_ipp_tbcAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_PRE_TBC))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_tbcAI(creature);
    }
};

class npc_ipp_tbc_pre_t3 : public CreatureScript
{
public:
    npc_ipp_tbc_pre_t3() : CreatureScript("npc_ipp_tbc_pre_t3") { }

    struct npc_ipp_tbc_pre_t3AI: ScriptedAI
    {
        explicit npc_ipp_tbc_pre_t3AI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster())
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (!sIndividualProgression->hasPassedProgression(target,PROGRESSION_TBC_TIER_2))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_tbc_pre_t3AI(creature);
    }
};

class npc_ipp_tbc_t3 : public CreatureScript
{
public:
    npc_ipp_tbc_t3() : CreatureScript("npc_ipp_tbc_t3") { }

    struct npc_ipp_tbc_t3AI: ScriptedAI
    {
        explicit npc_ipp_tbc_t3AI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_TBC_TIER_2))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_tbc_t3AI(creature);
    }
};

class npc_ipp_tbc_t4 : public CreatureScript
{
public:
    npc_ipp_tbc_t4() : CreatureScript("npc_ipp_tbc_t4") { }

    struct npc_ipp_tbc_t4AI: ScriptedAI
    {
        explicit npc_ipp_tbc_t4AI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_TBC_TIER_4))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_tbc_t4AI(creature);
    }
};

class npc_ipp_za : public CreatureScript
{
public:
    npc_ipp_za() : CreatureScript("npc_ipp_za") { }

    struct npc_ipp_zaAI: ScriptedAI
    {
        explicit npc_ipp_zaAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            uint32 PLAYER_PROGRESSION = sIndividualProgression->GetPlayerProgressionFromQuests(target);
            ProgressionState REQUIRED_ZA_PROGRESSION = static_cast<ProgressionState>(sIndividualProgression->RequiredZulAmanProgression);

            if (PLAYER_PROGRESSION >= REQUIRED_ZA_PROGRESSION)
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_zaAI(creature);
    }
};

class npc_ipp_pre_wotlk : public CreatureScript
{
public:
    npc_ipp_pre_wotlk() : CreatureScript("npc_ipp_pre_wotlk") { }

    struct npc_ipp_pre_wotlkAI: ScriptedAI
    {
        explicit npc_ipp_pre_wotlkAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->isBeforeProgression(target, PROGRESSION_TBC_TIER_5))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_pre_wotlkAI(creature);
    }
};

class npc_ipp_wotlk : public CreatureScript
{
public:
    npc_ipp_wotlk() : CreatureScript("npc_ipp_wotlk") { }

    struct npc_ipp_wotlkAI: ScriptedAI
    {
        explicit npc_ipp_wotlkAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_TBC_TIER_5))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_wotlkAI(creature);
    }
};

class npc_ipp_wotlk_ulduar : public CreatureScript
{
public:
    npc_ipp_wotlk_ulduar() : CreatureScript("npc_ipp_wotlk_ulduar") { }

    struct npc_ipp_wotlk_ulduarAI: ScriptedAI
    {
        explicit npc_ipp_wotlk_ulduarAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_WOTLK_TIER_1))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_wotlk_ulduarAI(creature);
    }
};

class npc_ipp_wotlk_totc : public CreatureScript
{
public:
    npc_ipp_wotlk_totc() : CreatureScript("npc_ipp_wotlk_totc") { }

    struct npc_ipp_wotlk_totcAI: ScriptedAI
    {
        explicit npc_ipp_wotlk_totcAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_WOTLK_TIER_2))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_wotlk_totcAI(creature);
    }
};

class npc_ipp_wotlk_icc : public CreatureScript
{
public:
    npc_ipp_wotlk_icc() : CreatureScript("npc_ipp_wotlk_icc") { }

    struct npc_ipp_wotlk_iccAI: ScriptedAI
    {
        explicit npc_ipp_wotlk_iccAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_WOTLK_TIER_3))
                return true;
            else
                return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_wotlk_iccAI(creature);
    }
};

// "An Earnest Proposition" - the Dungeon Set 2 turn-in ambush
// This lives on npc_ipp_ds2 because Deliana and Mokvar already carry that ScriptName

enum EarnestProposition
{
    NPC_MOKVAR = 16012,
    NPC_DELIANA = 16013,
    NPC_SPECTRAL_STALKER = 16093,

    // Deliana and Mokvar answer the ambush from where they stand and never chase, so they're put
    // in ranged mode; Fireball is the only spell it gives them.
    SPELL_DS2_FIREBALL = 15228,

    // `creature_text` groups: 16093 group 0 names Deliana, group 1 names Mokvar.
    SAY_STALKER_ALLIANCE = 0,
    SAY_STALKER_HORDE = 1,
    SAY_QUESTGIVER_ANSWER = 0
};

constexpr uint32 SPECTRAL_STALKER_DESPAWN_MS = 120 * IN_MILLISECONDS; // 120s.

// taunt line 100ms after the last summon and the answer at 2000ms.
constexpr Milliseconds STALKER_TAUNT_DELAY = 100ms;
constexpr Milliseconds QUESTGIVER_ANSWER_DELAY = 2s;

constexpr std::array<uint32, 9> EARNEST_PROPOSITION_ALLIANCE =
{ 8905, 8906, 8907, 8908, 8909, 8910, 8911, 8912, 10492 };

constexpr std::array<uint32, 9> EARNEST_PROPOSITION_HORDE =
{ 8913, 8914, 8915, 8916, 8917, 8918, 8919, 8920, 10493 };

// Exact spawn points - three stalkers in front of each questgiver.
const std::array<Position, 3> STALKER_SPAWNS_ALLIANCE =
{ {
    { -4836.73f, -1056.37f, 502.273f, 3.00f },
    { -4833.58f, -1059.59f, 502.272f, 2.77f },
    { -4834.76f, -1054.37f, 502.273f, 3.10f }
} };

const std::array<Position, 3> STALKER_SPAWNS_HORDE =
{ {
    { 1925.37f, -4166.39f, 40.9956f, 3.56f },
    { 1928.09f, -4167.21f, 41.0072f, 3.56f },
    { 1926.11f, -4163.47f, 40.6428f, 3.56f }
} };

class npc_ipp_ds2 : public CreatureScript
{
public:
    npc_ipp_ds2() : CreatureScript("npc_ipp_ds2") { }

    struct npc_ipp_ds2AI: ScriptedAI
    {
        explicit npc_ipp_ds2AI(Creature* creature) : ScriptedAI(creature) { };

        [[nodiscard]] bool IsAmbushTarget() const
        {
            return me->GetEntry() == NPC_DELIANA || me->GetEntry() == NPC_MOKVAR;
        }

        void Reset() override
        {
            // Must be set outside combat: Creature::SetCombatMovement only affects AttackStart.
            if (IsAmbushTarget())
                me->SetCombatMovement(false);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (!IsAmbushTarget())
                return;

            ScheduleTimedEvent(3s, 4s, [&]
                {
                    DoCastVictim(SPELL_DS2_FIREBALL);
                }, 3s, 4s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            // Guarded exactly as ScriptedAI::UpdateAI does; Huum Wildmane and Aurel Goldleaf share this ScriptName and must keep stock combat behaviour.
            scheduler.Update(diff, [this]
                {
                    if (IsAutoAttackAllowed())
                        DoMeleeAttackIfReady();
                });
        }

        bool CanBeSeen(Player const* player) override
        {
            if (player->IsGameMaster() || !sIndividualProgression->enabled || sIndividualProgression->earlyDungeonSet2)
                return true;

            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());
            if (sIndividualProgression->hasPassedProgression(target, PROGRESSION_BLACKWING_LAIR))
                return true;
            else
                return false;
        }
    };

    // Returning false keeps the normal turn-in flow (next-quest offer, CreatureAI::sQuestReward).
    bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 /*opt*/) override
    {
        if (!player || !creature || !quest)
            return false;

        uint32 const questId = quest->GetQuestId();
        bool const alliance = std::find(EARNEST_PROPOSITION_ALLIANCE.begin(),
            EARNEST_PROPOSITION_ALLIANCE.end(), questId)
            != EARNEST_PROPOSITION_ALLIANCE.end();
        bool const horde = std::find(EARNEST_PROPOSITION_HORDE.begin(),
            EARNEST_PROPOSITION_HORDE.end(), questId)
            != EARNEST_PROPOSITION_HORDE.end();

        if (!alliance && !horde)
            return false;

        auto const& spawns = alliance ? STALKER_SPAWNS_ALLIANCE : STALKER_SPAWNS_HORDE;
        uint8 const stalkerLine = alliance ? SAY_STALKER_ALLIANCE : SAY_STALKER_HORDE;

        // Spectral Stalker is faction 14, so it picks its own fight the moment it lands
        Creature* taunter = nullptr;
        for (Position const& pos : spawns)
        {
            if (TempSummon* stalker = creature->SummonCreature(NPC_SPECTRAL_STALKER, pos,
                TEMPSUMMON_TIMED_DESPAWN, SPECTRAL_STALKER_DESPAWN_MS))
            {
                if (!taunter)
                    taunter = stalker;
            }
        }

        // CreatureAI::Talk with a delay stores only the target's guid and re-resolves it when it fires,
        // so a logout inside those two seconds is handled for us.
        if (taunter && taunter->AI())
            taunter->AI()->Talk(stalkerLine, player, STALKER_TAUNT_DELAY);

        if (creature->AI())
            creature->AI()->Talk(SAY_QUESTGIVER_ANSWER, player, QUESTGIVER_ANSWER_DELAY);

        return false;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ipp_ds2AI(creature);
    }
};

// Add all scripts in one
void AddSC_mod_individual_progression_awareness()
{
    new gobject_ipp_preaq();          // Wanted poster Cenarion Hold
    new gobject_ipp_aqwar();          // AQ war crystals
    new gobject_ipp_si();             // Scourge Invasion
    new gobject_ipp_naxx40();
    new gobject_ipp_pre_tbc();        // Stormwind pvp room
    new gobject_ipp_tbc();
    new gobject_ipp_tbc_t4();         // Shattered Sun
    new gobject_ipp_wotlk();
	
    new npc_ipp_preaq();              // Cenarion Hold NPCs
    new npc_ipp_zg();
    new npc_ipp_we();                 // War Effort NPCs in cities
    new npc_ipp_aq();
    new npc_ipp_aqwewar();            // only visible during AQ war effort and AQ war
    new npc_ipp_aqwar();              // only visible during AQ war
    new npc_ipp_si();                 // Scourge Invasion
    new npc_ipp_pre_naxx40();         // Scourge Invasion
    new npc_ipp_naxx40();
    new npc_ipp_pre_tbc();            // Vanilla pvp vendors
    new npc_ipp_tbc();
    new npc_ipp_tbc_pre_t3();         // TBC leatherworking vendors
    new npc_ipp_tbc_t3();             // TBC leatherworking vendors
	// new npc_ipp_tbc_t4();
    new npc_ipp_za();
    new npc_ipp_pre_wotlk();
    new npc_ipp_wotlk();
    new npc_ipp_wotlk_ulduar();
    new npc_ipp_wotlk_totc();
    new npc_ipp_wotlk_icc();
    new npc_ipp_ds2();
}
