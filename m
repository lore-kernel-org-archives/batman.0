Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 19 Mar 2018 17:41:50 +0100
Message-Id: <20180319164153.11536-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/3] pull request for net-next: batman-adv
 2018-03-19
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

here is another late feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit a163dc22d515d17844435c8217ff66193d35b3fa:

  batman-adv: always assume 2-byte packet alignment (2018-02-27 13:02:54 +0100)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20180319

for you to fetch changes up to 53dd9a68ba683986ec90497586f94b941bb748a0:

  batman-adv: add multicast flags netlink support (2018-03-14 10:15:34 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - avoid redundant multicast TT entries, by Linus Luessing

 - add netlink support for distributed arp table cache and multicast flags,
   by Linus Luessing (2 patches)

----------------------------------------------------------------
Linus Lüssing (3):
      batman-adv: Avoid redundant multicast TT entries
      batman-adv: add DAT cache netlink support
      batman-adv: add multicast flags netlink support

 include/uapi/linux/batman_adv.h        |  82 +++++++++
 net/batman-adv/distributed-arp-table.c | 152 +++++++++++++++++
 net/batman-adv/distributed-arp-table.h |   8 +
 net/batman-adv/multicast.c             | 293 ++++++++++++++++++++++++++++++++-
 net/batman-adv/multicast.h             |  18 ++
 net/batman-adv/netlink.c               |  88 ++++++----
 6 files changed, 604 insertions(+), 37 deletions(-)
