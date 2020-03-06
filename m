Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/3] pull request for net-next: batman-adv 2020-03-06
Date: Fri,  6 Mar 2020 13:13:14 +0100
Message-Id: <20200306121317.28931-1-sw@simonwunderlich.de>
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

here is a small cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20200306

for you to fetch changes up to 5f27eb055d5c5814785fb9cf0ae4a4c150a8f334:

  batman-adv: Replace zero-length array with flexible-array member (2020-02-17 22:43:42 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Avoid RCU list-traversal in spinlock, by Sven Eckelmann

 - Replace zero-length array with flexible-array member,
   by Gustavo A. R. Silva

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      batman-adv: Replace zero-length array with flexible-array member

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (1):
      batman-adv: Avoid RCU list-traversal in spinlock

 net/batman-adv/distributed-arp-table.c | 2 +-
 net/batman-adv/main.h                  | 2 +-
 net/batman-adv/translation-table.c     | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)
