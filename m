Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 27 Feb 2010 02:49:42 +0100
Message-Id: <1267235382-4026-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: only modify hna-table on active
	module
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

If we haven't set the module to MODULE_ACTIVE state before (in general,
no interface has yet been added to batman-adv) then the hna table is not
initialised yet. If the kernel changes the mac address of the bat0
interface at this moment then an hna_local_add() called by interface_set_mac_addr()
then resulted in a null pointer derefernce. With this patch we are now
explicitly checking before if the state is MODULE_ACTIVE right now so
that we can assume having an initialised hna table.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 batman-adv-kernelland/soft-interface.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/batman-adv-kernelland/soft-interface.c b/batman-adv-kernelland/soft-interface.c
index f098a4f..582134f 100644
--- a/batman-adv-kernelland/soft-interface.c
+++ b/batman-adv-kernelland/soft-interface.c
@@ -154,9 +154,13 @@ int interface_set_mac_addr(struct net_device *dev, void *p)
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	hna_local_remove(dev->dev_addr, "mac address changed");
+	/* only modify hna-table if it has been initialised before */
+	if (atomic_read(&module_state) == MODULE_ACTIVE) {
+		hna_local_remove(dev->dev_addr, "mac address changed");
+		hna_local_add(addr->sa_data);
+	}
+
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
-	hna_local_add(dev->dev_addr);
 
 	return 0;
 }
-- 
1.7.0

