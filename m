Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  9 Oct 2010 14:16:35 +0200
Message-Id: <1286626600-23439-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Polishing of the hash implementation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

David S. Miller wasn't amused[1] by our hash implementation. Instead he
proposed some changes we should make. I tried to implement most of them, but
don't think we should really manually inline every functionality currently
provided by the hash implementation. I would rather keep the heavily used
functions as compiler inlineable functions and do the rest using standard
kernel hlist_*.

Best regards,
	Sven

[1] Message-Id: <20100924.134334.28812338.davem@davemloft.net>


Sven Eckelmann (5):
      batman-adv: Remove hashdata_compare_cb from hash
      batman-adv: Remove hashdata_choose_cb from hash
      batman-adv: Move hash callback related function to header
      batman-adv: Make hash_iterate inlineable
      batman-adv: Rewrite hash using hlist_*

 batman-adv/hash.c              |  237 +--------------------------------------
 batman-adv/hash.h              |  220 ++++++++++++++++++++++++++++++++-----
 batman-adv/icmp_socket.c       |    2 +
 batman-adv/main.c              |   28 -----
 batman-adv/main.h              |    2 -
 batman-adv/originator.c        |   31 ++++--
 batman-adv/originator.h        |   28 +++++
 batman-adv/routing.c           |   22 +++-
 batman-adv/send.c              |    1 +
 batman-adv/translation-table.c |   58 +++++++---
 batman-adv/unicast.c           |    6 +-
 batman-adv/vis.c               |   49 ++++++--
 12 files changed, 347 insertions(+), 337 deletions(-)
