Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:27 +0200
Message-Id: <1273177132-8792-2-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 01/26] staging:batman-adv: only modify
	hna-table on active module
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Linus Lüssing <linus.luessing@web.de>

If we haven't set the module to MODULE_ACTIVE state before (in general,
no interface has yet been added to batman-adv) then the hna table is not
initialised yet. If the kernel changes the mac address of the bat0
interface at this moment then an hna_local_add() called by interface_set_mac_addr()
then resulted in a null pointer derefernce. With this patch we are now
explicitly checking before if the state is MODULE_ACTIVE right now so
that we can assume having an initialised hna table.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 drivers/staging/batman-adv/soft-interface.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 0e2307f..a42b21f 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -152,9 +152,13 @@ int interface_set_mac_addr(struct net_device *dev, void *p)
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
1.7.1

