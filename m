Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/3] pull request for net: batman-adv 2020-08-24
Date: Mon, 24 Aug 2020 18:21:08 +0200
Message-Id: <20200824162111.29220-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

here are some bugfixes which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bb=
f5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20200=
824

for you to fetch changes up to 279e89b2281af3b1a9f04906e157992c19c9f163:

  batman-adv: bla: use netif_rx_ni when not in interrupt context (2020-08=
-18 19:40:03 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Avoid uninitialized memory access when handling DHCP, by Sven Eckelman=
n

 - Fix check for own OGM in OGM receive handler, by Linus Luessing

 - Fix netif_rx access for non-interrupt context in BLA, by Jussi Kivilin=
na

----------------------------------------------------------------
Jussi Kivilinna (1):
      batman-adv: bla: use netif_rx_ni when not in interrupt context

Linus L=C3=BCssing (1):
      batman-adv: Fix own OGM check in aggregated OGMs

Sven Eckelmann (1):
      batman-adv: Avoid uninitialized chaddr when handling DHCP

 net/batman-adv/bat_v_ogm.c             | 11 ++++++-----
 net/batman-adv/bridge_loop_avoidance.c |  5 ++++-
 net/batman-adv/gateway_client.c        |  6 ++++--
 3 files changed, 14 insertions(+), 8 deletions(-)
