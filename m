Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Feb 2019 12:14:09 +0100
Message-Id: <20190201111412.13807-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] pull request for net: batman-adv
 2019-02-01
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

here are some bugfixes which we would like to see integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit b71acb0e372160167bf6d5500b88b30b52ccef6e:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2018-12-27 13:53:32 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20190201

for you to fetch changes up to 7d652669b61d702c6e62a39579d17f6881670ab6:

  batman-adv: release station info tidstats (2019-01-25 09:04:41 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Avoid WARN to report incorrect configuration, by Sven Eckelmann

 - Fix mac header position setting, by Sven Eckelmann

 - Fix releasing station statistics, by Felix Fietkau

----------------------------------------------------------------
Felix Fietkau (1):
      batman-adv: release station info tidstats

Sven Eckelmann (2):
      batman-adv: Avoid WARN on net_device without parent in netns
      batman-adv: Force mac header to start of data on xmit

 net/batman-adv/bat_v_elp.c      | 3 +++
 net/batman-adv/hard-interface.c | 5 +++--
 net/batman-adv/soft-interface.c | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)
