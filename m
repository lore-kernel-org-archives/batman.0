Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 1 Mar 2010 17:57:06 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100301165706.GA11578@pandem0nium>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch>
	<20100211094659.GH2900@lunn.ch> <20100211100156.GI2900@lunn.ch>
	<20100228163428.GA15370@pandem0nium>
	<20100301055955.GC15286@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20100301055955.GC15286@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--z6Eq5LdranGa6ru8
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Andrew,

all list-adds and list-removes do a kref_get or kref_put respectively,
but that probably was not very clear. As soon as a refence is created=20
(by linking into the hash or a list), we should also kref_get() it.

Please find attached a new version of this patch with separate=20
send_list_add/remove functions which include the put/get functions.=20
I've also added the kref_put/get call to the send_list loop again.
It should look more balanced now. Tested in my 9 qemu setup again,
no memory leaks or crashes but i only did a very quick test=20
(15 minutes)

best regards,
	Simon

On Mon, Mar 01, 2010 at 06:59:55AM +0100, Andrew Lunn wrote:
> Hi Simon
>=20
> > @@ -503,15 +550,23 @@
> >  	unsigned long flags;
> > =20
> >  	spin_lock_irqsave(&vis_hash_lock, flags);
> > +
> >  	purge_vis_packets();
> > =20
> > -	if (generate_vis_packet() =3D=3D 0)
> > +	if (generate_vis_packet() =3D=3D 0) {
> >  		/* schedule if generation was successful */
> > +		kref_get(&my_vis_info->refcount);
> >  		list_add_tail(&my_vis_info->send_list, &send_list);
> > +	}
> > =20
> >  	list_for_each_entry_safe(info, temp, &send_list, send_list) {
> > +		spin_unlock_irqrestore(&vis_hash_lock, flags);
> > +
> > +		send_vis_packet(info);
> > +
> > +		spin_lock_irqsave(&vis_hash_lock, flags);
> >  		list_del_init(&info->send_list);
> > -		send_vis_packet(info);
> > +		kref_put(&info->refcount, free_info);
> >  	}
> >  	spin_unlock_irqrestore(&vis_hash_lock, flags);
> >  	start_vis_timer();
>=20
> Although you say this works, i just looks wrong. It looks
> unbalanced. Where is the kref_put for my_vis_info->refcount?  There is
> a kref_put inside what looks like a loop, but no kref_get inside the
> loop.=20
>=20
> Can you explain this is more detail? Can we make it look correctly
> balanced?
>=20
> 	Thanks
> 		Andrew
>=20

--9amGYk9869ThD9tj
Content-Type: text/x-diff; charset=utf8
Content-Disposition: attachment; filename="vis_refcount2.patch"
Content-Transfer-Encoding: quoted-printable

taging: batman-adv: Don't have interrupts disabled while sending.

send_vis_packets() would disable interrupts before calling
dev_queue_xmit() which resulting in a backtrace in local_bh_enable().
Fix this by using kref on the vis_info object so that we can call
send_vis_packets() without holding vis_hash_lock. vis_hash_lock also
used to protect recv_list, so we now need a new lock to protect that
instead of vis_hash_lock.

Also a few checkpatch cleanups.

Reported-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Index: a/batman-adv-kernelland/vis.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/vis.c	(revision 1578)
+++ a/batman-adv-kernelland/vis.c	(working copy)
@@ -30,22 +30,26 @@
=20
 struct hashtable_t *vis_hash;
 DEFINE_SPINLOCK(vis_hash_lock);
+static DEFINE_SPINLOCK(recv_list_lock);
 static struct vis_info *my_vis_info;
 static struct list_head send_list;	/* always locked with vis_hash_lock */
=20
 static void start_vis_timer(void);
=20
 /* free the info */
-static void free_info(void *data)
+static void free_info(struct kref *ref)
 {
-	struct vis_info *info =3D data;
+	struct vis_info *info =3D container_of(ref, struct vis_info, refcount);
 	struct recvlist_node *entry, *tmp;
+	unsigned long flags;
=20
 	list_del_init(&info->send_list);
+	spin_lock_irqsave(&recv_list_lock, flags);
 	list_for_each_entry_safe(entry, tmp, &info->recv_list, list) {
 		list_del(&entry->list);
 		kfree(entry);
 	}
+	spin_unlock_irqrestore(&recv_list_lock, flags);
 	kfree(info);
 }
=20
@@ -143,36 +147,65 @@
 	}
 }
