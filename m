Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Jul 2018 17:19:40 +0200
Message-Id: <20180717151946.31900-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/6] pull request for net: batman-adv
 2018-07-17
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

here are some batman-adv bugfixes for net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20180717

for you to fetch changes up to a44ebeff6bbd6ef50db41b4195fca87b21aefd20:

  batman-adv: Fix multicast TT issues with bogus ROAM flags (2018-06-23 10:29:33 +0200)

----------------------------------------------------------------
Here are some batman-adv fixes:

 - Fix gateway refcounting in BATMAN IV and V, by Sven Eckelmann (2 patches)

 - Fix debugfs paths when renaming interfaces, by Sven Eckelmann (2 patches)

 - Fix TT flag issues, by Linus Luessing (2 patches)

----------------------------------------------------------------
Linus Lüssing (2):
      batman-adv: Avoid storing non-TT-sync flags on singular entries too
      batman-adv: Fix multicast TT issues with bogus ROAM flags

Sven Eckelmann (4):
      batman-adv: Fix bat_ogm_iv best gw refcnt after netlink dump
      batman-adv: Fix bat_v best gw refcnt after netlink dump
      batman-adv: Fix debugfs path for renamed hardif
      batman-adv: Fix debugfs path for renamed softif

 net/batman-adv/bat_iv_ogm.c        |  4 +++-
 net/batman-adv/bat_v.c             |  4 +++-
 net/batman-adv/debugfs.c           | 40 ++++++++++++++++++++++++++++++++++++++
 net/batman-adv/debugfs.h           | 11 +++++++++++
 net/batman-adv/hard-interface.c    | 37 +++++++++++++++++++++++++++++------
 net/batman-adv/translation-table.c |  7 +++++--
 6 files changed, 93 insertions(+), 10 deletions(-)
