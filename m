Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Apr 2016 22:54:55 +0200
Message-Id: <1461876897-12677-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 0/2] batctl: Netlink support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Extend batctl to use the netlink socket where available.  If it is not
available, fall back to debugfs.

No attempt has been made to keep the netlink output compatible with
the debugfs output. Anything why tries the parse the output is
probably broken.

BLA has not been tested, so is also probably broken.

Andrew Lunn (2):
  batctl: Document a network namespaces example.
  batctl: Use netlink when available, rather than debugfs

 Makefile    |  20 +-
 README      |  58 +++++
 debug.c     |  19 +-
 debug.h     |   4 +-
 functions.c |  11 +
 functions.h |   1 +
 main.h      |   1 +
 netlink.c   | 810 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 920 insertions(+), 4 deletions(-)
 create mode 100644 netlink.c

-- 
2.8.0.rc3