=20
+/* add the info packet to the send list, if it was not
+ * already linked in. */
+static void send_list_add(struct vis_info *info)
+{
+	if (list_empty(&info->send_list)) {
+		kref_get(&info->refcount);
+		list_add_tail(&info->send_list, &send_list);
+	}
+}
+
+/* delete the info packet from the send list, if it was
+ * linked in. */
+static void send_list_del(struct vis_info *info)
+{
+	if (!list_empty(&info->send_list)) {
+		list_del_init(&info->send_list);
+		kref_put(&info->refcount, free_info);
+	}
+}
+
 /* tries to add one entry to the receive list. */
 static void recv_list_add(struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
+	unsigned long flags;
+
 	entry =3D kmalloc(sizeof(struct recvlist_node), GFP_ATOMIC);
 	if (!entry)
 		return;
=20
 	memcpy(entry->mac, mac, ETH_ALEN);
+	spin_lock_irqsave(&recv_list_lock, flags);
 	list_add_tail(&entry->list, recv_list);
+	spin_unlock_irqrestore(&recv_list_lock, flags);
 }
=20
 /* returns 1 if this mac is in the recv_list */
 static int recv_list_is_in(struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
+	unsigned long flags;
=20
+	spin_lock_irqsave(&recv_list_lock, flags);
 	list_for_each_entry(entry, recv_list, list) {
-		if (memcmp(entry->mac, mac, ETH_ALEN) =3D=3D 0)
+		if (memcmp(entry->mac, mac, ETH_ALEN) =3D=3D 0) {
+			spin_unlock_irqrestore(&recv_list_lock, flags);
 			return 1;
+		}
 	}
-
+	spin_unlock_irqrestore(&recv_list_lock, flags);
 	return 0;
 }
=20
 /* try to add the packet to the vis_hash. return NULL if invalid (e.g. too=
 old,
- * broken.. ).  vis hash must be locked outside.  is_new is set when the p=
acket
+ * broken.. ).	vis hash must be locked outside.  is_new is set when the pa=
cket
  * is newer than old entries in the hash. */
 static struct vis_info *add_packet(struct vis_packet *vis_packet,
-				   int vis_info_len, int *is_new)
+				   int vis_info_len, int *is_new,
+				   int make_broadcast)
 {
 	struct vis_info *info, *old_info;
 	struct vis_info search_elem;
@@ -199,13 +232,15 @@
 		}
 		/* remove old entry */
 		hash_remove(vis_hash, old_info);
-		free_info(old_info);
+		send_list_del(old_info);
+		kref_put(&old_info->refcount, free_info);
 	}
=20
 	info =3D kmalloc(sizeof(struct vis_info) + vis_info_len, GFP_ATOMIC);
 	if (info =3D=3D NULL)
 		return NULL;
=20
+	kref_init(&info->refcount);
 	INIT_LIST_HEAD(&info->send_list);
 	INIT_LIST_HEAD(&info->recv_list);
 	info->first_seen =3D jiffies;
@@ -215,16 +250,21 @@
 	/* initialize and add new packet. */
 	*is_new =3D 1;
=20
+	/* Make it a broadcast packet, if required */
+	if (make_broadcast)
+		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+
 	/* repair if entries is longer than packet. */
 	if (info->packet.entries * sizeof(struct vis_info_entry) > vis_info_len)
-		info->packet.entries =3D vis_info_len / sizeof(struct vis_info_entry);
+		info->packet.entries =3D vis_info_len /
+			sizeof(struct vis_info_entry);
=20
 	recv_list_add(&info->recv_list, info->packet.sender_orig);
=20
 	/* try to add it */
 	if (hash_add(vis_hash, info) < 0) {
 		/* did not work (for some reason) */
-		free_info(info);
+		kref_put(&old_info->refcount, free_info);
 		info =3D NULL;
 	}
=20
@@ -235,22 +275,21 @@
 void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_inf=
o_len)
 {
 	struct vis_info *info;
-	int is_new;
+	int is_new, make_broadcast;
 	unsigned long flags;
 	int vis_server =3D atomic_read(&vis_mode);
=20
+	make_broadcast =3D (vis_server =3D=3D VIS_TYPE_SERVER_SYNC);
+
 	spin_lock_irqsave(&vis_hash_lock, flags);
-	info =3D add_packet(vis_packet, vis_info_len, &is_new);
+	info =3D add_packet(vis_packet, vis_info_len, &is_new, make_broadcast);
 	if (info =3D=3D NULL)
 		goto end;
=20
 	/* only if we are server ourselves and packet is newer than the one in
 	 * hash.*/
-	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC && is_new) {
-		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-		if (list_empty(&info->send_list))
-			list_add_tail(&info->send_list, &send_list);
-	}
+	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC && is_new)
+		send_list_add(info);
 end:
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 }
@@ -263,31 +302,32 @@
 	int is_new;
 	unsigned long flags;
 	int vis_server =3D atomic_read(&vis_mode);
