Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri,  4 Feb 2011 14:57:13 +0100
Message-Id: <1296827833-27595-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296827833-27595-1-git-send-email-linus.luessing@ascom.ch>
References: <1296827833-27595-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Switch order of types.h and
	compat.h inclusion
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@acsom.ch>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

The compat.h changes should be transparent for any other of our source
files - even for types.h. Therefore switching the order.

Signed-off-by: Linus Lüssing <linus.luessing@acsom.ch>
---
 main.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman-adv/main.h b/batman-adv/main.h
index 1ec9986..bd8470d 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -114,10 +114,10 @@
 #include <net/sock.h>		/* struct sock */
 #include <linux/jiffies.h>
 #include <linux/seq_file.h>
-#include "types.h"
-
 #include "compat.h"
 
+#include "types.h"
+
 #ifndef REVISION_VERSION
 #define REVISION_VERSION_STR ""
 #else
-- 
1.7.2.3

