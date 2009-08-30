Return-Path: <linus.luessing@web.de>
Date: Sun, 30 Aug 2009 03:36:48 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20090830013647.GA26017@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [patch] adding subgraph-feature to vis-output in
	dot-file-format
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


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pfeh... long night again, but here you go. With this patch,
batman-adv now supports the subgraphing-feature of the
dot-file-format. The vis-output can then be parsed with=20
"fdp -Tsvg -Gcharset=3Dutf8 /proc/net/batman-adv/vis > test.svg"
for example.=20

Interfaces belonging to one BATMAN-node can be found
inside a box, the primary interface of a BATMAN-node is
double-circled. The output also got more detailed, in that
connections between nodes are being displayed with the exact
mac address of the used interface instead of replacing one end
with the primary interface's mac (see [0] for the problems I had
posted before).

Cheers, Linus

PS: Please check if I got that kmalloc stuff right.
PPS: I had to introduce a src-field in the vis-packet-struct,
therefore the compatibility version had to be increased as well.

[0] https://lists.open-mesh.net/pipermail/b.a.t.m.a.n/2009-August/002832.ht=
ml

Index: vis.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- vis.c	(revision 1417)
+++ vis.c	(working copy)
@@ -333,6 +333,7 @@
=20
 			/* fill one entry into buffer. */
 			entry =3D &entry_array[info->packet.entries];
+			memcpy(entry->src, orig_node->batman_if->net_dev->dev_addr, ETH_ALEN);
 			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
 			entry->quality =3D orig_node->router->tq_avg;
 			info->packet.entries++;
@@ -351,6 +352,7 @@
 	while (NULL !=3D (hashit =3D hash_iterate(hna_local_hash, hashit))) {
 		hna_local_entry =3D hashit->bucket->data;
 		entry =3D &entry_array[info->packet.entries];
+		memset(entry->src, 0, ETH_ALEN);
 		memcpy(entry->dest, hna_local_entry->addr, ETH_ALEN);
 		entry->quality =3D 0; /* 0 means HNA */
 		info->packet.entries++;
Index: vis.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- vis.h	(revision 1417)
+++ vis.h	(working copy)
@@ -33,6 +33,7 @@
 } __attribute__((packed));
=20
 struct vis_info_entry {
+	uint8_t  src[ETH_ALEN];
 	uint8_t  dest[ETH_ALEN];
 	uint8_t  quality;	/* quality =3D 0 means HNA */
 } __attribute__((packed));
Index: packet.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- packet.h	(revision 1417)
+++ packet.h	(working copy)
@@ -26,7 +26,7 @@
 #define BAT_VIS       0x05
=20
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 7
+#define COMPAT_VERSION 8
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
=20
Index: proc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- proc.c	(revision 1417)
+++ proc.c	(working copy)
@@ -403,17 +403,47 @@
 	return single_open(file, proc_transt_global_read, NULL);
 }
