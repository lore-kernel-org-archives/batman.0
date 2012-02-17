Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 17 Feb 2012 15:18:20 +0800
Message-Id: <1329463110-856-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-02-17
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

David,

this is the first patch set I'd like you to pull into net-next-2.6/3.4. 
It mainly brings infrastructure to dynamically change the routing alorithm
and a couple of fixes / style improvements.
Following the "sign your git tag" trend this is our first pull request which
is signed with my key. Let me know if there any problems.

Thanks,
Marek


The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git batman-adv-for-davem

for you to fetch changes up to ea3d2fd1b11fb3ef8706a48ece0a49a61bcd08bc:

  batman-adv: export used routing algorithm via sysfs (2012-02-17 02:50:20 +0800)

----------------------------------------------------------------
infrastructure to change routing algorithm at runtime & fixes

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: add tt_initialised flag to the orig_node struct

Marek Lindner (6):
      batman-adv: simplify bat_ogm_receive API call
      batman-adv: warn if added interface is part of a bridge
      batman-adv: add infrastructure to change routing algorithm at runtime
      batman-adv: convert batman iv algorithm to use dynamic infrastructure
      batman-adv: allowing changing the routing algorithm via module parameter
      batman-adv: export used routing algorithm via sysfs

Martin Hundebøll (2):
      batman-adv: Rm empty line from is_my_mac() in main.c
      batman-adv: Move is_out_of_time() to main.h for general use

Sven Eckelmann (1):
      batman-adv: Explicitly mark the common header structure

 Documentation/ABI/testing/sysfs-class-net-mesh |    7 +
 net/batman-adv/{bat_ogm.h => bat_algo.h}       |   20 +--
 net/batman-adv/bat_debugfs.c                   |   22 ++
 net/batman-adv/bat_iv_ogm.c                    |  245 +++++++++++++-----------
 net/batman-adv/bat_sysfs.c                     |    9 +
 net/batman-adv/hard-interface.c                |   24 ++-
 net/batman-adv/icmp_socket.c                   |    6 +-
 net/batman-adv/main.c                          |  107 ++++++++++
 net/batman-adv/main.h                          |   15 ++
 net/batman-adv/originator.c                    |    1 +
 net/batman-adv/packet.h                        |   38 ++---
 net/batman-adv/routing.c                       |   24 +--
 net/batman-adv/send.c                          |    7 +-
 net/batman-adv/soft-interface.c                |   18 +-
 net/batman-adv/translation-table.c             |   67 +++----
 net/batman-adv/types.h                         |   21 ++
 net/batman-adv/unicast.c                       |   16 +-
 net/batman-adv/vis.c                           |   14 +-
 18 files changed, 426 insertions(+), 235 deletions(-)
 rename net/batman-adv/{bat_ogm.h => bat_algo.h} (51%)

