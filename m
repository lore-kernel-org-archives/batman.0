Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Jul 2018 22:01:18 +0200
Message-Id: <20180707200121.2684-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] batman-adv: Minor cleanups
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

this mini patchset contains some minor cleanups which are on my HDD
since a longer time but were never submitted. They still didn't reach a
critical mass - but they will not get better with age.

Kind regards,
	Sven

Sven Eckelmann (3):
  batman-adv: Unify include guards style
  batman-adv: Join batadv_purge_orig_ref and _batadv_purge_orig
  batman-adv: Convert batadv_dat_addr_t to proper type

 net/batman-adv/bat_iv_ogm.h |  6 +++---
 net/batman-adv/bat_v_ogm.h  |  6 +++---
 net/batman-adv/originator.c | 17 ++++++-----------
 net/batman-adv/types.h      |  7 ++++---
 4 files changed, 16 insertions(+), 20 deletions(-)

-- 
2.18.0