=20
+static void proc_vis_insert_interface(const uint8_t *interface,=20
+				      struct vis_if_list **if_entry,=20
+				      bool primary)
+{
+	// Did we get an empty list? (then insert imediately)
+	if(*if_entry =3D=3D NULL) {
+		*if_entry =3D kmalloc(sizeof(struct vis_if_list), GFP_KERNEL);
+		(*if_entry)->primary =3D primary;
+		(*if_entry)->next =3D NULL;
+		memcpy((*if_entry)->addr, interface, ETH_ALEN);
+	} else {
+		// Do we already have this interface in our list?
+		while(memcmp((*if_entry)->addr, interface, ETH_ALEN)) {
+			// Or did we reach the end (then append the interface)
+			if((*if_entry)->next =3D=3D NULL) {
+				(*if_entry)->next =3D kmalloc(sizeof(struct vis_if_list), GFP_KERNEL);
+				memcpy((*if_entry)->next->addr, interface, ETH_ALEN);
+				(*if_entry)->next->primary =3D primary;
+				(*if_entry)->next->next =3D NULL;
+				break;
+			}
+			*if_entry =3D (*if_entry)->next;
+		}
+	}
+}
+
 static void proc_vis_read_entry(struct seq_file *seq,
 				struct vis_info_entry *entry,
-				char *from,
+				struct vis_if_list **if_entry,
+				uint8_t *vis_orig,
 				uint8_t current_format,
 				uint8_t first_line)
 {
+	char from[40];
 	char to[40];
 	int int_part, frac_part;
=20
 	addr_to_string(to, entry->dest);
 	if (entry->quality =3D=3D 0) {
+		proc_vis_insert_interface(vis_orig, if_entry, true);
+		addr_to_string(from, vis_orig);
 		if (current_format =3D=3D DOT_DRAW) {
 			seq_printf(seq, "\t\"%s\" -> \"%s\" [label=3D\"HNA\"]\n",
 				   from, to);
@@ -425,6 +455,9 @@
 	} else {
 		/* kernel has no printf-support for %f? it'd be better to return
 		 * this in float. */
+		proc_vis_insert_interface(entry->src, if_entry,
+		    (memcmp(entry->src, vis_orig, ETH_ALEN)) ? false : true);
+		addr_to_string(from, entry->src);
 		int_part =3D TQ_MAX_VALUE / entry->quality;
 		frac_part =3D 1000 * TQ_MAX_VALUE / entry->quality - int_part * 1000;
 		if (current_format =3D=3D DOT_DRAW) {
@@ -444,9 +477,11 @@
 	struct hash_it_t *hashit =3D NULL;
 	struct vis_info *info;
 	struct vis_info_entry *entries;
-	char from[40];
+	struct vis_if_list *if_entries =3D NULL;
 	int i;
 	uint8_t current_format, first_line =3D 1;
+	char tmp_addr_str[ETH_STR_LEN];
+	struct vis_if_list *tmp_if_next;
=20
 	current_format =3D vis_format;
=20
@@ -468,14 +503,32 @@
 		info =3D hashit->bucket->data;
 		entries =3D (struct vis_info_entry *)
 			((char *)info + sizeof(struct vis_info));
-		addr_to_string(from, info->packet.vis_orig);
=20
 		for (i =3D 0; i < info->packet.entries; i++) {
-			proc_vis_read_entry(seq, &entries[i], from,
+			proc_vis_read_entry(seq, &entries[i], &if_entries,
+					    info->packet.vis_orig,
 					    current_format, first_line);
 			if (first_line)
 				first_line =3D 0;
 		}
+
+		// Generate subgraphs from the collected items
+		if (current_format =3D=3D DOT_DRAW) {
+			addr_to_string(tmp_addr_str, info->packet.vis_orig);
+			seq_printf(seq, "\tsubgraph \"cluster_%s\" \{\n", tmp_addr_str);
+			while (if_entries !=3D NULL) {
+				addr_to_string(tmp_addr_str, if_entries->addr);
+				if (if_entries->primary)
+					seq_printf(seq, "\t\t\"%s\" [peripheries=3D2]\n", tmp_addr_str);
+				else
+					seq_printf(seq, "\t\t\"%s\"\n", tmp_addr_str);
+				// ... and empty the list while doing this
+				tmp_if_next =3D if_entries->next;
+				kfree(if_entries);
+				if_entries =3D tmp_if_next;
+			}
+			seq_printf(seq, "\t}\n");
+		}
 	}
 	spin_unlock(&vis_hash_lock);
=20
Index: proc.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- proc.h	(revision 1417)
+++ proc.h	(working copy)
@@ -35,3 +35,12 @@
=20
 void cleanup_procfs(void);
 int setup_procfs(void);
+
+// While scanning for vis-entries of a particular vis-originator
+// this list collects its interfaces to create a subgraph/cluster=20
+// out of them later
+struct vis_if_list {
+	uint8_t addr[ETH_ALEN];
+	bool primary;
+	struct vis_if_list *next;
+};

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBAgAGBQJKmdevAAoJEBKw7u43QNpfecAQAKmXsif+gE+wRuKuaotN9HOg
T6TUxQNXzJxIwTa4Gzbr8zwFRlkTDQFfujQt4K9eYML3mzjRs3A/VwTf4N/vkl+C
DB3IJ03D3DZ7Fv/eiNp+T34xDs9xwFq8MwzjRdUIxS560XSs2kM1PoQZb+oU1ZvP
asW4/g3UDTu288ALAgwft+terVcdIW4iCnH7VcihszEqSo/20YdEvYAc/H+ltvxM
BHubjoHYg/g0zlCKZ04oDYhJC/PM5j/lHT/Mp6S2rLdGHr/UMkjMjzzrhhTtCkVu
EZKKdGE3gS5B/caS4t9IxwG2LIv0Cmklm9sV9ndbcnNMHhQ7XSZCLR9DHia6AcB2
jRFzD/fT6RnYdNyNpuK5OHvMMo1J2DstTP4g8fvy2xFjdEHyDLgqZaPNSm9HTItG
XSWOTyH1WA9zmq1WLUlZl/YVqw5uV8xqmSSKoQYXrouPkHSyUxoH2McLtnQSG9Tx
arNq8kerX7VKuJyo1B3Pr1znZQBRcwUXk8sjl0p8Z66upRooa/ZicG79m+Irdy+G
aruhG8wW0cpS7766UErJSmTpm2DUW1e3nHLgTtsR+QNpZD+N4O1EKEnxz31rpPzv
uz1V/3Pn6U0hQg73lFQuyDSdU6CJBC6DdWs9jSiExrmkfyyqV3/NdDvL7X0c4ANn
pm+dJ5thG85fmNG55F94
=d+V8
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
