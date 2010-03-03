Return-Path: <linus.luessing@web.de>
Date: Thu, 4 Mar 2010 00:39:46 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100303233946.GA24284@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] vis packet format
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


--xXmbgvnjoT4axfJE
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Marek and I have been chatting a little about the buggy vis raw
output yesterday. And there was either the option to sort the
mixed list on the receiving vis server or on the sender already.
For the second option there was also the idea of changing the vis
packet format accordingly to also save some more overhead.
Currently, we're sending a mixed list of (src,dest,quality) with
the struct vis_info_entry. Instead, the idea for a new format was
the following:

vis_packet.entries = number of source interfaces of this originator
followed by tuples
{src,num_neighbours,num_neighbours x {dest,quality}}
for each source interface of a node.

Additionally, the first entry shall be the one of the primary
interface already.

I've made a little prototype patch, see the attachment for this
(it applies on top of Simon's last vis_refcount additions patch).
I haven't done the more difficult part yet, the sorting and
structuring that has to be done in the generate_vis_packet()
instead now.

If you think this kind of format is ok, then I'd like to have some
more opinions of how to deal with the structuring in the
generate_vis_packet(). My idea so far is, to create num_if lists
and malloc and copy the information for every neighbour of an
originator during the locked orig_hash iteration and freeing as
well as packing those list after realeasing the lock. Or, if the
mallocs might take too much time for being used so often during
the lock, to allocate num_ifs buffers with the maximum
vis_packet size (currently 1000B) for each interface batman is
using before entering the spinlock. And I guess, that anyway
num_ifs would have to be made an atomic_t, right?

Cheers, Linus

PS: Could someone explain, why the recv_list_add() is being done
with a sender_orig instead of vis_orig? Because if using vis_orig,
then we could get rid of the sender_orig as well because of having
this information in the ethernet header already.

--cWoXeonUoKmBZSoM
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="vis-new-format-on-refcount.patch"
Content-Transfer-Encoding: quoted-printable

diff -u batman-adv-git2/packet.h batman-adv-git/packet.h
--- batman-adv-git2/packet.h	2010-03-03 23:54:37.000000000 +0100
+++ batman-adv-git/packet.h	2010-03-03 09:09:03.000000000 +0100
@@ -92,5 +92,4 @@
 	uint8_t  vis_orig[6];	 /* originator that informs about its
 				  * neighbors */
 	uint8_t  target_orig[6]; /* who should receive this packet */
-	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
 } __attribute__((packed));
