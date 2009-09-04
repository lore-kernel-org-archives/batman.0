Return-Path: <linus.luessing@web.de>
Date: Fri, 4 Sep 2009 20:58:15 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20090904185815.GA5506@Linus-Debian>
References: <20090830013647.GA26017@Linus-Debian>
	<20090830195553.GA2410@pandem0nium>
	<20090901204702.GA9632@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20090901204702.GA9632@Linus-Debian>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [patch] adding subgraph-feature to vis-output in
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok, could get that problem with the missing entries fixed, the
pointer to the interface-list needed to be set to the top of the
list after going through the list again. So basically I just added lines 95=
, 112, 113.
So works fine for me now :).

Cheers, Linus

Index: vis.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- vis.c	(revision 1418)
+++ vis.c	(working copy)
@@ -87,7 +87,7 @@
 	struct vis_info *d1, *d2;
 	d1 =3D data1;
 	d2 =3D data2;
-	return memcmp(d1->packet.vis_orig, d2->packet.vis_orig, ETH_ALEN) =3D=3D =
0;
+	return compare_orig(d1->packet.vis_orig, d2->packet.vis_orig);
 }
=20
 /* hash function to choose an entry in a hash table of given size */
@@ -326,13 +326,14 @@
=20
 	while (NULL !=3D (hashit =3D hash_iterate(orig_hash, hashit))) {
 		orig_node =3D hashit->bucket->data;
-		if (orig_node->router !=3D NULL &&
-		    memcmp(orig_node->router->addr,
-			   orig_node->orig, ETH_ALEN) =3D=3D 0 &&
-		    orig_node->router->tq_avg > 0) {
+		if (orig_node->router !=3D NULL
+			&& compare_orig(orig_node->router->addr, orig_node->orig)
+			&& orig_node->batman_if
+		    && orig_node->router->tq_avg > 0) {
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
@@ -556,3 +558,4 @@
 	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
 			   (atomic_read(&vis_interval)/1000) * HZ);
 }
+
Index: vis.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- vis.h	(revision 1418)
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
--- packet.h	(revision 1418)
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
--- proc.c	(revision 1418)
+++ proc.c	(working copy)
@@ -403,17 +403,62 @@
 	return single_open(file, proc_transt_global_read, NULL);
 }
=20
+/* insert interface to the list of interfaces of one originator */
+
+static void proc_vis_insert_interface(const uint8_t *interface,=20
+				      struct vis_if_list **if_entry,=20
+				      bool primary)
+{
+	/* Did we get an empty list? (then insert imediately) */
+	if(*if_entry =3D=3D NULL) {
+		*if_entry =3D kmalloc(sizeof(struct vis_if_list), GFP_KERNEL);
+		if (*if_entry =3D=3D NULL)
+			return;
+
+		(*if_entry)->primary =3D primary;
+		(*if_entry)->next =3D NULL;
+		memcpy((*if_entry)->addr, interface, ETH_ALEN);
+	} else {
+		struct vis_if_list *head_if_entry =3D *if_entry;
+		/* Do we already have this interface in our list? */
+		while (!compare_orig((*if_entry)->addr, (void *)interface)) {
+
+			/* Or did we reach the end (then append the interface) */
+			if ((*if_entry)->next =3D=3D NULL) {
+				(*if_entry)->next =3D kmalloc(sizeof(struct vis_if_list), GFP_KERNEL);
+				if ((*if_entry)->next =3D=3D NULL)
+					return;
+
+				memcpy((*if_entry)->next->addr, interface, ETH_ALEN);
+				(*if_entry)->next->primary =3D primary;
+				(*if_entry)->next->next =3D NULL;
+				break;
+			}
+			*if_entry =3D (*if_entry)->next;
+		}
+		/* Rewind the list to its head */
+		*if_entry =3D head_if_entry;
+	}
+}
+/* read an entry  */
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
+#ifndef VIS_SUBCLUSTERS_DISABLED
+		proc_vis_insert_interface(vis_orig, if_entry, true);
+#endif /* VIS_SUBCLUSTERS_DISABLED */
+		addr_to_string(from, vis_orig);
 		if (current_format =3D=3D DOT_DRAW) {
 			seq_printf(seq, "\t\"%s\" -> \"%s\" [label=3D\"HNA\"]\n",
 				   from, to);
@@ -423,10 +468,17 @@
 				   (first_line ? "" : ",\n"), from, to);
 		}
 	} else {
+#ifndef VIS_SUBCLUSTERS_DISABLED
+		proc_vis_insert_interface(entry->src, if_entry, compare_orig(entry->src,=
 vis_orig));
+#endif /* VIS_SUBCLUSTERS_DISABLED */
+		addr_to_string(from, entry->src);
+
 		/* kernel has no printf-support for %f? it'd be better to return
 		 * this in float. */
+
 		int_part =3D TQ_MAX_VALUE / entry->quality;
 		frac_part =3D 1000 * TQ_MAX_VALUE / entry->quality - int_part * 1000;
+
 		if (current_format =3D=3D DOT_DRAW) {
 			seq_printf(seq,
 				   "\t\"%s\" -> \"%s\" [label=3D\"%d.%d\"]\n",
@@ -439,14 +491,19 @@
 	}
 }
=20
+
 static int proc_vis_read(struct seq_file *seq, void *offset)
 {
 	struct hash_it_t *hashit =3D NULL;
 	struct vis_info *info;
 	struct vis_info_entry *entries;
-	char from[40];
+	struct vis_if_list *if_entries =3D NULL;
 	int i;
 	uint8_t current_format, first_line =3D 1;
+#ifndef VIS_SUBCLUSTERS_DISABLED
+	char tmp_addr_str[ETH_STR_LEN];
+	struct vis_if_list *tmp_if_next;
+#endif /* VIS_SUBCLUSTERS_DISABLED */
=20
 	current_format =3D vis_format;
=20
@@ -468,14 +525,37 @@
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
+#ifndef VIS_SUBCLUSTERS_DISABLED
+		/* Generate subgraphs from the collected items */
+		if (current_format =3D=3D DOT_DRAW) {
+
+			addr_to_string(tmp_addr_str, info->packet.vis_orig);
+			seq_printf(seq, "\tsubgraph \"cluster_%s\" \{\n", tmp_addr_str);
+			while (if_entries !=3D NULL) {
+
+				addr_to_string(tmp_addr_str, if_entries->addr);
+				if (if_entries->primary)
+					seq_printf(seq, "\t\t\"%s\" [peripheries=3D2]\n", tmp_addr_str);
+				else
+					seq_printf(seq, "\t\t\"%s\"\n", tmp_addr_str);
+
+				/* ... and empty the list while doing this */
+				tmp_if_next =3D if_entries->next;
+				kfree(if_entries);
+				if_entries =3D tmp_if_next;
+			}
+			seq_printf(seq, "\t}\n");
+		}
+#endif /* VIS_SUBCLUSTERS_DISABLED */
 	}
 	spin_unlock(&vis_hash_lock);
=20
Index: proc.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- proc.h	(revision 1418)
+++ proc.h	(working copy)
@@ -35,3 +35,13 @@
=20
 void cleanup_procfs(void);
 int setup_procfs(void);
+
+/* While scanning for vis-entries of a particular vis-originator
+ * this list collects its interfaces to create a subgraph/cluster=20
+ * out of them later
+ */
+struct vis_if_list {
+	uint8_t addr[ETH_ALEN];
+	bool primary;
+	struct vis_if_list *next;
+};
Index: main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- main.c	(revision 1418)
+++ main.c	(working copy)
@@ -224,6 +224,8 @@
 		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
 }
