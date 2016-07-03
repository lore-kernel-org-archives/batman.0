Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jul 2016 12:46:31 +0200
Message-Id: <1467542795-29647-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v6 0/4] GW code: make it algorithm-agnostic
	and add B.A.T.M.A.N. V support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

here are the patches from Antonio with the modifications which we've
discussed when v5 of the patchset was reviewed. I am submitting this
patchset because Antonio had no time to work on them.

Changes from v1:
- rebased on top of latest master (some patches from the previous patchset were
  merged already)
- accidental change to the GW table header moved to right patch
- remove bat_ prefix from API names
- API subobjects redefined as proper struct instead of anonymous ones to fix
  kernel-doc complaints
- bonus kernel-doc added
- missing include files added

Changes from v2:
- minimum default value of gw_sel_class restored to 1

Changes from v3:
- move "batman-adv: split routing API data structure in subobjects" as patch 1
- check if algo_ops->gw.get_best_gw_node was implemented before calling it
- add patch to disable GW mode knobs if API have not been implemented (6/6)

Changes from v4:
- drop CONFIG_BATMAN_ADV_BATMAN_V dependency when declaring batadv_gw_node_get()
  in gateway_client.h
- rebased on top of current master

Changes from v5:

- added "(optional)" to the kerneldoc of store_sel_class and
  show_sel_class, get_best_gw_node, is_eligible
- switched seq_print of static strings to seq_puts
- move new comment in batadv_gw_election from patch 3 to patch 2
- fix possible integer overflow in batadv_v_gw_is_eligible when comparing
  current gw throughput (+threshold) against throughput of potential new
  gateway

Kind regards,
	Sven

Antonio Quartulli (4):
  batman-adv: make the GW selection class algorithm specific
  batman-adv: make GW election code protocol specific
  batman-adv: B.A.T.M.A.N. V - implement GW selection logic
  batman-adv: disable sysfs knobs when GW-mode is not implemented

 net/batman-adv/bat_iv_ogm.c     | 219 ++++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v.c          | 257 +++++++++++++++++++++++++++++++++++++++-
 net/batman-adv/gateway_client.c | 222 +++++-----------------------------
 net/batman-adv/gateway_client.h |   5 +
 net/batman-adv/gateway_common.c |   5 +-
 net/batman-adv/sysfs.c          |  62 +++++++++-
 net/batman-adv/types.h          |  24 ++++
 7 files changed, 596 insertions(+), 198 deletions(-)

-- 
2.8.1

