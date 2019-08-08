Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net-next: batman-adv 2019-08-08
Date: Thu,  8 Aug 2019 15:06:15 +0200
Message-Id: <20190808130619.4481-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

here is a small feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20190808

for you to fetch changes up to 9cb9a17813bf0de1f8ad6deb9538296d5148b5a8:

  batman-adv: BATMAN_V: aggregate OGMv2 packets (2019-08-04 22:22:00 +0200)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Replace usage of strlcpy with strscpy, by Sven Eckelmann

 - Add OGMv2 per-interface queue and aggregations, by Linus Luessing
   (2 patches)

----------------------------------------------------------------
Linus Lüssing (2):
      batman-adv: BATMAN_V: introduce per hard-iface OGMv2 queues
      batman-adv: BATMAN_V: aggregate OGMv2 packets

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (1):
      batman-adv: Replace usage of strlcpy with strscpy

 net/batman-adv/bat_v.c          |   7 ++
 net/batman-adv/bat_v_ogm.c      | 179 +++++++++++++++++++++++++++++++++++++++-
 net/batman-adv/bat_v_ogm.h      |   3 +
 net/batman-adv/main.h           |   2 +-
 net/batman-adv/soft-interface.c |   8 +-
 net/batman-adv/sysfs.c          |   2 +-
 net/batman-adv/types.h          |  12 +++
 7 files changed, 205 insertions(+), 8 deletions(-)
