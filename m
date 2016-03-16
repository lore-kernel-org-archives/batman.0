Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 16 Mar 2016 20:51:10 +0100
Message-Id: <1458157872-15879-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH v2 0/2] netns support for alfred
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

Dropped patch #1, since it has been merged
Fixed the socket leak
Removed redundant calls to mount debugfs 

Andrew Lunn (2):
  alfred: Add support for network namespaces
  alfred: Mount debugfs before reducing capabilities

 batadv_query.c | 19 +------------------
 debugfs.c      | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 main.c         |  4 ++++
 vis/vis.h      |  2 +-
 4 files changed, 54 insertions(+), 20 deletions(-)

-- 
2.7.0.rc3