+	int are_target =3D 0;
=20
 	/* clients shall not broadcast. */
 	if (is_bcast(vis_packet->target_orig))
 		return;
=20
+	/* Are we the target for this VIS packet? */
+	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC	&&
+	    is_my_mac(vis_packet->target_orig))
+		are_target =3D 1;
+
 	spin_lock_irqsave(&vis_hash_lock, flags);
-	info =3D add_packet(vis_packet, vis_info_len, &is_new);
+	info =3D add_packet(vis_packet, vis_info_len, &is_new, are_target);
 	if (info =3D=3D NULL)
 		goto end;
 	/* note that outdated packets will be dropped at this point. */
=20
=20
 	/* send only if we're the target server or ... */
-	if (vis_server =3D=3D VIS_TYPE_SERVER_SYNC  &&
-	    is_my_mac(info->packet.target_orig) &&
-	    is_new) {
+	if (are_target && is_new) {
 		info->packet.vis_type =3D VIS_TYPE_SERVER_SYNC;	/* upgrade! */
-		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-		if (list_empty(&info->send_list))
-			list_add_tail(&info->send_list, &send_list);
+		send_list_add(info);
=20
 		/* ... we're not the recipient (and thus need to forward). */
 	} else if (!is_my_mac(info->packet.target_orig)) {
-		if (list_empty(&info->send_list))
-			list_add_tail(&info->send_list, &send_list);
+		send_list_add(info);
 	}
 end:
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
@@ -362,14 +402,17 @@
 	while (hash_iterate(orig_hash, &hashit_global)) {
 		orig_node =3D hashit_global.bucket->data;
 		if (orig_node->router !=3D NULL
-			&& compare_orig(orig_node->router->addr, orig_node->orig)
+			&& compare_orig(orig_node->router->addr,
+					orig_node->orig)
 			&& orig_node->batman_if
 			&& (orig_node->batman_if->if_active =3D=3D IF_ACTIVE)
 		    && orig_node->router->tq_avg > 0) {
=20
 			/* fill one entry into buffer. */
 			entry =3D &entry_array[info->packet.entries];
-			memcpy(entry->src, orig_node->batman_if->net_dev->dev_addr, ETH_ALEN);
+			memcpy(entry->src,
+			       orig_node->batman_if->net_dev->dev_addr,
+			       ETH_ALEN);
 			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
 			entry->quality =3D orig_node->router->tq_avg;
 			info->packet.entries++;
@@ -401,6 +444,8 @@
 	return 0;
 }
=20
+/* free old vis packets. Must be called with this vis_hash_lock
+ * held */
 static void purge_vis_packets(void)
 {
 	HASHIT(hashit);
@@ -413,7 +458,8 @@
 		if (time_after(jiffies,
 			       info->first_seen + (VIS_TIMEOUT*HZ)/1000)) {
 			hash_remove_bucket(vis_hash, &hashit);
-			free_info(info);
+			send_list_del(info);
+			kref_put(&info->refcount, free_info);
 		}
 	}
 }
@@ -423,6 +469,8 @@
 	HASHIT(hashit);
 	struct orig_node *orig_node;
 	unsigned long flags;
+	struct batman_if *batman_if;
+	uint8_t dstaddr[ETH_ALEN];
=20
 	spin_lock_irqsave(&orig_hash_lock, flags);
=20
@@ -431,46 +479,57 @@
 		orig_node =3D hashit.bucket->data;
=20
 		/* if it's a vis server and reachable, send it. */
-		if (orig_node &&
-		    (orig_node->flags & VIS_SERVER) &&
-		    orig_node->batman_if &&
-		    orig_node->router) {
+		if ((!orig_node) || (!orig_node->batman_if) ||
+		    (!orig_node->router))
+			continue;
+		if (!(orig_node->flags & VIS_SERVER))
+			continue;
+		/* don't send it if we already received the packet from
+		 * this node. */
+		if (recv_list_is_in(&info->recv_list, orig_node->orig))
+			continue;
=20
-			/* don't send it if we already received the packet from
-			 * this node. */
-			if (recv_list_is_in(&info->recv_list, orig_node->orig))
-				continue;
+		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
+		batman_if =3D orig_node->batman_if;
+		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+		spin_unlock_irqrestore(&orig_hash_lock, flags);
=20
-			memcpy(info->packet.target_orig,
-			       orig_node->orig, ETH_ALEN);
+		send_raw_packet((unsigned char *)&info->packet,
+				packet_length, batman_if, dstaddr);
=20
-			send_raw_packet((unsigned char *) &info->packet,
-					packet_length,
-					orig_node->batman_if,
-					orig_node->router->addr);
-		}
+		spin_lock_irqsave(&orig_hash_lock, flags);
+
 	}
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
=20
 static void unicast_vis_packet(struct vis_info *info, int packet_length)
 {
 	struct orig_node *orig_node;
 	unsigned long flags;
+	struct batman_if *batman_if;
+	uint8_t dstaddr[ETH_ALEN];
=20
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	orig_node =3D ((struct orig_node *)
 		     hash_find(orig_hash, info->packet.target_orig));
=20
-	if ((orig_node !=3D NULL) &&
-	    (orig_node->batman_if !=3D NULL) &&
-	    (orig_node->router !=3D NULL)) {
-		send_raw_packet((unsigned char *) &info->packet, packet_length,
-				orig_node->batman_if,
-				orig_node->router->addr);
-	}
+	if ((!orig_node) || (!orig_node->batman_if) || (!orig_node->router))
+		goto out;
+
+	/* don't lock while sending the packets ... we therefore
+	 * copy the required data before sending */
+	batman_if =3D orig_node->batman_if;
+	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+	send_raw_packet((unsigned char *)&info->packet,
+			packet_length, batman_if, dstaddr);
+	return;
+
+out:
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 }
=20
 /* only send one vis packet. called from send_vis_packets() */
