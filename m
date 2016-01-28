Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Jan 2016 04:53:15 +0100
Message-Id: <1453953196-29943-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
References: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] alfred: Mount debugfs before reducing
	capabilities
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

The debugfs helper code has the ability to mount the debugfs file
system if it is not already mounted. However, it cannot do this
after the capabilities have been dropped. So perform the mount early.

This is especially important when using network name spaces. Each
namespace has its own /sys, so the mount of debugfs in the global
namespace is not visible in other namespaces.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/main.c b/main.c
index 452d9ae..b1c5ec5 100644
--- a/main.c
+++ b/main.c
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #endif
 #include "alfred.h"
+#include "debugfs.h"
 #include "packet.h"
 #include "list.h"
 
@@ -160,6 +161,9 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{NULL,			0,			NULL,	0},
 	};
 
+	/* We need full capabilities to mount debugfs, so do that now */
+	debugfs_mount(NULL);
+
 	ret = reduce_capabilities();
 	if (ret < 0)
 		return NULL;
-- 
2.7.0.rc3

