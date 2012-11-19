Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 19 Nov 2012 09:24:01 +0100
Message-Id: <1353313451-2930-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-11-19
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

this should be our last batch of patches intended for net-next/linux-3.8.
In this patchset we have patches 7,8/10 by Sven Eckelmann which improve the crc
computation on broadcast packets (in the Bridge Loop Avoidance component) by
using crc32c and by avoiding the entire linearisation of the skb! Then, patch
4/10 introduces a new debugfs file which exports the compatibility version so
that users having different batman-adv releases can understand whether they can
or cannot communicate.
Patch 10/10 removes the packed attribute for the unicast message type and adds
"#pragma pack(2)" (again, this is just part of our intermediate changes which do
not break compatibility. The real restructure will come later..).


The others are cleanups or small code refactoring.


Let me know if there is any problem!

Thank you,
	Antonio


The following changes since commit 3594698a1fb8e5ae60a92c72ce9ca280256939a7:

  net: Make CAP_NET_BIND_SERVICE per user namespace (2012-11-18 20:33:37 -0500)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to 15401e33ef94d4f251c42e8228e6c387327f38f8:

  batman-adv: Use packing of 2 for all headers before an ethernet header (2012-11-19 09:14:11 +0100)

----------------------------------------------------------------
Included changes:
- Increase batman-adv version
- Bridge Loop Avoidance: compute checksum (using crc32) on skb fragments instead
  of linearising it
- sort the sysfs documentation
- export the compatibility version via debugfs
- some other minor cleanups

----------------------------------------------------------------
Antonio Quartulli (2):
      batman-adv: support array of debugfs general attributes
      batman-adv: export compatibility version via debugfs

Marek Lindner (1):
      batman-adv: sysfs documentation should keep alphabetical order

Martin Hundebøll (1):
      batman-adv: Add wrapper to look up neighbor and send skb

Simon Wunderlich (2):
      batman-adv: fix bla compare function
      batman-adv: Fix broadcast duplist for fragmentation

Sven Eckelmann (4):
      batman-adv: Mark best gateway in transtable_global debugfs
      batman-adv: Add function to calculate crc32c for the skb payload
      batman-adv: Start new development cycle
      batman-adv: Use packing of 2 for all headers before an ethernet header

 .../ABI/testing/sysfs-class-net-batman-adv         |  11 +-
 Documentation/ABI/testing/sysfs-class-net-mesh     |  40 +++---
 net/batman-adv/Kconfig                             |   1 +
 net/batman-adv/bridge_loop_avoidance.c             |  36 +++--
 net/batman-adv/bridge_loop_avoidance.h             |   6 +-
 net/batman-adv/debugfs.c                           |  46 ++++--
 net/batman-adv/main.c                              |  46 ++++++
 net/batman-adv/main.h                              |   4 +-
 net/batman-adv/packet.h                            |  16 ++-
 net/batman-adv/routing.c                           |  45 ++----
 net/batman-adv/send.c                              |  33 +++++
 net/batman-adv/send.h                              |   3 +
 net/batman-adv/translation-table.c                 | 155 +++++++++++----------
 net/batman-adv/types.h                             |   2 +-
 net/batman-adv/unicast.c                           |   8 +-
 net/batman-adv/vis.c                               |  35 ++---
 16 files changed, 293 insertions(+), 194 deletions(-)
