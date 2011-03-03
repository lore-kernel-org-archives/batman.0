Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Thu,  3 Mar 2011 20:09:02 +0100
Message-Id: <1299179342-15418-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1299179342-15418-1-git-send-email-linus.luessing@ascom.ch>
References: <1299179342-15418-1-git-send-email-linus.luessing@ascom.ch>
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] RFC: batman-adv: Fix null pointer deref.
	when adding hard-if as soft-if
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

When we are trying to create a batman soft-interface which already
exists as a common hard interface, batman than wrongly assumes that this
hard interface is a fully initialized soft interface. This leads to a
null pointer dereference on the first try of accessing for instance a
non-intialized orig_hash.

For every hard interface, there is no initialized orig_hash, therefore
this commit uses this criteria to abort creating a soft interface with
an already existing name.
---
 hard-interface.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 95a35b6..53d6fce 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -282,6 +282,7 @@ int hardif_enable_interface(struct hard_iface *hard_iface, char *iface_name)
 {
 	struct bat_priv *bat_priv;
 	struct batman_packet *batman_packet;
+	int ret;
 
 	if (hard_iface->if_status != IF_NOT_IN_USE)
 		goto out;
@@ -294,20 +295,32 @@ int hardif_enable_interface(struct hard_iface *hard_iface, char *iface_name)
 	if (!hard_iface->soft_iface) {
 		hard_iface->soft_iface = softif_create(iface_name);
 
-		if (!hard_iface->soft_iface)
+		if (!hard_iface->soft_iface) {
+			ret = -ENOMEM;
 			goto err;
+		}
 
 		/* dev_get_by_name() increases the reference counter for us */
 		dev_hold(hard_iface->soft_iface);
 	}
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
+
+	if (!bat_priv->orig_hash) {
+		bat_err(hard_iface->soft_iface,
+			"Can't create soft interface %s: "
+			"already exists as non soft interface\n",
+			hard_iface->soft_iface->name);
+		ret = -EINVAL;
+		goto err;
+	}
 	hard_iface->packet_len = BAT_PACKET_LEN;
 	hard_iface->packet_buff = kmalloc(hard_iface->packet_len, GFP_ATOMIC);
 
 	if (!hard_iface->packet_buff) {
 		bat_err(hard_iface->soft_iface, "Can't add interface packet "
 			"(%s): out of memory\n", hard_iface->net_dev->name);
+		ret = -ENOMEM;
 		goto err;
 	}
 
@@ -370,7 +383,7 @@ out:
 
 err:
 	hardif_free_ref(hard_iface);
-	return -ENOMEM;
+	return ret;
 }
 
 void hardif_disable_interface(struct hard_iface *hard_iface)
-- 
1.7.2.3