@@ -503,15 +562,24 @@
 	unsigned long flags;
=20
 	spin_lock_irqsave(&vis_hash_lock, flags);
+
 	purge_vis_packets();
=20
-	if (generate_vis_packet() =3D=3D 0)
+	if (generate_vis_packet() =3D=3D 0) {
 		/* schedule if generation was successful */
-		list_add_tail(&my_vis_info->send_list, &send_list);
+		send_list_add(my_vis_info);
+	}
=20
 	list_for_each_entry_safe(info, temp, &send_list, send_list) {
-		list_del_init(&info->send_list);
+
+		kref_get(&info->refcount);
+		spin_unlock_irqrestore(&vis_hash_lock, flags);
+
 		send_vis_packet(info);
+
+		spin_lock_irqsave(&vis_hash_lock, flags);
+		send_list_del(info);
+		kref_put(&info->refcount, free_info);
 	}
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 	start_vis_timer();
@@ -544,6 +612,7 @@
 	my_vis_info->first_seen =3D jiffies - atomic_read(&vis_interval);
 	INIT_LIST_HEAD(&my_vis_info->recv_list);
 	INIT_LIST_HEAD(&my_vis_info->send_list);
+	kref_init(&my_vis_info->refcount);
 	my_vis_info->packet.version =3D COMPAT_VERSION;
 	my_vis_info->packet.packet_type =3D BAT_VIS;
 	my_vis_info->packet.ttl =3D TTL;
@@ -557,9 +626,9 @@
=20
 	if (hash_add(vis_hash, my_vis_info) < 0) {
 		printk(KERN_ERR
-			  "batman-adv:Can't add own vis packet into hash\n");
-		free_info(my_vis_info);	/* not in hash, need to remove it
-					 * manually. */
+		       "batman-adv:Can't add own vis packet into hash\n");
+		/* not in hash, need to remove it manually. */
+		kref_put(&my_vis_info->refcount, free_info);
 		goto err;
 	}
=20
@@ -573,6 +642,15 @@
 	return 0;
 }
=20
+/* Decrease the reference count on a hash item info */
+static void free_info_ref(void *data)
+{
+	struct vis_info *info =3D data;
+
+	send_list_del(info);
+	kref_put(&info->refcount, free_info);
+}
+
 /* shutdown vis-server */
 void vis_quit(void)
 {
@@ -584,7 +662,7 @@
=20
 	spin_lock_irqsave(&vis_hash_lock, flags);
 	/* properly remove, kill timers ... */
-	hash_delete(vis_hash, free_info);
+	hash_delete(vis_hash, free_info_ref);
 	vis_hash =3D NULL;
 	my_vis_info =3D NULL;
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
@@ -594,5 +672,5 @@
 static void start_vis_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
-			   (atomic_read(&vis_interval) * HZ ) / 1000);
+			   (atomic_read(&vis_interval) * HZ) / 1000);
 }
Index: a/batman-adv-kernelland/vis.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/vis.h	(revision 1578)
+++ a/batman-adv-kernelland/vis.h	(working copy)
@@ -29,6 +29,7 @@
 			    /* list of server-neighbors we received a vis-packet
 			     * from.  we should not reply to them. */
 	struct list_head send_list;
+	struct kref refcount;
 	/* this packet might be part of the vis send queue. */
 	struct vis_packet packet;
 	/* vis_info may follow here*/

--9amGYk9869ThD9tj--

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuL8eIACgkQrzg/fFk7axYsuACfepEx9VXvul8DdHO2R5EZA2gR
9mMAoLqXs5b4B85xzNe+vSARlbO/4uFj
=loo3
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
