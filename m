Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 30 Jun 2016 10:09:25 +0200
Message-Id: <1467274165-2866-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix Kconfig dependencies
	regarding multicast optimizations
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

Since recently the multicast optimizations are using functions from the
bridge module. If batman-adv is a kernel built-in, then these bridge
functions need to be accessible immediately. Thus adding a Kconfig
dependency for the multicast optimizations to depend on batman-adv being
built as a module if the bridge is built as a module, too.

This fixes build errors like the following:

~~~
   net/built-in.o: In function `batadv_mcast_mla_update':
>> (.text+0x19b7eb): undefined reference to `br_multicast_has_querier_anywhere'
   net/built-in.o: In function `batadv_mcast_mla_update':
>> (.text+0x19b7fa): undefined reference to `br_multicast_has_querier_adjacent'
   net/built-in.o: In function `batadv_mcast_mla_update':
   (.text+0x19b809): undefined reference to `br_multicast_has_querier_anywhere'
   net/built-in.o: In function `batadv_mcast_mla_update':
   (.text+0x19b818): undefined reference to `br_multicast_has_querier_adjacent'
   net/built-in.o: In function `batadv_mcast_mla_update':
>> (.text+0x19b8cf): undefined reference to `br_multicast_list_adjacent'
~~~

Fixes: 391b59cdb111 ("batman-adv: Add multicast optimization support for bridged setups")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index b7ba97d..833bb14 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -66,7 +66,7 @@ config BATMAN_ADV_NC
 
 config BATMAN_ADV_MCAST
 	bool "Multicast optimisation"
-	depends on BATMAN_ADV && INET
+	depends on BATMAN_ADV && INET && !(BRIDGE=m && BATMAN_ADV=y)
 	default n
 	help
 	  This option enables the multicast optimisation which aims to
-- 
2.1.4

