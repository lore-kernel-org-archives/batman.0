Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  9 Jun 2011 23:09:08 +0200
Message-Id: <1307653754-5014-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-06-09
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

I would like to propose following changes for net-next-2.6/3.1. Most
patches are simple cleanup patches and only Daniele Furlan provided an
enhancement which should fix some routing decisions when a mesh node is
overloaded and OGMs get delayed.

Thanks,
	Sven


The following changes since commit bb899b89f46eb1fd6f62a4c360f6511b9714e479:

  batman-adv: Ensure that we really have route changes in update_route (2011-05-30 07:39:37 +0200)

are available in the git repository at:
  git://git.open-mesh.org/ecsv/linux-merge.git batman-adv/next

Daniele Furlan (1):
      batman-adv: accept delayed rebroadcasts to avoid bogus routing under heavy load

Marek Lindner (1):
      batman-adv: use NO_FLAGS define instead of hard-coding 0

Sven Eckelmann (4):
      batman-adv: Don't return value in void function
      batman-adv: Fix signedness problem in parse_gw_bandwidth
      batman-adv: Rewrite debugfs kobj_to_* helpers as functions
      batman-adv: Use enums for related constants

 net/batman-adv/aggregation.c    |    2 +-
 net/batman-adv/bat_sysfs.c      |   14 +++++++++--
 net/batman-adv/gateway_client.c |    6 ++--
 net/batman-adv/gateway_common.c |    4 +-
 net/batman-adv/hard-interface.c |    2 +-
 net/batman-adv/hard-interface.h |   14 ++++++-----
 net/batman-adv/main.h           |   19 ++++++++++-----
 net/batman-adv/packet.h         |   47 ++++++++++++++++++++++++---------------
 net/batman-adv/routing.c        |    9 +++----
 net/batman-adv/send.c           |    2 +-
 10 files changed, 72 insertions(+), 47 deletions(-)
