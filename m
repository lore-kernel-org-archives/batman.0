Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Dec 2016 17:13:22 +0100
Message-Id: <20161202161323.5990-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] pull request for net: batman-adv 2016-12-02
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

Hi David,

here is another bugfix which we would like to see integrated into net,
if this is possible now.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit e13258f38e927b61cdb5f4ad25309450d3b127d1:

  batman-adv: Detect missing primaryif during tp_send as error (2016-11-04 12:27:39 +0100)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20161202

for you to fetch changes up to c2d0f48a13e53b4747704c9e692f5e765e52041a:

  batman-adv: Check for alloc errors when preparing TT local data (2016-12-02 10:46:59 +0100)

----------------------------------------------------------------
Here is another batman-adv bugfix:

 - fix checking for failed allocation of TVLV blocks in TT local data,
   by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Check for alloc errors when preparing TT local data

 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
