Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net: batman-adv 2019-05-09
Date: Thu,  9 May 2019 15:28:13 +0200
Message-Id: <20190509132815.3723-1-sw@simonwunderlich.de>
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

here are some bugfixes which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 438b3d3fae4346a49fe12fa7cc1dc9327f006a91:

  batman-adv: Fix genl notification for throughput_override (2019-03-25 09:31:19 +0100)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20190509

for you to fetch changes up to a3c7cd0cdf1107f891aff847ad481e34df727055:

  batman-adv: mcast: fix multicast tt/tvlv worker locking (2019-05-06 11:40:46 +0200)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich (we forgot to include
   this patch previously ...)

 - fix multicast tt/tvlv worker locking, by Linus Lüssing

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: mcast: fix multicast tt/tvlv worker locking

Simon Wunderlich (1):
      batman-adv: Start new development cycle

 net/batman-adv/main.c      |  1 +
 net/batman-adv/main.h      |  2 +-
 net/batman-adv/multicast.c | 11 +++--------
 net/batman-adv/types.h     |  5 +++++
 4 files changed, 10 insertions(+), 9 deletions(-)
