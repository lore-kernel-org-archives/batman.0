Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Tue,  5 Dec 2017 15:35:11 +0100
Message-Id: <20171205143514.4441-4-sven.eckelmann@openmesh.com>
In-Reply-To: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [RFC v2 3/6] batman-adv: Let packet.h include its
 headers directly
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@openmesh.com>

The headers used by packet.h should also be included by it directly. main.h
is currently dealing with it in batman-adv, but this will no longer work
when this header is moved to include/uapi/linux/.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 net/batman-adv/main.h   | 2 --
 net/batman-adv/packet.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 69c2ab666961..231bbc47910e 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -219,10 +219,8 @@ enum batadv_uev_type {
 
 /* Kernel headers */
 
-#include <linux/bitops.h> /* for packet.h */
 #include <linux/compiler.h>
 #include <linux/etherdevice.h>
-#include <linux/if_ether.h> /* for packet.h */
 #include <linux/if_vlan.h>
 #include <linux/jiffies.h>
 #include <linux/percpu.h>
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index ebe0605d1505..0d011012c71a 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -22,6 +22,8 @@
 #define _NET_BATMAN_ADV_PACKET_H_
 
 #include <asm/byteorder.h>
+#include <linux/bitops.h>
+#include <linux/if_ether.h>
 #include <linux/types.h>
 
 /**
-- 
2.11.0

