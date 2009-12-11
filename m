Return-Path: <linus.luessing@web.de>
Date: Fri, 11 Dec 2009 23:58:35 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091211225835.GA17140@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20091130211445.GN4150@lunn.ch>
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
To: b.a.t.m.a.n@lists.open-mesh.net


--Fig2xvG2VGoz8o/s
Content-Type: multipart/mixed; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Andrew,

your patch seems to work pretty well here, tested it with 9
batman-nodes in the same room. Nevertheless I found a couple of
smaller bugs in there:
- batctl segfaults, if "batctl vis" has no following argument
- batctl now displays the help-page in certain situations where we
  don't want it to
- batctl ommits the first TQ tupel
The attached patch for your patch should fix these issues :).

And I wanted to ask, what do you think about unifying the specific
help output? For instance having this "Usage: ..."-header and the
alignment for the following items the same way as it is done for
other batctl commands as well.

Cheers, Linus

PS:
Hmm, I'm also missing a couple of link/TQ entries already in the
unified /proc/../vis. The 9 nodes in the same room should be able
to see each other - the originator table on those nodes is also
saying so. But I think I had seen this before without your patch,
the problems has to be somewhere else. I'm attaching a batctl-vis-
and proc-vis-output of the setup here too, just in case someone
might spot some (more) parsing mistakes.

--NDin8bjvE/0mNLFQ
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="batctl-vis-patch.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur batctl/functions.c batctl2/functions.c
--- batctl/functions.c	2009-12-11 23:10:31.000000000 +0100
+++ batctl2/functions.c	2009-12-11 23:09:48.000000000 +0100
@@ -161,10 +161,10 @@
=20
 	if (read_opt & USE_READ_BUFF) {
 		read_ptr =3D read_buff;
-		read_len =3D sizeof(read_buff);
+		read_len =3D sizeof(read_buff)-1;
 	} else {
 		read_ptr =3D lbuff;
-		read_len =3D sizeof(lbuff);
+		read_len =3D sizeof(lbuff)-1;
 	}
=20
 open:
