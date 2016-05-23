Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Mon, 23 May 2016 17:00:32 +0800
Message-Id: <20160523090037.26896-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH v2 0/5] GW code: make it algorithm-agnostic
	and add B.A.T.M.A.N. V
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


Cheers,

Antonio Quartulli (5):
  batman-adv: make the GW selection class algorithm specific
  batman-adv: split routing API data structure in subobjects
  batman-adv: statically print gateway table header
  batman-adv: make GW election code protocol specific
  batman-adv: B.A.T.M.A.N. V - implement GW selection logic

 net/batman-adv/bat_algo.c          |  14 +-
 net/batman-adv/bat_iv_ogm.c        | 252 +++++++++++++++++++++++++++++++--
 net/batman-adv/bat_v.c             | 280 +++++++++++++++++++++++++++++++++++--
 net/batman-adv/bat_v_elp.c         |   2 +-
 net/batman-adv/bat_v_ogm.c         |   2 +-
 net/batman-adv/gateway_client.c    | 220 ++++-------------------------
 net/batman-adv/gateway_client.h    |   7 +
 net/batman-adv/gateway_common.c    |   5 +-
 net/batman-adv/hard-interface.c    |  16 +--
 net/batman-adv/netlink.c           |   2 +-
 net/batman-adv/originator.c        |  49 +++----
 net/batman-adv/routing.c           |   8 +-
 net/batman-adv/sysfs.c             |  37 ++++-
 net/batman-adv/translation-table.c |   6 +-
 net/batman-adv/types.h             | 137 +++++++++++-------
 15 files changed, 714 insertions(+), 323 deletions(-)

-- 
2.8.3

