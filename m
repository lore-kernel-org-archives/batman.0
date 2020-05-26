Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/3] pull request for net-next: batman-adv 2020-05-26
Date: Tue, 26 May 2020 12:00:04 +0200
Message-Id: <20200526100007.10501-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi David,

here is a small cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 1a33e10e4a95cb109ff1145098175df3113313=
ef:

  net: partially revert dynamic lockdep key changes (2020-05-04 12:05:56 =
-0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-2020=
0526

for you to fetch changes up to 9ad346c90509ebd983f60da7d082f261ad329507:

  batman-adv: Revert "disable ethtool link speed detection when auto nego=
tiation off" (2020-05-26 09:23:33 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - Fix revert dynamic lockdep key changes for batman-adv,
   by Sven Eckelmann

 - use rcu_replace_pointer() where appropriate, by Antonio Quartulli

 - Revert "disable ethtool link speed detection when auto negotiation
   off", by Sven Eckelmann

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: use rcu_replace_pointer() where appropriate

Sven Eckelmann (2):
      batman-adv: Revert "Drop lockdep.h include for soft-interface.c"
      batman-adv: Revert "disable ethtool link speed detection when auto =
negotiation off"

 net/batman-adv/bat_v_elp.c      | 15 +--------------
 net/batman-adv/gateway_client.c |  4 ++--
 net/batman-adv/hard-interface.c |  4 ++--
 net/batman-adv/routing.c        |  4 ++--
 net/batman-adv/soft-interface.c |  1 +
 5 files changed, 8 insertions(+), 20 deletions(-)