=20
+/* returns 1 if they are the same originator */
+
 int compare_orig(void *data1, void *data2)
 {
 	return (memcmp(data1, data2, ETH_ALEN) =3D=3D 0 ? 1 : 0);
Index: main.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- main.h	(revision 1418)
+++ main.h	(working copy)
@@ -25,6 +25,10 @@
 #define DRIVER_DEVICE "batman-adv"
=20
 #define SOURCE_VERSION "0.2-beta"
+
+
+/* B.A.T.M.A.N. parameters */
+
 #define TQ_MAX_VALUE 255
 #define JITTER 20
 #define TTL 50		          /* Time To Live of broadcast messages */
@@ -82,6 +86,16 @@
 #define LOG_TYPE_BATMAN_NAME	"batman"
 #define LOG_TYPE_ROUTES_NAME	"routes"
=20
+/*
+ *  Vis
+ */
+
+/* #define VIS_SUBCLUSTERS_DISABLED */
+
+/*=20
+ * Kernel headers
+ */
+
 #include <linux/mutex.h>	/* mutex */
 #include <linux/module.h>	/* needed by all modules */
 #include <linux/netdevice.h>	/* netdevice */

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBAgAGBQJKoWNGAAoJEBKw7u43QNpfp5UQAKcOdm2udrYnsE1valnaEUrN
edFu/ctJnCWz8CfryFsVzONoEhFsO4iwez++46kfT445uIx1EiGMDhCZ94bDdhfA
tyHnDFtntDPv0rRr4uK8zUZhhUQlxOxeKBArbYmNxDXpMpeF7JAiGNNqg3fqnrX/
yxIxdOYQg/bCpHiiSht0bfxIPTGHTLH2+EHXp7llLlSqushTI1LREq11TP0mibWO
NVhTjdg129+z8BkYP86u+gQWHlGi8Md3EUUcI7eVyI/daSC7kA1qBMkXsVmwQlUV
elf6+gmJuzoAjULBbnizYDuXHePsO4didNA5wIrkpo+EmWz86NsaB8zdGXt3vJAx
F+1/Kbc0PluNzw+ljlf0oLiaD/8hkQPxvGdcsrplNIxiYlZme274Y926r6OU2ANi
fGwc5gW7O6qHeanfkDyOBeAWdQv58RmXdz/NfjdQZrRD4IAR3kLPSD4VjQSSe1wA
Wgr0UgIbfrNNSUFIlUdtewVZ7zjUFUz8FapFY++Z4siJ9iI3ZM67qyIQ5RAdexq1
63fzRDOskbs4CjqzEuj+RTiPBJM6nqYqHpJqGjT5iJsF/mtfza+r8kxj1yb7EBnf
IrA1I//wdZXDuumazIC9racN1+MSrtulb+YBowXPWHZlDj0XmgFWcDIcLaU0pgS4
e3b7v+ypAbQxqPpLZohR
=kDmt
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
