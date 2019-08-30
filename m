Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net: batman-adv 2019-08-30
Date: Fri, 30 Aug 2019 09:25:00 +0200
Message-Id: <20190830072502.16929-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>

Hi David,

here is another small batman-adv pull request for net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 3ee1bb7aae97324ec9078da1f00cb2176919563f:

  batman-adv: fix uninit-value in batadv_netlink_get_ifindex() (2019-08-14 19:27:07 +0200)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20190830

for you to fetch changes up to 0ff0f15a32c093381ad1abc06abe85afb561ab28:

  batman-adv: Only read OGM2 tvlv_len after buffer len check (2019-08-23 18:20:31 +0200)

----------------------------------------------------------------
Here are two batman-adv bugfixes:

 - Fix OGM and OGMv2 header read boundary check,
   by Sven Eckelmann (2 patches)

----------------------------------------------------------------
Sven Eckelmann (2):
      batman-adv: Only read OGM tvlv_len after buffer len check
      batman-adv: Only read OGM2 tvlv_len after buffer len check

 net/batman-adv/bat_iv_ogm.c | 20 +++++++++++++-------
 net/batman-adv/bat_v_ogm.c  | 18 ++++++++++++------
 2 files changed, 25 insertions(+), 13 deletions(-)
