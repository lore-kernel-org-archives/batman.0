Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 12 Jun 2016 12:14:22 +0800
Message-Id: <20160612041426.26339-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH v5 0/6] GW code: make it algorithm-agnostic
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
Cc: Antonio Quartulli <a@unstable.cc>

This cover letter only tries to recap the changes applied from the previous
version. Please check the patch for major details.

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

Cheers,

Antonio Quartulli (4):
  batman-adv: make the GW selection class algorithm specific
  batman-adv: make GW election code protocol specific
  batman-adv: B.A.T.M.A.N. V - implement GW selection logic
  batman-adv: disable sysfs knobs when GW-mode is not implemented

 net/batman-adv/bat_iv_ogm.c     | 219 ++++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v.c          | 254 +++++++++++++++++++++++++++++++++++++++-
 net/batman-adv/gateway_client.c | 222 +++++------------------------------
 net/batman-adv/gateway_client.h |   5 +
 net/batman-adv/gateway_common.c |   5 +-
 net/batman-adv/sysfs.c          |  62 +++++++++-
 net/batman-adv/types.h          |  23 ++++
 7 files changed, 592 insertions(+), 198 deletions(-)

-- 
2.8.4

