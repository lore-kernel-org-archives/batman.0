Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Apr 2011 21:30:10 +0200
Message-Id: <1303068618-27928-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-04-17
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

I would like to propose following patches for net-next-2.6/2.6.40. Most of the
stuff is cleanup work to reduce the locking complexity. The only exception is
Andrew Lunn's patch, which only adds the initialisation of tx_queue_len.

thanks,
	Sven


The following changes since commit 0ce790e7d736cedc563e1fb4e998babf5a4dbc3d:

  Linux 2.6.39-rc1 (2011-03-29 12:09:47 -0700)

are available in the git repository at:
  git://git.open-mesh.org/ecsv/linux-merge.git batman-adv/next

Andrew Lunn (1):
      batman-adv: Set the txqueuelen to zero when creating soft interface

Linus Lüssing (5):
      batman-adv: Move bonding / iface alternating router search to own functions
      batman-adv: Make gateway_get_selected type safe
      batman-adv: Simplify gw_check_election(), use gw_get_selected()
      batman-adv: Make orig_node->router an rcu protected pointer
      batman-adv: Protect global TQ window with a spinlock

Marek Lindner (1):
      batman-adv: concentrate all curr_gw related rcu operations in select/deselect functions

Simon Wunderlich (1):
      batman-adv: protect softif_neigh by rcu

 net/batman-adv/gateway_client.c |  259 ++++++++++++++++-----------
 net/batman-adv/gateway_client.h |    2 +-
 net/batman-adv/icmp_socket.c    |   18 +--
 net/batman-adv/originator.c     |   38 +++-
 net/batman-adv/originator.h     |    1 +
 net/batman-adv/routing.c        |  378 +++++++++++++++++++++------------------
 net/batman-adv/send.c           |   19 ++-
 net/batman-adv/soft-interface.c |  115 +++++++++---
 net/batman-adv/types.h          |    7 +-
 net/batman-adv/unicast.c        |    2 +-
 net/batman-adv/vis.c            |   91 +++++-----
 11 files changed, 537 insertions(+), 393 deletions(-)
