Return-Path: <andrew@lunn.ch>
Date: Thu, 31 Dec 2009 18:07:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091231170753.GA27707@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Coccinelle tests?
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Hi Folks

I asked Julai Lawall to run her Coccinelle
(http://coccinelle.lip6.fr/) test suite on batman-adv. Here are her
results. Some of these issues are already fixed in subversion, others
are real bugs, and some are nice to fix.

    Andrew

----- Forwarded message from Julia Lawall <julia@diku.dk> -----

Date: Thu, 31 Dec 2009 17:40:21 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: Standard coccinelle tests?
X-Spam-Status: No, score=-2.6 required=4.0 tests=BAYES_00 autolearn=ham
	version=3.2.5

I ran all of my tests on your code, and came up with the following 
results.  Search for *** to see my comments about what I think should be 
done.  It is only the first one that seems like a serious bug.  Actually, 
I worked on that problem quite recently, but it must have been just before 
your code showed up, or I missed it for some other reason, because I don't 
have a record of having submitted a patch for that issue for your code.

julia

dev_addr.cocci

***dev->dev_addr is a pointer.  The size of an address is probably 6.  dev
has an addr_len field that might be initialized.

diff -u -p /var/linuxes/linux-next/drivers/staging/batman-adv/soft-interface.c /tmp/nothing
--- /var/linuxes/linux-next/drivers/staging/batman-adv/soft-interface.c	2009-12-19 09:38:58.000000000 +0100
@@ -121,7 +121,7 @@ void interface_setup(struct net_device *
 
 	/* generate random address */
 	random_ether_addr(dev_addr);
-	memcpy(dev->dev_addr, dev_addr, sizeof(dev->dev_addr));
 
 	SET_ETHTOOL_OPS(dev, &bat_ethtool_ops);
 
kmalmem.cocci

*** Use kzalloc instead of kmalloc + memset.  Also consider testing the result
of the kmaloc for NULL.

diff -u -p a/originator.c b/originator.c
--- a/originator.c 2009-12-19 09:38:58.000000000 +0100
+++ b/originator.c 2009-12-31 14:56:59.000000000 +0100
@@ -76,8 +76,7 @@ create_neighbor(struct orig_node *orig_n
 
 	bat_dbg(DBG_BATMAN, "Creating new last-hop neighbour of originator\n");
 
-	neigh_node = kmalloc(sizeof(struct neigh_node), GFP_ATOMIC);
-	memset(neigh_node, 0, sizeof(struct neigh_node));
+	neigh_node = kzalloc(sizeof(struct neigh_node), GFP_ATOMIC);
 	INIT_LIST_HEAD(&neigh_node->list);
 
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
@@ -126,8 +125,7 @@ struct orig_node *get_orig_node(uint8_t 
 	addr_to_string(orig_str, addr);
 	bat_dbg(DBG_BATMAN, "Creating new originator: %s \n", orig_str);
 
-	orig_node = kmalloc(sizeof(struct orig_node), GFP_ATOMIC);
-	memset(orig_node, 0, sizeof(struct orig_node));
+	orig_node = kzalloc(sizeof(struct orig_node), GFP_ATOMIC);
 	INIT_LIST_HEAD(&orig_node->neigh_list);
 
 	memcpy(orig_node->orig, addr, ETH_ALEN);
@@ -137,12 +135,10 @@ struct orig_node *get_orig_node(uint8_t 
 
 	size = num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
 
-	orig_node->bcast_own = kmalloc(size, GFP_ATOMIC);
-	memset(orig_node->bcast_own, 0, size);
+	orig_node->bcast_own = kzalloc(size, GFP_ATOMIC);
 
 	size = num_ifs * sizeof(uint8_t);
-	orig_node->bcast_own_sum = kmalloc(size, GFP_ATOMIC);
-	memset(orig_node->bcast_own_sum, 0, size);
+	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
 
 	hash_add(orig_hash, orig_node);
 

kmbfree.cocci

*** As far as I can tell, in the following, the if after the out label is not
needed.

diff -u -p /var/linuxes/linux-next/drivers/staging/batman-adv/hard-interface.c /tmp/nothing
--- /var/linuxes/linux-next/drivers/staging/batman-adv/hard-interface.c	2009-12-19 09:38:58.000000000 +0100
@@ -335,7 +335,7 @@ int hardif_add_interface(char *dev, int 
 	else
 		batman_if->packet_len = BAT_PACKET_LEN;
 
-	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_KERNEL);
 
 	if (!batman_if->packet_buff) {
 		printk(KERN_ERR "batman-adv:Can't add interface packet (%s): out of memory\n", dev);
@@ -401,7 +401,7 @@ int hardif_add_interface(char *dev, int 
 out:
 	if (batman_if->packet_buff)
 		kfree(batman_if->packet_buff);
-	kfree(batman_if);
 	kfree(dev);
 	return -1;
 }

kmtest.cocci

*** the result of kmalloc should be tested for NULL

diff -u -p /var/linuxes/linux-next/drivers/staging/batman-adv/hash.c /tmp/nothing
--- /var/linuxes/linux-next/drivers/staging/batman-adv/hash.c	2009-11-23 22:35:21.000000000 +0100
@@ -76,7 +76,7 @@ struct hash_it_t *hash_iterate(struct ha
 
 	if (iter_in == NULL) {
 		iter = kmalloc(sizeof(struct hash_it_t), GFP_ATOMIC);
-		iter->index = -1;
 		iter->bucket = NULL;
 		iter->prev_bucket = NULL;
 	} else {
diff -u -p /var/linuxes/linux-next/drivers/staging/batman-adv/translation-table.c /tmp/nothing
--- /var/linuxes/linux-next/drivers/staging/batman-adv/translation-table.c	2009-12-19 09:38:58.000000000 +0100
@@ -322,7 +322,6 @@ void hna_global_add_orig(struct orig_nod
 	if (orig_node->hna_buff_len > 0) {
 		orig_node->hna_buff = kmalloc(orig_node->hna_buff_len,
 					      GFP_ATOMIC);
-		memcpy(orig_node->hna_buff, hna_buff, orig_node->hna_buff_len);
 	} else {
 		orig_node->hna_buff = NULL;
 	}

returns.cocci

*** Perhaps there is no point to put a return by itself at the end of a
function.

diff -u -p a/routing.c b/routing.c
--- a/routing.c 2009-12-19 09:38:58.000000000 +0100
+++ b/routing.c 2009-12-31 14:59:41.000000000 +0100
@@ -307,7 +307,6 @@ static void update_orig(struct orig_node
 
 update_hna:
 	update_routes(orig_node, orig_node->router, hna_buff, tmp_hna_buff_len);
-	return;
 }
 
 static char count_real_packets(struct ethhdr *ethhdr,
@@ -627,7 +626,6 @@ static void recv_my_icmp_packet(struct e
 	}
 
 	spin_unlock(&orig_hash_lock);
-	return;
 }
 
 static void recv_icmp_ttl_exceeded(struct icmp_packet *icmp_packet,

txok.cocci

*** I saw in some patch that functions store in the field .ndo_start_xmit
ought to return NETDEV_TX_OK rather than 0.  I haven't submitted any patches
of my own for this situation, so I don't know for sure what the rule is.

diff -u -p a/soft-interface.c b/soft-interface.c
--- a/soft-interface.c 2009-12-19 09:38:58.000000000 +0100
+++ b/soft-interface.c 2009-12-31 15:00:31.000000000 +0100
@@ -263,7 +263,7 @@ dropped:
 	priv->stats.tx_dropped++;
 end:
 	kfree_skb(skb);
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 void interface_rx(struct net_device *dev, void *packet, int packet_len)

--------------------------------


----- End forwarded message -----
