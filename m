Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net-next: batman-adv 2022-05-08
Date: Sun,  8 May 2022 15:26:14 +0200
Message-Id: <20220508132616.21232-1-sw@simonwunderlich.de>
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

here is a very little cleanup pull request of batman-adv to go into net-n=
ext.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc=
17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20=
220508

for you to fetch changes up to 8864d2fcf04385cabb8c8bb159f1f2ba5790cf71:

  batman-adv: remove unnecessary type castings (2022-04-22 11:23:46 +0200=
)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - remove unnecessary type castings, by Yu Zhe

----------------------------------------------------------------
Simon Wunderlich (1):
      batman-adv: Start new development cycle

Yu Zhe (1):
      batman-adv: remove unnecessary type castings

 net/batman-adv/bridge_loop_avoidance.c |  4 ++--
 net/batman-adv/main.h                  |  2 +-
 net/batman-adv/translation-table.c     | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)
