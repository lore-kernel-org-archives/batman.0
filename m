Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:13 +0200
Message-Id: <1273261651-21378-9-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 08/26] Staging: batman-adv: Add 0.2.1 changes
	to the CHANGELOG
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/CHANGELOG |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/batman-adv/CHANGELOG b/drivers/staging/batman-adv/CHANGELOG
index 8a18163..c8f9d9e 100644
--- a/drivers/staging/batman-adv/CHANGELOG
+++ b/drivers/staging/batman-adv/CHANGELOG
@@ -1,3 +1,17 @@
+batman-adv 0.2.1:
+
+* support latest kernels (2.6.20 - 2.6.33)
+* receive packets directly using skbs, remove old sockets and threads
+* fix various regressions in the vis server
+* don't disable interrupts while sending
+* replace internal logging mechanism with standard kernel logging
+* move vis formats into userland, one general format remains in the kernel
+* allow MAC address to be set, correctly initialize them
+* code refactoring and cleaning for coding style
+* many bugs (null pointers, locking, hash iterators) squashed
+
+ -- Sun, 21 Mar 2010 20:46:47 +0100
+
 batman-adv 0.2:
 
 * support latest kernels (2.6.20 - 2.6.31)
-- 
1.7.1

