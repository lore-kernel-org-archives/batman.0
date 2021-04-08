Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/3] pull request for net-next: batman-adv 2021-04-08
Date: Thu,  8 Apr 2021 13:53:58 +0200
Message-Id: <20210408115401.16988-1-sw@simonwunderlich.de>
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
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi Jakub, hi David,

here is a little cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit b1de0f01b0115575982cf24c88b35106449e9a=
a7:

  batman-adv: Use netif_rx_any_context(). (2021-02-13 18:08:40 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20=
210408

for you to fetch changes up to 35796c1d343871fa75a6e6b0f4584182cbeae6ac:

  batman-adv: Fix misspelled "wont" (2021-03-30 21:19:50 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - for kerneldoc in batadv_priv, by Linus Luessing

 - drop unused header preempt.h, by Sven Eckelmann

 - Fix misspelled "wont", by Sven Eckelmann

----------------------------------------------------------------
Linus L=C3=BCssing (1):
      batman-adv: Fix order of kernel doc in batadv_priv

Sven Eckelmann (2):
      batman-adv: Drop unused header preempt.h
      batman-adv: Fix misspelled "wont"

 net/batman-adv/bat_iv_ogm.c            |  2 +-
 net/batman-adv/bridge_loop_avoidance.c |  1 -
 net/batman-adv/types.h                 | 10 +++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)
