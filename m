Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  1 May 2011 23:10:30 +0200
Message-Id: <1304284234-27338-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-05-01
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

I would like to propose following patches for net-next-2.6/2.6.40. Marek
Lindner continued to convert different datastructures to use RCU. Antonio
Quartulli fixed an important bug introduced in the last patchset related to the
update of the current gateway. He also did some minor cleanup work.

I've removed the patch "net: batman-adv: remove rx_csum ethtool_ops" again
because you already applied it in your branch.

thanks,
	Sven

The following changes since commit af20b710479ae662829cf739b521390daa7fcbcb:

  batman-adv: Set the txqueuelen to zero when creating soft interface (2011-04-17 21:11:02 +0200)

are available in the git repository at:
  git://git.open-mesh.org/ecsv/linux-merge.git batman-adv/next

Antonio Quartulli (3):
      batman-adv: orig_hash_find() manages rcu_lock/unlock internally
      batman-adv: Move definition of atomic_dec_not_zero() into main.h
      batman-adv: fix gw_node_update() and gw_election()

Marek Lindner (1):
      batman-adv: Make bat_priv->primary_if an rcu protected pointer

 net/batman-adv/aggregation.c       |    1 -
 net/batman-adv/gateway_client.c    |   45 ++++++++++++--------
 net/batman-adv/hard-interface.c    |   83 ++++++++++++++++++++++++-----------
 net/batman-adv/hard-interface.h    |   18 ++++++++
 net/batman-adv/icmp_socket.c       |   19 ++++++--
 net/batman-adv/main.h              |    2 +
 net/batman-adv/originator.c        |   34 +++++++++------
 net/batman-adv/routing.c           |   34 ++++++---------
 net/batman-adv/send.c              |   18 ++++++--
 net/batman-adv/soft-interface.c    |   64 +++++++++++++++++++--------
 net/batman-adv/translation-table.c |   57 ++++++++++++++++++------
 net/batman-adv/types.h             |    2 +-
 net/batman-adv/unicast.c           |   16 +++++--
 net/batman-adv/vis.c               |   37 +++++++++++-----
 14 files changed, 292 insertions(+), 138 deletions(-)
