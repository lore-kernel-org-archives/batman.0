Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 Nov 2015 19:57:19 +0100
Message-Id: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] Couple of patches while developing
	BATMAN V
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

This series includes a couple of patches which fix some issues and
prepare for the upcoming BATMAN V code.

Simon Wunderlich (3):
  batman-adv: fix lockdep splat when doing mcast_free
  batman-adv: add kerneldoc for batadv_iv_ogm_aggr_packet
  batman-adv: add seqno maximum age and protection start flag parameters

 net/batman-adv/bat_iv_ogm.c | 12 ++++++++++--
 net/batman-adv/main.h       |  3 +++
 net/batman-adv/multicast.c  |  2 ++
 net/batman-adv/routing.c    | 13 ++++++++++---
 net/batman-adv/routing.h    |  3 ++-
 5 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.6.2

