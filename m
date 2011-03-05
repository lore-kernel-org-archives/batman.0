Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2011 13:28:14 +0100
Message-Id: <1299328122-21468-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-03-05
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi,

I was asked to submit following pull request for net-next-2.6/linux-2.6.39. It
contains Marek's hard work (and of course related work by other people) to
remove the orig_hash (aka the batman-adv private "big kernel lock").

There are also smaller cleanups by Marek, Jesper Juhl and Linus Luessing which
remove some unused variables, includes and irritating naming schemes.

thanks,
	Sven

The following changes since commit 3878f1f075470990d9c2418b53f31694e774f743:

  batman-adv: Disallow originator addressing within mesh layer (2011-02-11 23:30:33 +0100)

are available in the git repository at:
  git://git.open-mesh.org/ecsv/linux-merge.git batman-adv/next

Jesper Juhl (1):
      batman-adv: Remove two duplicate includes.

Linus Lüssing (4):
      batman-adv: Make bat_priv->curr_gw an rcu protected pointer
      batman-adv: Increase orig_node refcount before releasing rcu read lock
      batman-adv: Fix possible buffer overflow in softif neigh list output
      batman-adv: Remove unused hdr_size variable in route_unicast_packet()

Marek Lindner (21):
      batman-adv: protect neighbor nodes with reference counters
      batman-adv: convert neighbor list to hlist
      batman-adv: protect neighbor list with rcu locks
      batman-adv: free neighbors when an interface is deactivated
      batman-adv: protect neigh_nodes used outside of rcu_locks with refcounting
      batman-adv: protect each hash row with rcu locks
      batman-adv: protect originator nodes with reference counters
      batman-adv: protect ogm counter arrays with spinlock
      batman-adv: Correct rcu refcounting for neigh_node
      batman-adv: Correct rcu refcounting for gw_node
      batman-adv: Correct rcu refcounting for softif_neigh
      batman-adv: Correct rcu refcounting for batman_if
      batman-adv: protect bit operations to count OGMs with spinlock
      batman-adv: make broadcast seqno operations atomic
      batman-adv: separate ethernet comparing calls from hash functions
      batman-adv: remove extra layer between hash and hash element - hash bucket
      batman-adv: Correct rcu refcounting for orig_node
      batman-adv: increase refcount in create_neighbor to be consistent
      batman-adv: remove orig_hash spinlock
      batman-adv: rename global if_list to hardif_list
      batman-adv: rename batman_if struct to hard_iface

Simon Wunderlich (1):
      batman-adv: protect bonding with rcu locks

Sven Eckelmann (1):
      batman-adv: Disallow regular interface as mesh device

 net/batman-adv/aggregation.c       |    8 +-
 net/batman-adv/aggregation.h       |    4 +-
 net/batman-adv/bat_sysfs.c         |   51 +-
 net/batman-adv/gateway_client.c    |  140 ++++--
 net/batman-adv/hard-interface.c    |  407 ++++++++--------
 net/batman-adv/hard-interface.h    |   15 +-
 net/batman-adv/hash.c              |   26 +-
 net/batman-adv/hash.h              |  112 ++---
 net/batman-adv/icmp_socket.c       |   40 +-
 net/batman-adv/main.c              |   13 +-
 net/batman-adv/main.h              |   12 +-
 net/batman-adv/originator.c        |  252 ++++++----
 net/batman-adv/originator.h        |   50 ++-
 net/batman-adv/routing.c           |  983 +++++++++++++++++++++---------------
 net/batman-adv/routing.h           |   25 +-
 net/batman-adv/send.c              |  103 ++--
 net/batman-adv/send.h              |    8 +-
 net/batman-adv/soft-interface.c    |   74 ++--
 net/batman-adv/soft-interface.h    |    3 +-
 net/batman-adv/translation-table.c |  205 +++++---
 net/batman-adv/types.h             |   48 +-
 net/batman-adv/unicast.c           |   93 ++--
 net/batman-adv/unicast.h           |    2 +-
 net/batman-adv/vis.c               |  192 ++++---
 24 files changed, 1634 insertions(+), 1232 deletions(-)
