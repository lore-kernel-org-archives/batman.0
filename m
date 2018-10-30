Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 30 Oct 2018 22:01:21 +0100
Message-Id: <20181030210130.18152-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/9] batman-adv: Add inconsistent nl dump
 detection
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

The netlink dump functionality transfers a large number of entries from the
kernel to userspace. It is rather likely that the transfer has to
interrupted and later continued. During that time, it can happen that
either new entries are added or removed. The userspace could than either
receive some entries multiple times or miss entries.

Commit 670dc2833d14 ("netlink: advertise incomplete dumps") introduced a
mechanism to inform userspace about this problem. Userspace can then decide
whether it is necessary or not to retry dumping the information again.

The netlink dump functions have to be switched to exclusive locks to avoid
changes while the current message is prepared. And an external generation
sequence counter is introduced which tracks all modifications of the
list/hash.

There some netlink dump commands which were not yet modified. These
datastructures use subentries (or entries for multiple main object)
which makes mapping to a generation sequence counter more problematic:

* originator
* neighbor list (multiple interfaces make it harder)
* global translation table

Also the batadv_algo stuff was ignored because it doesn't even have locks
and is not supposed to be modified at runtime.

Kind regards,
	Sven

Sven Eckelmann (9):
  batman-adv: Add compat for genl_dump_check_consistent
  batman-adv: Add inconsistent gateway netlink dump detection
  batman-adv: Add inconsistent hardif netlink dump detection
  batman-adv: Store modification counter via hash helpers
  batman-adv: Add inconsistent backbone netlink dump detection
  batman-adv: Add inconsistent claim netlink dump detection
  batman-adv: Add inconsistent dat netlink dump detection
  batman-adv: Add inconsistent local TT netlink dump detection
  batman-adv: Add inconsistent multicast netlink dump detection

 compat-include/net/genetlink.h         | 45 ++++++++++++++
 net/batman-adv/bat_iv_ogm.c            | 24 +++++---
 net/batman-adv/bat_v.c                 | 26 +++++---
 net/batman-adv/bridge_loop_avoidance.c | 82 +++++++++++++++-----------
 net/batman-adv/distributed-arp-table.c | 42 +++++++------
 net/batman-adv/gateway_client.c        |  3 +
 net/batman-adv/hard-interface.c        |  3 +
 net/batman-adv/hash.c                  |  2 +
 net/batman-adv/hash.h                  |  6 ++
 net/batman-adv/main.c                  |  3 +
 net/batman-adv/main.h                  |  1 +
 net/batman-adv/multicast.c             | 51 ++++++++--------
 net/batman-adv/netlink.c               | 24 ++++----
 net/batman-adv/translation-table.c     | 41 +++++++------
 net/batman-adv/types.h                 |  5 +-
 15 files changed, 233 insertions(+), 125 deletions(-)
 create mode 100644 compat-include/net/genetlink.h

-- 
2.19.1