diff -u batman-adv-git2/proc.c batman-adv-git/proc.c
--- batman-adv-git2/proc.c	2010-03-03 23:54:37.000000000 +0100
+++ batman-adv-git/proc.c	2010-03-03 11:18:21.000000000 +0100
@@ -368,10 +368,6 @@
 {
 	HASHIT(hashit);
 	struct vis_info *info;
-	struct vis_info_entry *entries;
-	HLIST_HEAD(vis_if_list);
-	int i;
-	char tmp_addr_str[ETH_STR_LEN];
 	unsigned long flags;
 	int vis_server =3D atomic_read(&vis_mode);
=20
@@ -386,19 +382,7 @@
 	spin_lock_irqsave(&vis_hash_lock, flags);
 	while (hash_iterate(vis_hash, &hashit)) {
 		info =3D hashit.bucket->data;
-		entries =3D (struct vis_info_entry *)
-			((char *)info + sizeof(struct vis_info));
-		addr_to_string(tmp_addr_str, info->packet.vis_orig);
-		seq_printf(seq, "%s,", tmp_addr_str);
-
-		for (i =3D 0; i < info->packet.entries; i++) {
-			proc_vis_read_entry(seq, &entries[i], &vis_if_list,
-					    info->packet.vis_orig);
-		}
-
-		/* add primary/secondary records */
-		proc_vis_read_prim_sec(seq, &vis_if_list);
-		seq_printf(seq, "\n");
+		proc_vis_read_entry(seq, info);
 	}
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
=20
diff -u batman-adv-git2/routing.c batman-adv-git/routing.c
--- batman-adv-git2/routing.c	2010-03-03 23:54:37.000000000 +0100
+++ batman-adv-git/routing.c	2010-03-03 09:09:00.000000000 +0100
@@ -954,7 +954,7 @@
 	if (is_my_mac(vis_packet->vis_orig))
 		return NET_RX_DROP;
=20
-	if (is_my_mac(vis_packet->sender_orig))
+	if (is_my_mac(ethhdr->h_source))
 		return NET_RX_DROP;
=20
 	switch (vis_packet->vis_type) {
diff -u batman-adv-git2/vis.c batman-adv-git/vis.c
--- batman-adv-git2/vis.c	2010-03-03 23:55:06.000000000 +0100
+++ batman-adv-git/vis.c	2010-03-03 11:38:59.000000000 +0100
@@ -85,65 +85,65 @@
 	return hash % size;
 }
=20
-/* insert interface to the list of interfaces of one originator, if it
- * does not already exist in the list */
-static void proc_vis_insert_interface(const uint8_t *interface,
-				      struct hlist_head *if_list,
-				      bool primary)
-{
-	struct if_list_entry *entry;
-	struct hlist_node *pos;
-
-	hlist_for_each_entry(entry, pos, if_list, list) {
-		if (compare_orig(entry->addr, (void *)interface))
-			return;
-	}
+void proc_vis_read_prim_sec(struct seq_file *seq, struct vis_info *info)
+{
+	int i;
+	char tmp_addr_str[ETH_STR_LEN];
=20
-	/* its a new address, add it to the list */
-	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return;
-	memcpy(entry->addr, interface, ETH_ALEN);
-	entry->primary =3D primary;
-	hlist_add_head(&entry->list, if_list);
+	struct vis_if_entry *if_entry =3D (struct vis_if_entry *)
+		((char *)info + sizeof(struct vis_info));=09
+
+	seq_printf(seq, "PRIMARY, ");
+	for (i =3D 1; i < info->packet.entries; i++) {
+		addr_to_string(tmp_addr_str, if_entry->src);
+		seq_printf(seq, "SEC %s, ", tmp_addr_str);
+
+		if_entry =3D if_entry + sizeof(struct vis_if_entry) +
+			if_entry->num_neigh * sizeof(struct vis_neigh_entry);
+	}
 }
=20
-void proc_vis_read_prim_sec(struct seq_file *seq,
-			    struct hlist_head *if_list)
+/* read neighbor entries belonging to a source interface */
+void proc_vis_read_neigh(struct seq_file *seq, struct vis_if_entry *if_ent=
ry)
 {
-	struct if_list_entry *entry;
-	struct hlist_node *pos, *n;
-	char tmp_addr_str[ETH_STR_LEN];
+	int i;
+	char dest_addr_str[ETH_STR_LEN];
+	struct vis_neigh_entry *neigh_entry =3D (struct vis_neigh_entry*)
+				((char*) if_entry + sizeof(struct vis_if_entry));
=20
-	hlist_for_each_entry_safe(entry, pos, n, if_list, list) {
-		if (entry->primary) {
-			seq_printf(seq, "PRIMARY, ");
-		} else {
-			addr_to_string(tmp_addr_str, entry->addr);
-			seq_printf(seq, "SEC %s, ", tmp_addr_str);
-		}
+	for (i =3D 0; i < if_entry->num_neigh; i++) {
+		addr_to_string(dest_addr_str, neigh_entry->dest);
+		if (neigh_entry->quality =3D=3D 0)
+			seq_printf(seq, "HNA %s, ", dest_addr_str);
+		else
+			seq_printf(seq, "TQ %s %d, ", dest_addr_str,
+					neigh_entry->quality);
=20
-		hlist_del(&entry->list);
-		kfree(entry);
+		neigh_entry =3D neigh_entry + sizeof(struct vis_neigh_entry);
 	}
 }
=20
-/* read an entry  */
-void proc_vis_read_entry(struct seq_file *seq,
-				struct vis_info_entry *entry,
-				struct hlist_head *if_list,
-				uint8_t *vis_orig)
-{
-	char to[40];
-
-	addr_to_string(to, entry->dest);
-	if (entry->quality =3D=3D 0) {
-		proc_vis_insert_interface(vis_orig, if_list, true);
-		seq_printf(seq, "HNA %s, ", to);
-	} else {
-		proc_vis_insert_interface(entry->src, if_list,
-					  compare_orig(entry->src, vis_orig));
-		seq_printf(seq, "TQ %s %d, ", to, entry->quality);
+/* read source interface entries belonging to an originator */
+void proc_vis_read_entry(struct seq_file *seq, struct vis_info *info)
+{
+	int i;
+	char src_addr_str[ETH_STR_LEN];
+
+	struct vis_if_entry *if_entry =3D (struct vis_if_entry *)
+		((char *)info + sizeof(struct vis_info));
+
+	for (i =3D 0; i < info->packet.entries; i++) {
+		addr_to_string(src_addr_str, if_entry->src);
+		seq_printf(seq, "%s,", src_addr_str);
+		proc_vis_read_neigh(seq, if_entry);
+
+		/* add primary/secondary records, if src-if =3D primary */
+		if (i =3D=3D 0)
+			proc_vis_read_prim_sec(seq, info);
+
+		seq_printf(seq, "\n");
+		if_entry =3D if_entry + sizeof(struct vis_if_entry) +
+			if_entry->num_neigh * sizeof(struct vis_neigh_entry);
 	}
 }
=20
@@ -223,7 +223,7 @@
 		if (vis_packet->seqno - old_info->packet.seqno <=3D 0) {
 			if (old_info->packet.seqno =3D=3D vis_packet->seqno) {
 				recv_list_add(&old_info->recv_list,
-					      vis_packet->sender_orig);
+					      vis_packet->vis_orig);
 				return old_info;
 			} else {
 				/* newer packet is already in hash. */
@@ -259,7 +259,7 @@
 		info->packet.entries =3D vis_info_len /
 			sizeof(struct vis_info_entry);
=20
-	recv_list_add(&info->recv_list, info->packet.sender_orig);
+	recv_list_add(&info->recv_list, info->packet.vis_orig);
=20
 	/* try to add it */
 	if (hash_add(vis_hash, info) < 0) {
@@ -542,7 +542,6 @@
 		return;
 	}
=20
-	memcpy(info->packet.sender_orig, mainIfAddr, ETH_ALEN);
 	info->packet.ttl--;
=20
 	packet_length =3D sizeof(struct vis_packet) +
@@ -622,7 +621,6 @@
 	INIT_LIST_HEAD(&send_list);
=20
 	memcpy(my_vis_info->packet.vis_orig, mainIfAddr, ETH_ALEN);
-	memcpy(my_vis_info->packet.sender_orig, mainIfAddr, ETH_ALEN);
=20
 	if (hash_add(vis_hash, my_vis_info) < 0) {
 		printk(KERN_ERR
diff -u batman-adv-git2/vis.h batman-adv-git/vis.h
--- batman-adv-git2/vis.h	2010-03-03 23:55:06.000000000 +0100
+++ batman-adv-git/vis.h	2010-03-03 23:58:01.000000000 +0100
@@ -35,9 +35,13 @@
 	/* vis_info may follow here*/
 } __attribute__((packed));
=20
-struct vis_info_entry {
+struct vis_if_entry {
 	uint8_t  src[ETH_ALEN];
-	uint8_t  dest[ETH_ALEN];
+	uint8_t  num_neigh;
+} __attribute__((packed));
+
+struct vis_neigh_entry {
+	uint8_t  dest[ETH_ALEN]; /* neighbor's interface mac */
 	uint8_t  quality;	/* quality =3D 0 means HNA */
 } __attribute__((packed));
=20
@@ -49,12 +53,10 @@
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
=20
-void proc_vis_read_entry(struct seq_file *seq,
-				struct vis_info_entry *entry,
-				struct hlist_head *if_list,
-				uint8_t *vis_orig);
-void proc_vis_read_prim_sec(struct seq_file *seq,
-			    struct hlist_head *if_list);
+void proc_vis_read_prim_sec(struct seq_file *seq, struct vis_info *info);
+void proc_vis_read_neigh(struct seq_file *seq, struct vis_if_entry *if_ent=
ry);
+void proc_vis_read_entry(struct seq_file *seq, struct vis_info *info);
+
 void receive_server_sync_packet(struct vis_packet *vis_packet,
 				int vis_info_len);
 void receive_client_update_packet(struct vis_packet *vis_packet,

--cWoXeonUoKmBZSoM--

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLjvNCAAoJEBKw7u43QNpfCOQQAJwG2CkGew2j2IsTMRmbBeXa
zFfFT2g+3MGGSagz+dYS7GPTz9/g9Pjsz+XjukbHXbpjm4jx+otuBS45sKK72QKO
41iSHA0rw0sJPArJpdB5AkIEe8ZX7hFw8oG7YXKKrrZgEGopysQC+3fPqbi1gCyX
4tMOxpZKgmYVDzOovLj/vbww/5fq1EEPEac7BQwbCpdd8++IL7CPm9pwk9xgThi2
JRByqpxWFveTlxnrfGSZo6NLdcLhjdphCAfr0dxj7I35IWUYt2ZNOxCWB7guepeH
zQCL0LeCHD7PVNTUVaE9ei0Lv96gmYs6EMlNZQ5AgfvFhXkrMZbSxEdLCrK+QvUl
S+Vn4EeJcWJtzkIBu6MFT2kPQr8lQxsbEbTp9HoQluQysEcs85X0voZnUHkKDnsT
jh9mQtbsce3EdBgYKBw5Lh2wvZPnp9Up93fun7npBWR0qX0zhIH1FQ5yGezR0/4t
6WSYPoybksfPNx89+8NRUKO5vy2sHLK04RBTj26U0cavckFi776XFIS00VzxYAyO
/YqqCmplY134iuGmKe7kOpyEveWWPJLDZwrjb61uxXBfx4PUb3leE6h30zp7sich
RCfKZ3dOgpSuF/23uImKqm2eZLx0uXdSbWSvQxoo0MIaYvJEx48Lk4c1AVOAAbCB
J0iEWaavFzcPchIFMngf
=7E5/
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
