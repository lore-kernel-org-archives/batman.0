Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:49 +0100
Message-Id: <1262428252-26439-14-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-13-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
	<1262428252-26439-2-git-send-email-andrew@lunn.ch>
	<1262428252-26439-3-git-send-email-andrew@lunn.ch>
	<1262428252-26439-4-git-send-email-andrew@lunn.ch>
	<1262428252-26439-5-git-send-email-andrew@lunn.ch>
	<1262428252-26439-6-git-send-email-andrew@lunn.ch>
	<1262428252-26439-7-git-send-email-andrew@lunn.ch>
	<1262428252-26439-8-git-send-email-andrew@lunn.ch>
	<1262428252-26439-9-git-send-email-andrew@lunn.ch>
	<1262428252-26439-10-git-send-email-andrew@lunn.ch>
	<1262428252-26439-11-git-send-email-andrew@lunn.ch>
	<1262428252-26439-12-git-send-email-andrew@lunn.ch>
	<1262428252-26439-13-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 14/17] Staging: batman-adv: Allow the MAC
	address to be set
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Some embedded devices have very limited sources of entropy for the
random number generator. It has been observed that the random MAC
address on the interface bat0 is not always random. When testing with
a collection of identical hardware, sometimes the bat0 device the same
MAC address on multiple devices, causing mayhem. This patch allows the
MAC address to be set by the user.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 drivers/staging/batman-adv/soft-interface.c    |   13 +++++++++++--
 drivers/staging/batman-adv/translation-table.c |   15 +++++++++++++++
 drivers/staging/batman-adv/translation-table.h |    1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 8ae3483..bc0217b 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -145,9 +145,18 @@ struct net_device_stats *interface_stats(struct net_device *dev)
 	return &priv->stats;
 }
 
-int interface_set_mac_addr(struct net_device *dev, void *addr)
+int interface_set_mac_addr(struct net_device *dev, void *p)
 {
-	return -EBUSY;
+	struct sockaddr *addr = p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	hna_local_remove(dev->dev_addr, "mac address changed");
+	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
+	hna_local_add(dev->dev_addr);
+
+	return 0;
 }
 
 int interface_change_mtu(struct net_device *dev, int new_mtu)
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 8c8136b..53a054e 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -211,6 +211,21 @@ static void hna_local_del(struct hna_local_entry *hna_local_entry,
 	_hna_local_del(hna_local_entry);
 }
 
+void hna_local_remove(uint8_t *addr, char *message)
+{
+	struct hna_local_entry *hna_local_entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hna_local_hash_lock, flags);
+
+	hna_local_entry = (struct hna_local_entry *)
+		hash_find(hna_local_hash, addr);
+	if (hna_local_entry)
+		hna_local_del(hna_local_entry, message);
+
+	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+}
+
 void hna_local_purge(struct work_struct *work)
 {
 	struct hna_local_entry *hna_local_entry;
diff --git a/drivers/staging/batman-adv/translation-table.h b/drivers/staging/batman-adv/translation-table.h
index f7da811..281125b 100644
--- a/drivers/staging/batman-adv/translation-table.h
+++ b/drivers/staging/batman-adv/translation-table.h
@@ -23,6 +23,7 @@
 
 int hna_local_init(void);
 void hna_local_add(uint8_t *addr);
+void hna_local_remove(uint8_t *addr, char *message);
 int hna_local_fill_buffer(unsigned char *buff, int buff_len);
 int hna_local_fill_buffer_text(unsigned char *buff, int buff_len);
 void hna_local_purge(struct work_struct *work);
-- 
1.6.5.7

