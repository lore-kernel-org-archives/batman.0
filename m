Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue,  1 Mar 2016 22:19:04 +0100
Message-Id: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv2 0/4] batman-adv: Add network name space
	support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

This patchset makes batman-adv network namespace aware. A soft
interface can be creates in a namespace and hard interfaces added to
it. soft interfaces cannot be moved between name spaces.

The biggest change is to debugfs, which is not natively netns aware,
unlike sysfs which is. A new netns directory has been added and within
that, a directory per network name space which batman is used within.
The changes are backwards compatible, in that interfaces in the global
namespace are not placed into a subdirectory.

v2:

Added missing includes
Added missing forward declarations
Rearranged debugfs code
Fixed kernel doc
Rebased on https://git.open-mesh.org/batman-adv.git master

Andrew Lunn (4):
  batman-adv: NETIF_F_NETNS_LOCAL feature to prevent netns moves
  batman-adv: Create batman soft interfaces within correct netns.
  batman-adv: Handle parent interfaces in a different netns
  batman-adv: debugfs: Add netns support

 net/batman-adv/debugfs.c           | 119 ++++++++++++++++++++++++++++++++++++-
 net/batman-adv/hard-interface.c    |  36 ++++++++---
 net/batman-adv/hard-interface.h    |   3 +-
 net/batman-adv/soft-interface.c    |   9 ++-
 net/batman-adv/soft-interface.h    |   3 +-
 net/batman-adv/sysfs.c             |   3 +-
 net/batman-adv/translation-table.c |   4 +-
 7 files changed, 157 insertions(+), 20 deletions(-)

-- 
2.7.0.rc3

