Message-Id: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-7-133684884"
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 13 Jan 2009 12:52:35 +0200
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] Compile vis under FreeBSD and OSX
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7-133684884
Content-Type: multipart/mixed; boundary=Apple-Mail-6-133684792


--Apple-Mail-6-133684792
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Some additional includes are required to compile the B.A.T.M.A.N.  
visualization daemon under FreeBSD and OSX.



--Apple-Mail-6-133684792
Content-Disposition: attachment;
	filename=platform.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="platform.patch"
Content-Transfer-Encoding: 7bit

Index: vis.c
===================================================================
--- vis.c	(revision 1178)
+++ vis.c	(working copy)
@@ -23,6 +23,9 @@
 
 
 #include <fcntl.h>
+#if defined(__FreeBSD__) || defined (__APPLE__)
+  #include <sys/socket.h>
+#endif
 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <sys/select.h>
Index: vis.h
===================================================================
--- vis.h	(revision 1178)
+++ vis.h	(working copy)
@@ -25,6 +25,12 @@
 #include <pthread.h>
 #include <sys/socket.h>
 #include <sys/types.h>
+#if defined(__FreeBSD__) || defined (__APPLE__)
+  #include <netinet/in.h>
+#endif
+#if defined(__APPLE__)
+  #include <sys/time.h>
+#endif
 #include <arpa/inet.h>
 #include <errno.h>
 

--Apple-Mail-6-133684792--

--Apple-Mail-7-133684884
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAklscnMACgkQ1/FpN9xKmv6oqwCfa23p3m+bSqeU5YbG6+dDj5O5
gbUAn3yndVnY7VFIB3/jB33T3l9SEdeL
=nC1g
-----END PGP SIGNATURE-----

--Apple-Mail-7-133684884--
