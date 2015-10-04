Return-Path: <christof.schulze@gmx.net>
From: Christof Schulze <christof.schulze@gmx.net>
Date: Sun, 04 Oct 2015 16:24:11 +0200
Message-ID: <37028290.5tXI0TbgDB@lappi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [B.A.T.M.A.N.] Batman-advanced-dkms + debian + kernel >4.1
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: siwu@hrz.tu-chemnitz.de, b a t m a n <b.a.t.m.a.n@lists.open-mesh.org>
Cc: info@wifi-frankfurt.de, thomas@t-8ch.de

Hello Simon,

when trying to run batman v14 on a current kernel (I noticed it for Version
4.1) I realized that batman will not build beause the netdev-structs
  have changed.
The solution is fairly simple because the fix has already been
implemented in newer batman versions. The function
batadv_is_on_batman_iface can be copied from there and is working fine.

I am running a system with kernel 4.1 that was patched in this manner
and it has been working fine in a large mesh (Freifunk Frankfurt am
Main) for a week.
The patch should work well for older kernels too because the
netdev-changes have been there for quite a while.

Now: Where is the correct place to implement the patch: in
batman-adv-dkms or in batman itself?

Regards
Christof


--- hard-interface.c-orig	2015-09-25 09:58:07.123947197 +0200
+++ hard-interface.c	2015-09-25 10:04:34.611914938 +0200
@@ -74,29 +74,28 @@
  * if it is a batman-adv interface itself), false otherwise
  */
 static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
-{
-	struct net_device *parent_dev;
-	bool ret;
+{       
+        struct net_device *parent_dev;
+        bool ret;
+        
+        /* check if this is a batman-adv mesh interface */
+        if (batadv_softif_is_valid(net_dev))
+                return true;                                                                                  
+                                                                                                              
+        /* no more parents..stop recursion */                                                                 
+        if (dev_get_iflink(net_dev) == 0 ||
+            dev_get_iflink(net_dev) == net_dev->ifindex)
+                return false;
+
+        /* recurse over the parent device */
+        parent_dev = __dev_get_by_index(&init_net, dev_get_iflink(net_dev));
+        /* if we got a NULL parent_dev there is something broken.. */
+        if (WARN(!parent_dev, "Cannot find parent device"))
+                return false;
 
-	/* check if this is a batman-adv mesh interface */
-	if (batadv_softif_is_valid(net_dev))
-		return true;
+        ret = batadv_is_on_batman_iface(parent_dev);
 
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
+        return ret;
 }
 
 static int batadv_is_valid_iface(const struct net_device *net_dev)




-- 
()  ascii ribbon campaign - against html e-mail
/\  against proprietary attachments