diff -ur batctl/main.c batctl2/main.c
--- batctl/main.c	2009-12-11 23:10:31.000000000 +0100
+++ batctl2/main.c	2009-12-11 23:09:48.000000000 +0100
@@ -121,7 +121,7 @@
=20
 		ret =3D handle_proc_setting(argc - 1, argv + 1, PROC_ORIG_INTERVAL, orig=
_interval_usage);
=20
-	} if (strcmp(argv[1], "vis") =3D=3D 0) {
+	} else if (strcmp(argv[1], "vis") =3D=3D 0) {
=20
 		ret =3D vis(argc - 1, argv + 1);
=20
diff -ur batctl/vis.c batctl2/vis.c
--- batctl/vis.c	2009-12-11 23:10:48.000000000 +0100
+++ batctl2/vis.c	2009-12-11 23:29:04.000000000 +0100
@@ -215,7 +215,7 @@
  =20
   while ((read =3D getline(&line, &len, fp)) !=3D -1) {
     /* First MAC address is the originator */
-    orig =3D strtok_r(line, " ", &line_save_ptr);
+    orig =3D strtok_r(line, ",", &line_save_ptr);
=20
     duplet_save_ptr =3D line_save_ptr;
     while ((duplet =3D strtok_r(NULL, ",", &duplet_save_ptr)) !=3D NULL) {
@@ -265,10 +265,12 @@
   int c;
  =20
   /* Do we know the requested format? */
-  if (strcmp(argv[1], "dot") =3D=3D 0)
-    dot=3Dtrue;
-  if (strcmp(argv[1], "json") =3D=3D 0)
-    json=3Dtrue;
+  if(argc > 1) {
+    if (strcmp(argv[1], "dot") =3D=3D 0)
+      dot=3Dtrue;
+    if (strcmp(argv[1], "json") =3D=3D 0)
+      json=3Dtrue;
+  }
  =20
   if (!dot && !json) {
     usage();
@@ -319,5 +321,3 @@
=20
   return EXIT_FAILURE;
 }
- =20
-

--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="batctl-vis.log"
Content-Transfer-Encoding: quoted-printable

06:24:01:b7:69:c1,TQ 06:24:01:b7:6a:d9 247, TQ 06:24:01:b7:6a:d1 247, TQ 06=
:24:01:b7:61:1b 255, TQ 06:24:01:b7:6a:b3 255, TQ 06:24:01:b7:6a:fd 255, TQ=
 06:24:01:b7:61:49 251, HNA 72:43:e7:02:8f:96, HNA 00:24:01:b7:69:c1, PRIMA=
RY,=20
06:24:01:b7:61:19,TQ 06:24:01:b7:6a:d9 249, TQ 06:24:01:b7:6a:d1 255, TQ 06=
:24:01:b7:61:1b 255, TQ 06:24:01:b7:6a:b3 247, TQ 00:13:e8:50:c0:ff 248, HN=
A 00:24:01:b7:61:19, HNA d6:59:34:c6:ee:ce, PRIMARY,=20
06:24:01:b7:6a:b3,TQ 06:24:01:b7:69:c1 251, TQ 06:24:01:b7:6a:d9 255, TQ 06=
:24:01:b7:6a:d1 254, TQ 06:24:01:b7:61:19 247, TQ 06:24:01:b7:61:1b 255, TQ=
 00:13:e8:50:c0:ff 247, TQ 06:24:01:b7:6a:fd 255, TQ 06:24:01:b7:61:49 255,=
 HNA 6e:49:09:0e:30:1f, HNA 00:24:01:b7:6a:b3, PRIMARY,=20
06:24:01:b7:6a:fd,TQ 06:24:01:b7:69:c1 255, TQ 06:24:01:b7:6a:d9 251, TQ 06=
:24:01:b7:61:19 247, TQ 06:24:01:b7:61:1b 255, TQ 06:24:01:b7:6a:b3 255, TQ=
 00:13:e8:50:c0:ff 251, TQ 06:24:01:b7:61:49 247, HNA be:38:d5:48:ad:58, HN=
A 00:24:01:b7:6a:fd, PRIMARY,=20
06:24:01:b7:61:49,TQ 06:24:01:b7:69:c1 254, TQ 06:24:01:b7:6a:d1 251, TQ 06=
:24:01:b7:61:19 255, TQ 06:24:01:b7:61:1b 252, TQ 06:24:01:b7:6a:b3 255, TQ=
 00:13:e8:50:c0:ff 255, TQ 06:24:01:b7:6a:fd 255, HNA 00:24:01:b7:61:49, HN=
A 86:44:91:74:79:cc, PRIMARY,=20
06:24:01:b7:6a:d9,TQ 06:24:01:b7:69:c1 255, TQ 06:24:01:b7:6a:d1 251, TQ 06=
:24:01:b7:61:19 255, TQ 06:24:01:b7:61:1b 251, TQ 06:24:01:b7:6a:b3 255, TQ=
 00:13:e8:50:c0:ff 255, TQ 06:24:01:b7:6a:fd 247, TQ 06:24:01:b7:61:49 250,=
 HNA 00:24:01:b7:6a:d9, HNA 9a:6e:8f:f0:90:a2, PRIMARY,=20
06:24:01:b7:6a:d1,TQ 06:24:01:b7:69:c1 251, TQ 06:24:01:b7:6a:d9 250, TQ 06=
:24:01:b7:61:19 255, TQ 06:24:01:b7:61:1b 255, TQ 06:24:01:b7:6a:b3 253, TQ=
 00:13:e8:50:c0:ff 251, TQ 06:24:01:b7:6a:fd 255, HNA 00:24:01:b7:6a:d1, HN=
A 9a:8e:ad:ea:e0:dc, PRIMARY,=20
06:24:01:b7:61:1b,TQ 06:24:01:b7:6a:d9 255, TQ 06:24:01:b7:6a:d1 255, TQ 06=
:24:01:b7:61:19 247, TQ 06:24:01:b7:6a:b3 255, TQ 00:13:e8:50:c0:ff 255, TQ=
 06:24:01:b7:6a:fd 251, HNA 5e:2b:6b:67:d7:17, HNA 00:24:01:b7:61:1b, PRIMA=
RY,=20
00:13:e8:50:c0:ff,TQ 06:24:01:b7:69:c1 255, TQ 06:24:01:b7:6a:d9 251, TQ 06=
:24:01:b7:6a:d1 255, TQ 06:24:01:b7:61:1b 247, TQ 06:24:01:b7:6a:b3 255, TQ=
 06:24:01:b7:6a:fd 255, HNA 72:c5:18:83:3a:a3, PRIMARY,=20

--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="proc-vis.log"

digraph {
	"06:24:01:b7:69:c1" -> "06:24:01:b7:6a:d9" [label="1.32"]
	"06:24:01:b7:69:c1" -> "06:24:01:b7:6a:d1" [label="1.32"]
	"06:24:01:b7:69:c1" -> "06:24:01:b7:61:1b" [label="1.0"]
	"06:24:01:b7:69:c1" -> "06:24:01:b7:6a:b3" [label="1.0"]
	"06:24:01:b7:69:c1" -> "06:24:01:b7:6a:fd" [label="1.0"]
	"06:24:01:b7:69:c1" -> "06:24:01:b7:61:49" [label="1.15"]
	"06:24:01:b7:69:c1" -> "72:43:e7:02:8f:96" [label="HNA"]
	"06:24:01:b7:69:c1" -> "00:24:01:b7:69:c1" [label="HNA"]
	subgraph "cluster_06:24:01:b7:69:c1" {
		"06:24:01:b7:69:c1" [peripheries=2]
	}
	"06:24:01:b7:61:19" -> "06:24:01:b7:6a:d9" [label="1.24"]
	"06:24:01:b7:61:19" -> "06:24:01:b7:6a:d1" [label="1.0"]
	"06:24:01:b7:61:19" -> "06:24:01:b7:61:1b" [label="1.0"]
	"06:24:01:b7:61:19" -> "06:24:01:b7:6a:b3" [label="1.32"]
	"06:24:01:b7:61:19" -> "00:13:e8:50:c0:ff" [label="1.28"]
	"06:24:01:b7:61:19" -> "00:24:01:b7:61:19" [label="HNA"]
	"06:24:01:b7:61:19" -> "d6:59:34:c6:ee:ce" [label="HNA"]
	subgraph "cluster_06:24:01:b7:61:19" {
		"06:24:01:b7:61:19" [peripheries=2]
	}
	"06:24:01:b7:6a:b3" -> "06:24:01:b7:69:c1" [label="1.15"]
	"06:24:01:b7:6a:b3" -> "06:24:01:b7:6a:d9" [label="1.0"]
	"06:24:01:b7:6a:b3" -> "06:24:01:b7:6a:d1" [label="1.3"]
	"06:24:01:b7:6a:b3" -> "06:24:01:b7:61:19" [label="1.32"]
	"06:24:01:b7:6a:b3" -> "06:24:01:b7:61:1b" [label="1.0"]
	"06:24:01:b7:6a:b3" -> "00:13:e8:50:c0:ff" [label="1.32"]
	"06:24:01:b7:6a:b3" -> "06:24:01:b7:6a:fd" [label="1.0"]
	"06:24:01:b7:6a:b3" -> "06:24:01:b7:61:49" [label="1.0"]
	"06:24:01:b7:6a:b3" -> "6e:49:09:0e:30:1f" [label="HNA"]
	"06:24:01:b7:6a:b3" -> "00:24:01:b7:6a:b3" [label="HNA"]
	subgraph "cluster_06:24:01:b7:6a:b3" {
		"06:24:01:b7:6a:b3" [peripheries=2]
	}
	"06:24:01:b7:6a:fd" -> "06:24:01:b7:69:c1" [label="1.0"]
	"06:24:01:b7:6a:fd" -> "06:24:01:b7:6a:d9" [label="1.15"]
	"06:24:01:b7:6a:fd" -> "06:24:01:b7:61:19" [label="1.32"]
	"06:24:01:b7:6a:fd" -> "06:24:01:b7:61:1b" [label="1.0"]
	"06:24:01:b7:6a:fd" -> "06:24:01:b7:6a:b3" [label="1.0"]
	"06:24:01:b7:6a:fd" -> "00:13:e8:50:c0:ff" [label="1.15"]
	"06:24:01:b7:6a:fd" -> "06:24:01:b7:61:49" [label="1.32"]
	"06:24:01:b7:6a:fd" -> "be:38:d5:48:ad:58" [label="HNA"]
	"06:24:01:b7:6a:fd" -> "00:24:01:b7:6a:fd" [label="HNA"]
	subgraph "cluster_06:24:01:b7:6a:fd" {
		"06:24:01:b7:6a:fd" [peripheries=2]
	}
	"06:24:01:b7:61:49" -> "06:24:01:b7:69:c1" [label="1.3"]
	"06:24:01:b7:61:49" -> "06:24:01:b7:6a:d1" [label="1.15"]
	"06:24:01:b7:61:49" -> "06:24:01:b7:61:19" [label="1.0"]
	"06:24:01:b7:61:49" -> "06:24:01:b7:61:1b" [label="1.11"]
	"06:24:01:b7:61:49" -> "06:24:01:b7:6a:b3" [label="1.0"]
	"06:24:01:b7:61:49" -> "00:13:e8:50:c0:ff" [label="1.0"]
	"06:24:01:b7:61:49" -> "06:24:01:b7:6a:fd" [label="1.0"]
	"06:24:01:b7:61:49" -> "00:24:01:b7:61:49" [label="HNA"]
	"06:24:01:b7:61:49" -> "86:44:91:74:79:cc" [label="HNA"]
	subgraph "cluster_06:24:01:b7:61:49" {
		"06:24:01:b7:61:49" [peripheries=2]
	}
	"06:24:01:b7:6a:d9" -> "06:24:01:b7:69:c1" [label="1.0"]
	"06:24:01:b7:6a:d9" -> "06:24:01:b7:6a:d1" [label="1.15"]
	"06:24:01:b7:6a:d9" -> "06:24:01:b7:61:19" [label="1.0"]
	"06:24:01:b7:6a:d9" -> "06:24:01:b7:61:1b" [label="1.15"]
	"06:24:01:b7:6a:d9" -> "06:24:01:b7:6a:b3" [label="1.0"]
	"06:24:01:b7:6a:d9" -> "00:13:e8:50:c0:ff" [label="1.0"]
	"06:24:01:b7:6a:d9" -> "06:24:01:b7:6a:fd" [label="1.32"]
	"06:24:01:b7:6a:d9" -> "06:24:01:b7:61:49" [label="1.20"]
	"06:24:01:b7:6a:d9" -> "00:24:01:b7:6a:d9" [label="HNA"]
	"06:24:01:b7:6a:d9" -> "9a:6e:8f:f0:90:a2" [label="HNA"]
	subgraph "cluster_06:24:01:b7:6a:d9" {
		"06:24:01:b7:6a:d9" [peripheries=2]
	}
	"06:24:01:b7:6a:d1" -> "06:24:01:b7:69:c1" [label="1.15"]
	"06:24:01:b7:6a:d1" -> "06:24:01:b7:6a:d9" [label="1.20"]
	"06:24:01:b7:6a:d1" -> "06:24:01:b7:61:19" [label="1.0"]
	"06:24:01:b7:6a:d1" -> "06:24:01:b7:61:1b" [label="1.0"]
	"06:24:01:b7:6a:d1" -> "06:24:01:b7:6a:b3" [label="1.7"]
	"06:24:01:b7:6a:d1" -> "00:13:e8:50:c0:ff" [label="1.15"]
	"06:24:01:b7:6a:d1" -> "06:24:01:b7:6a:fd" [label="1.0"]
	"06:24:01:b7:6a:d1" -> "00:24:01:b7:6a:d1" [label="HNA"]
	"06:24:01:b7:6a:d1" -> "9a:8e:ad:ea:e0:dc" [label="HNA"]
	subgraph "cluster_06:24:01:b7:6a:d1" {
		"06:24:01:b7:6a:d1" [peripheries=2]
	}
	"06:24:01:b7:61:1b" -> "06:24:01:b7:6a:d9" [label="1.0"]
	"06:24:01:b7:61:1b" -> "06:24:01:b7:6a:d1" [label="1.0"]
	"06:24:01:b7:61:1b" -> "06:24:01:b7:61:19" [label="1.32"]
	"06:24:01:b7:61:1b" -> "06:24:01:b7:6a:b3" [label="1.0"]
	"06:24:01:b7:61:1b" -> "00:13:e8:50:c0:ff" [label="1.0"]
	"06:24:01:b7:61:1b" -> "06:24:01:b7:6a:fd" [label="1.15"]
	"06:24:01:b7:61:1b" -> "5e:2b:6b:67:d7:17" [label="HNA"]
	"06:24:01:b7:61:1b" -> "00:24:01:b7:61:1b" [label="HNA"]
	subgraph "cluster_06:24:01:b7:61:1b" {
		"06:24:01:b7:61:1b" [peripheries=2]
	}
	"00:13:e8:50:c0:ff" -> "06:24:01:b7:69:c1" [label="1.0"]
	"00:13:e8:50:c0:ff" -> "06:24:01:b7:6a:d9" [label="1.15"]
	"00:13:e8:50:c0:ff" -> "06:24:01:b7:6a:d1" [label="1.0"]
	"00:13:e8:50:c0:ff" -> "06:24:01:b7:61:1b" [label="1.32"]
	"00:13:e8:50:c0:ff" -> "06:24:01:b7:6a:b3" [label="1.0"]
	"00:13:e8:50:c0:ff" -> "06:24:01:b7:6a:fd" [label="1.0"]
	"00:13:e8:50:c0:ff" -> "72:c5:18:83:3a:a3" [label="HNA"]
	subgraph "cluster_00:13:e8:50:c0:ff" {
		"00:13:e8:50:c0:ff" [peripheries=2]
	}
}

--NDin8bjvE/0mNLFQ--

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLIs6bAAoJEBKw7u43QNpf/FsP/RK1K73Ory48tFGT6x2ibdUz
XICqdf+NlfDQsdLEjLT8H73gnr5H7Eg4KGhFbMMCPVMWh1nGG0SKpu4ZczPQKOMZ
GXvcMxN3sHK+htt0+nBRMimhAsOcmp6VgHSxNOg+N9n+jiiqjWJc7QEzUAPPqTN7
npLz1fXgsxXMTy/n4ePdlPJuvNAaGUZcKx/k6mHLr2m5Npw3P0iLhd2UenGU18gp
zhWSjlpj3tFtL/u3YlZIeXapOpT85NbmYiNGc3vZ+rCQkXVJ/2cmSrnk5qocj0sc
L3pI51iCFgvTZxkgyxGgR/o2Wa5QclfllRfXVWFG49tar89yePIvexb92mGcyd5a
wy3tIv7H/3Q98l2jJBIoqxvn9npS2hICwlmDYtb0dpzLgrrKfZIgFE+frHTI/sWI
vXeXKfFnYqYqPmSQH4nXluSX+Ee1uMHCPqMX3Qeg/1aiI3YweK+ZtpF+SD06E8iy
StoEgSEgTIwuinBiSjPJEyUdeOVKPbMdwAjy7VCZmn1UgvVEZ9ZE3Oc28L133GMP
QpAZ76AuI1E4p8Oaw/I5DAyQ7+WWj1x0XWxW7oWULTsKVFsMJQoC2KeOzkgDyUXs
GWzcGIm9kUJg68WBv5a8chf2hFvwdALXcv+7OrBcYYquMBYCJD/rnz/6ZdWNYu4+
LjD5pdJy+jMI3H1kgSEK
=7e4N
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
