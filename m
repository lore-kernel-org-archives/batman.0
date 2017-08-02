Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  2 Aug 2017 16:15:41 +0200
Message-Id: <20170802141542.13059-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/1] pull request for net: batman-adv
 2017-08-02
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

here is a bugfix which we would like to see integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20170802

for you to fetch changes up to 54e22f265e872ae140755b3318521d400a094605:

  batman-adv: fix TT sync flag inconsistencies (2017-07-31 11:17:38 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - fix TT sync flag inconsistency problems, which can lead to excess packets,
   by Linus Luessing

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: fix TT sync flag inconsistencies

 net/batman-adv/translation-table.c | 60 ++++++++++++++++++++++++++++++++------
 net/batman-adv/types.h             |  2 ++
 2 files changed, 53 insertions(+), 9 deletions(-)
