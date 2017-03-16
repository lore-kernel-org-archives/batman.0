Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 16 Mar 2017 14:34:24 +0100
Message-Id: <20170316133429.3923-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv8 0/5] Optimizations for setups running dat
	and bla
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
Cc: a@unstable.cc

This is yet another rebased version of Andreas' patchset. I've used
Antonios branch, but reverted his changes to the first patch, since
there were unexplained semantic changes (e.g. when no gateway is
claiming the client) which I don't think are correct.

Antonio, if you want, please explain your changes or let us discuss.

Otherwise, I'd suggest to keep this patchset around for a few days (!)
for a final review, and then merge it.

Thanks,
     Simon

Andreas Pape (5):
  batman-adv: prevent multiple ARP replies sent by gateways if dat
    enabled
  batman-adv: prevent duplication of ARP replies when DAT is used
  batman-adv: drop unicast packets from other backbone gw
  batman-adv: changed debug messages for easier bla debugging
  batman-adv: handle race condition for claims between gateways

 net/batman-adv/bridge_loop_avoidance.c | 87 ++++++++++++++++++++++++++++++----
 net/batman-adv/bridge_loop_avoidance.h | 11 +++++
 net/batman-adv/distributed-arp-table.c | 47 ++++++++++++++++++
 net/batman-adv/routing.c               | 25 ++++++++--
 4 files changed, 159 insertions(+), 11 deletions(-)

-- 
2.11.0

