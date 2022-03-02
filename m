Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net-next: batman-adv 2022-03-02
Date: Wed,  2 Mar 2022 17:35:18 +0100
Message-Id: <20220302163522.102842-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi Jakub, hi David,

here is a little cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

There might be a small merge conflict between the net and net-next pull
requests which I both send today, specifically those two commits:

* (batadv/net) 690bb6fb64f5 ("batman-adv: Request iflink once in batadv-o=
n-batadv check")
* (batadv/net-next) 6ee3c393eeb7 ("batman-adv: Demote batadv-on-batadv sk=
ip error message")

They should be resolved like this:=20

--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -167,13 +167,7 @@
 		return false;
=20
 	/* recurse over the parent device */
-<<<<<<<
-	parent_dev =3D __dev_get_by_index((struct net *)parent_net,
-					dev_get_iflink(net_dev));
-=3D=3D=3D=3D=3D=3D=3D
 	parent_dev =3D __dev_get_by_index((struct net *)parent_net, iflink);
-	/* if we got a NULL parent_dev there is something broken.. */
->>>>>>>
 	if (!parent_dev) {
 		pr_warn("Cannot find parent device. Skipping batadv-on-batadv check fo=
r %s\n",
 			net_dev->name);

Thank you,
      Simon

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac=
07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20=
220302

for you to fetch changes up to 6ee3c393eeb7d16a3c228c4fa23913b76c7e7df3:

  batman-adv: Demote batadv-on-batadv skip error message (2022-03-02 09:0=
0:17 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Remove redundant 'flush_workqueue()' calls, by Christophe JAILLET

 - Migrate to linux/container_of.h, by Sven Eckelmann

 - Demote batadv-on-batadv skip error message, by Sven Eckelmann

----------------------------------------------------------------
Christophe JAILLET (1):
      batman-adv: Remove redundant 'flush_workqueue()' calls

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (2):
      batman-adv: Migrate to linux/container_of.h
      batman-adv: Demote batadv-on-batadv skip error message

 net/batman-adv/bat_iv_ogm.c            | 2 +-
 net/batman-adv/bat_v_elp.c             | 2 +-
 net/batman-adv/bat_v_ogm.c             | 2 +-
 net/batman-adv/bridge_loop_avoidance.c | 1 +
 net/batman-adv/distributed-arp-table.c | 2 +-
 net/batman-adv/gateway_client.c        | 1 +
 net/batman-adv/hard-interface.c        | 6 +++---
 net/batman-adv/main.c                  | 2 +-
 net/batman-adv/main.h                  | 2 +-
 net/batman-adv/multicast.c             | 1 +
 net/batman-adv/network-coding.c        | 2 +-
 net/batman-adv/originator.c            | 2 +-
 net/batman-adv/send.c                  | 2 +-
 net/batman-adv/soft-interface.c        | 2 +-
 net/batman-adv/tp_meter.c              | 2 +-
 net/batman-adv/translation-table.c     | 2 +-
 net/batman-adv/tvlv.c                  | 2 +-
 17 files changed, 19 insertions(+), 16 deletions(-)
