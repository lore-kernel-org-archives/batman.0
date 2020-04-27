Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net: batman-adv 2020-04-27
Date: Mon, 27 Apr 2020 17:00:35 +0200
Message-Id: <20200427150039.28730-1-sw@simonwunderlich.de>
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

here are some bugfixes which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f31=
36:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20200=
427

for you to fetch changes up to 6f91a3f7af4186099dd10fa530dd7e0d9c29747d:

  batman-adv: Fix refcnt leak in batadv_v_ogm_process (2020-04-21 10:08:0=
5 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - fix random number generation in network coding, by George Spelvin

 - fix reference counter leaks, by Xiyu Yang (3 patches)

----------------------------------------------------------------
George Spelvin (1):
      batman-adv: fix batadv_nc_random_weight_tq

Xiyu Yang (3):
      batman-adv: Fix refcnt leak in batadv_show_throughput_override
      batman-adv: Fix refcnt leak in batadv_store_throughput_override
      batman-adv: Fix refcnt leak in batadv_v_ogm_process

 net/batman-adv/bat_v_ogm.c      | 2 +-
 net/batman-adv/network-coding.c | 9 +--------
 net/batman-adv/sysfs.c          | 3 ++-
 3 files changed, 4 insertions(+), 10 deletions(-)
