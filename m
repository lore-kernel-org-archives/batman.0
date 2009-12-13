Return-Path: <linus.luessing@web.de>
Date: Sun, 13 Dec 2009 21:02:18 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091213200218.GA4933@Linus-Debian>
References: <20091130211445.GN4150@lunn.ch>
 <20091213161151.GW29768@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20091213161151.GW29768@lunn.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] /proc vis rework
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


--Y7xTucakfITjPcLV
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hmm, everything related to vis-format can be removed from the
kernel(-module) as well, can't it?
This patch applying on top of your batman-adv patch should remove
the vis-format-proc entry and all this dead code if I didn't miss
anything.

Cheers, Linus

--ibTvN161/egqYuK8
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="batman-adv-vis-format-rm.patch"
Content-Transfer-Encoding: quoted-printable

diff -ru batman-adv-kernelland/proc.c batman-adv-kernelland2/proc.c
--- batman-adv-kernelland/proc.c	2009-12-13 20:53:50.000000000 +0100
+++ batman-adv-kernelland2/proc.c	2009-12-13 20:53:07.000000000 +0100
@@ -29,8 +29,6 @@
 #include "vis.h"
 #include "compat.h"
=20
-static uint8_t vis_format =3D DOT_DRAW;
-
 static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
 static struct proc_dir_entry *proc_orig_interval_file, *proc_originators_f=
ile;
 static struct proc_dir_entry *proc_transt_local_file;
@@ -403,11 +401,8 @@
 	struct vis_info_entry *entries;
 	HLIST_HEAD(vis_if_list);
 	int i;
-	uint8_t current_format;
 	char tmp_addr_str[ETH_STR_LEN];
=20
-	current_format =3D vis_format;
-
 	rcu_read_lock();
 	if (list_empty(&if_list) || (!is_vis_server())) {
 		rcu_read_unlock();
@@ -473,55 +468,6 @@
 	return single_open(file, proc_vis_read, NULL);
 }
=20
-static int proc_vis_format_read(struct seq_file *seq, void *offset)
-{
-	uint8_t current_format =3D vis_format;
-
-	seq_printf(seq, "[%c] %s\n",
-		   (current_format =3D=3D DOT_DRAW) ? 'x' : ' ',
-		   VIS_FORMAT_DD_NAME);
-	seq_printf(seq, "[%c] %s\n",
-		   (current_format =3D=3D JSON) ? 'x' : ' ',
-		   VIS_FORMAT_JSON_NAME);
-	return 0;
-}
-
-static int proc_vis_format_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_vis_format_read, NULL);
-}
-
-static ssize_t proc_vis_format_write(struct file *file,
-				     const char __user *buffer,
-				     size_t count, loff_t *ppos)
-{
-	char *vis_format_string;
-	int not_copied =3D 0;
-
-	vis_format_string =3D kmalloc(count, GFP_KERNEL);
-
-	if (!vis_format_string)
-		return -ENOMEM;
-
-	not_copied =3D copy_from_user(vis_format_string, buffer, count);
-	vis_format_string[count - not_copied - 1] =3D 0;
-
-	if (strcmp(vis_format_string, VIS_FORMAT_DD_NAME) =3D=3D 0) {
-		printk(KERN_INFO "batman-adv:Setting VIS output format to: %s\n",
-		       VIS_FORMAT_DD_NAME);
-		vis_format =3D DOT_DRAW;
-	} else if (strcmp(vis_format_string, VIS_FORMAT_JSON_NAME) =3D=3D 0) {
-		printk(KERN_INFO "batman-adv:Setting VIS output format to: %s\n",
-		       VIS_FORMAT_JSON_NAME);
-		vis_format =3D JSON;
-	} else
-		printk(KERN_ERR "batman-adv:Unknown VIS output format: %s\n",
-		       vis_format_string);
-
-	kfree(vis_format_string);
-	return count;
-}
-
 static int proc_aggr_read(struct seq_file *seq, void *offset)
 {
 	seq_printf(seq, "%i\n", atomic_read(&aggregation_enabled));
@@ -585,15 +531,6 @@
 	.release	=3D single_release,
 };
=20
-static const struct file_operations proc_vis_format_fops =3D {
-	.owner		=3D THIS_MODULE,
-	.open		=3D proc_vis_format_open,
-	.read		=3D seq_read,
-	.write		=3D proc_vis_format_write,
-	.llseek		=3D seq_lseek,
-	.release	=3D single_release,
-};
-
 static const struct file_operations proc_vis_fops =3D {
 	.owner		=3D THIS_MODULE,
 	.open		=3D proc_vis_open,
@@ -757,17 +694,6 @@
 		return -EFAULT;
 	}
=20
-	proc_vis_format_file =3D create_proc_entry(PROC_FILE_VIS_FORMAT,
-						 S_IWUSR | S_IRUGO,
-						 proc_batman_dir);
-	if (proc_vis_format_file) {
-		proc_vis_format_file->proc_fops =3D &proc_vis_format_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fail=
ed\n", PROC_ROOT_DIR, PROC_FILE_VIS_FORMAT);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
 	proc_aggr_file =3D create_proc_entry(PROC_FILE_AGGR, S_IWUSR | S_IRUGO,
 					   proc_batman_dir);
 	if (proc_aggr_file) {
diff -ru batman-adv-kernelland/vis.h batman-adv-kernelland2/vis.h
--- batman-adv-kernelland/vis.h	2009-12-13 20:53:26.000000000 +0100
+++ batman-adv-kernelland2/vis.h	2009-12-13 20:53:07.000000000 +0100
@@ -45,11 +45,6 @@
 	uint8_t mac[ETH_ALEN];
 };
=20
-enum vis_formats {
-	DOT_DRAW,
-	JSON,
-};
-
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
=20

--ibTvN161/egqYuK8--

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLJUhKAAoJEBKw7u43QNpfVp8P/jfAhBREcovO1GAauJUZaLeV
B7IoM+OBtmud3a3+R0p9Wc3qy3e6QkaWO/qPX8LVyd5/yO0ETgQutYPElAFhEy72
KIVBnfE4spaaLbda57GLd3FzMHjRJSqgQ3j/jKULwhicA7GY1kZa/QE0NMBHOjBs
grbA7J9QDM5STQJ4NVWxhtol0K4LNnO0VScCQuvJorW5Sd6rsRiZ3Buj7senZNR8
uTqlbUnZ5aWSEPT/2uZDHDUTDfo6S993z1dbnb/H2gUjLqhOWtCD7HAI0MwMe0jP
Oi/bbCqahpROFzZNukPmVLR+6nwYRcwYl9Mjm7RlF+HxIQNbO0UmAWYhIJwHVHVo
gT95SoJlzTb7TRJdJLQLjP/k19aJvmCaURuRLvWdrYbd1dTGLZ6Pw45FHKV0ZUXr
1QYiff0N0jgdMgQfrUmDbgoLHV/eeiTI1rWlxzM3uu5UYiTB6CIbBsHyNbrKYH6M
QDipk9JVqIgdPhWmYHbTrcKuUd6Eg/p4Ua0mfjjGQrMeRZp/2n7ncj07OlAIJa2c
NQE4gyPuptL54EMhhOc/KAcIVfoTROd1vg3CQ8Lj3dgcjofhiseWefvfyKWW5LcK
BUCgYx73fBWiOT0HYUthHD1yiUaxckQMAJYS1tlLKbEdl8OFYbUVC3y59AKPOjH8
FaWHVFdbn5agNDRUtrNg
=/mdz
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
