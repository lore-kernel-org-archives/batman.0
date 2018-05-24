Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 13:53:21 +0200
Message-Id: <20180524115325.15355-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/4] pull request for net: batman-adv
 2018-05-24
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

here are a couple of bugfixes which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20180524

for you to fetch changes up to 16116dac23396e73c01eeee97b102e4833a4b205:

  batman-adv: prevent TT request storms by not sending inconsistent TT TLVLs (2018-05-12 18:53:08 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - prevent hardif_put call with NULL parameter, by Colin Ian King

 - Avoid race in Translation Table allocator, by Sven Eckelmann

 - Fix Translation Table sync flags for intermediate Responses,
   by Linus Luessing

 - prevent sending inconsistent Translation Table TVLVs,
   by Marek Lindner

----------------------------------------------------------------
Colin Ian King (1):
      batman-adv: don't pass a NULL hard_iface to batadv_hardif_put

Linus Lüssing (1):
      batman-adv: Fix TT sync flags for intermediate TT responses

Marek Lindner (1):
      batman-adv: prevent TT request storms by not sending inconsistent TT TLVLs

Sven Eckelmann (1):
      batman-adv: Avoid race in TT TVLV allocator helper

 net/batman-adv/multicast.c         |  2 +-
 net/batman-adv/translation-table.c | 84 ++++++++++++++++++++++++++++++--------
 2 files changed, 68 insertions(+), 18 deletions(-)
