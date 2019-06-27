Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net: batman-adv 2019-06-27
Date: Thu, 27 Jun 2019 12:31:17 +0200
Message-Id: <20190627103119.6969-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

here are some bugfixes which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20190627

for you to fetch changes up to 9e6b5648bbc4cd48fab62cecbb81e9cc3c6e7e88:

  batman-adv: Fix duplicated OGMs on NETDEV_UP (2019-06-02 13:33:48 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - fix a leaked TVLV handler which wasn't unregistered, by Jeremy Sowden

 - fix duplicated OGMs when interfaces are set UP, by Sven Eckelmann

----------------------------------------------------------------
Jeremy Sowden (1):
      batman-adv: fix for leaked TVLV handler.

Sven Eckelmann (1):
      batman-adv: Fix duplicated OGMs on NETDEV_UP

 net/batman-adv/bat_iv_ogm.c        | 4 ++--
 net/batman-adv/hard-interface.c    | 3 +++
 net/batman-adv/translation-table.c | 2 ++
 net/batman-adv/types.h             | 3 +++
 4 files changed, 10 insertions(+), 2 deletions(-)
