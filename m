Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 22 Jan 2017 21:40:43 +0100
Message-Id: <20170122204043.29668-4-linus.luessing@c0d3.blue>
In-Reply-To: <20170122204043.29668-1-linus.luessing@c0d3.blue>
References: <20170122204043.29668-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: compat: add missing includes
	for compat skbuff.c
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Compile issues were reported with some 3.2 kernel. Adding the missing
includes to the compat skbuff.c file should fix those.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 compat-sources/net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
index 44d59dc..40c9e8b 100644
--- a/compat-sources/net/core/skbuff.c
+++ b/compat-sources/net/core/skbuff.c
@@ -32,8 +32,12 @@
  *	2 of the License, or (at your option) any later version.
  */
 
+#include <linux/in6.h>
 #include <linux/ipv6.h>
 #include <linux/skbuff.h>
+#include <linux/types.h>
+#include <net/checksum.h>
+#include <net/ip6_checksum.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
 
-- 
2.1.4

