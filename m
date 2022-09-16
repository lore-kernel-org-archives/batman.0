Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net-next: batman-adv 2022-09-16
Date: Fri, 16 Sep 2022 18:14:50 +0200
Message-Id: <20220916161454.1413154-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
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

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b8=
68:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20=
220916

for you to fetch changes up to 76af7483b3c7c42571aae767b553ef7d436305e9:

  batman-adv: remove unused struct definitions (2022-09-15 08:16:05 +0200=
)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - drop unused headers in trace.h, by Sven Eckelmann

 - drop initialization of flexible ethtool_link_ksettings,
   by Sven Eckelmann

 - remove unused struct definitions, by Marek Lindner

----------------------------------------------------------------
Marek Lindner (1):
      batman-adv: remove unused struct definitions

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (2):
      batman-adv: Drop unused headers in trace.h
      batman-adv: Drop initialization of flexible ethtool_link_ksettings

 net/batman-adv/bat_v_elp.c |  1 -
 net/batman-adv/main.h      |  2 +-
 net/batman-adv/trace.h     |  2 --
 net/batman-adv/types.h     | 39 ---------------------------------------
 4 files changed, 1 insertion(+), 43 deletions(-)
