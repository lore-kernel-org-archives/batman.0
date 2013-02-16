Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 16 Feb 2013 13:47:35 +0100
Message-Id: <1361018855-10657-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1361018855-10657-1-git-send-email-ordex@autistici.org>
References: <1361018855-10657-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: remove interfacing
	enslaving loop private check
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Now that the new dev_upper API is used, the private check for enslaving loops is
not needed anymore as this is performed by the new API itself.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 hard-interface.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index fd99e42..b96f819 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -60,45 +60,6 @@ out:
 	return hard_iface;
 }
 
-/**
- * batadv_is_on_batman_iface - check if a device is a batman iface descendant
- * @net_dev: the device to check
- *
- * If the user creates any virtual device on top of a batman-adv interface, it
- * is important to prevent this new interface to be used to create a new mesh
- * network (this behaviour would lead to a batman-over-batman configuration).
- * This function recursively checks all the fathers of the device passed as
- * argument looking for a batman-adv soft interface.
- *
- * Returns true if the device is descendant of a batman-adv mesh interface (or
- * if it is a batman-adv interface itself), false otherwise
- */
-static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
-{
-	struct net_device *parent_dev;
-	bool ret;
-
-	/* check if this is a batman-adv mesh interface */
-	if (batadv_softif_is_valid(net_dev))
-		return true;
-
-	/* no more parents..stop recursion */
-	if (net_dev->iflink == net_dev->ifindex)
-		return false;
-
-	/* recurse over the parent device */
-	parent_dev = dev_get_by_index(&init_net, net_dev->iflink);
-	/* if we got a NULL parent_dev there is something broken.. */
-	if (WARN(!parent_dev, "Cannot find parent device"))
-		return false;
-
-	ret = batadv_is_on_batman_iface(parent_dev);
-
-	if (parent_dev)
-		dev_put(parent_dev);
-	return ret;
-}
-
 static int batadv_is_valid_iface(const struct net_device *net_dev)
 {
 	if (net_dev->flags & IFF_LOOPBACK)
@@ -110,10 +71,6 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
 	if (net_dev->addr_len != ETH_ALEN)
 		return 0;
 
-	/* no batman over batman */
-	if (batadv_is_on_batman_iface(net_dev))
-		return 0;
-
 	return 1;
 }
 
-- 
1.8.1.2

