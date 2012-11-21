Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 21 Nov 2012 13:11:50 +0100
Message-Id: <1353499919-28596-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-11-21
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

here is again our changeset intended for net-next/linux-3.8.
Since the last pull request I removed the patch we were discussing about (the
one exporting the batman-adv compatibility version) as we intend to do not
provide the user the feeling of being "incompatible everyday".

As we discussed some time ago, we are doing what we can to speed our
stabilisation process up and we are not going to break compatibility anymore
before we ultimate such process.

However, I see that every now and then you have the feeling we are not really
doing so. In that case, please, point out what you think is not adequate so that
we can quickly fix it.

Again: we want to stabilise the protocol/messages format and any help/suggestion
from you or the other maintainers is always well accepted (other than being
"rude" only or not answering at all. When you do so, then we have to spend the
entire day in trying to decrypt what was wrong and what we should do to address
the problem, limiting our fun and productivity).


Please pull or let me know if there is any other problem in this batch.


Thank you very much,
		Antonio


The following changes since commit de4594a51c904ddcd6c3a6cdd100f7c1d94d3239:

  sctp: send abort chunk when max_retrans exceeded (2012-11-20 15:50:37 -0500)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to e022b956c11084f3ee1c6ece523e14ac07b7c645:

  batman-adv: Use packing of 2 for all headers before an ethernet header (2012-11-21 12:35:47 +0100)

----------------------------------------------------------------
Included changes:
- Increase batman-adv version
- Bridge Loop Avoidance: compute checksum (using crc32) on skb fragments instead
  of linearising it
- sort the sysfs documentation
- some other minor cleanups

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: support array of debugfs general attributes

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
 net/batman-adv/debugfs.c                           |  34 +++--
 net/batman-adv/main.c                              |  34 +++++
 net/batman-adv/main.h                              |   3 +-
 net/batman-adv/packet.h                            |  16 ++-
 net/batman-adv/routing.c                           |  45 ++----
 net/batman-adv/send.c                              |  33 +++++
 net/batman-adv/send.h                              |   3 +
 net/batman-adv/translation-table.c                 | 155 +++++++++++----------
 net/batman-adv/types.h                             |   2 +-
 net/batman-adv/unicast.c                           |   8 +-
 net/batman-adv/vis.c                               |  35 ++---
 16 files changed, 268 insertions(+), 194 deletions(-)
