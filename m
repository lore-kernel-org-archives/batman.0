Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/3] pull request for net: batman-adv 2022-03-02
Date: Wed,  2 Mar 2022 17:30:46 +0100
Message-Id: <20220302163049.101957-1-sw@simonwunderlich.de>
MIME-Version: 1.0
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
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi David, hi Jakub,

here are some bugfixes for batman-adv which we would like to have integra=
ted into net.

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

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-202=
20302

for you to fetch changes up to 6c1f41afc1dbe59d9d3c8bb0d80b749c119aa334:

  batman-adv: Don't expect inter-netns unique iflink indices (2022-03-02 =
09:24:55 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Remove redundant iflink requests, by Sven Eckelmann (2 patches)

 - Don't expect inter-netns unique iflink indices, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (3):
      batman-adv: Request iflink once in batadv-on-batadv check
      batman-adv: Request iflink once in batadv_get_real_netdevice
      batman-adv: Don't expect inter-netns unique iflink indices

 net/batman-adv/hard-interface.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)
