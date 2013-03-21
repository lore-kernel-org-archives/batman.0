Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Mar 2013 09:24:28 +0100
Message-ID: <3212285.GF4Btbehao@sven-desktop>
In-Reply-To: <20130320175154.GT41481@l04.local>
References: <20130320175154.GT41481@l04.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2581391.oDo3UBkN11";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Bug#703540: Inconsistent use of _GNU_SOURCE
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
To: Michael Tautschnig <mt@debian.org>, 703540@bugs.debian.org
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2581391.oDo3UBkN11
Content-Type: multipart/mixed; boundary="nextPart1426864.AEXAifWujZ"
Content-Transfer-Encoding: 7Bit


--nextPart1426864.AEXAifWujZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

tags 703540 + pending patch
thanks

On Wednesday 20 March 2013 17:51:54 you wrote:
> While building the package using our research compiler infrastructure we
> noticed conflicting types being used in the linked executable. This is due
> to _GNU_SOURCE being defined in linux/route.c and posix/unix_socket.c, but
> not in any other file. As a result, system headers expand to conflicting
> declarations. (This was at least noticed for the sendto function, but may
> extend to others.)
> 
> Either all or no file should #define _GNU_SOURCE.

Please add information how to reproduce this the next time you are adding such 
such a bug. Now I can just assume what you are writing is true (even when the 
man page about sendto says otherwise). Not knowing how to reproduce it in the 
best possible way just makes it harder for everyone to check the impact of the 
problem.

I've forwarded it to the upstream maintainer and attached the change for 
Debian.

Kind regards,
	Sven
--nextPart1426864.AEXAifWujZ
Content-Disposition: attachment; filename="0001-Define-_GNU_SOURCE-for-all-POSIX-target-source-files.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-Define-_GNU_SOURCE-for-all-POSIX-target-source-files.patch"

From 5041828ddb165b1c72c7fc4345aa6e0bec7abfa5 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Mar 2013 09:21:48 +0100
Subject: [PATCH] Define _GNU_SOURCE for all POSIX target source files

Defining _GNU_SOURCE in source files differently can result in conflicting
types.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debian/changelog                       |    3 +++
 debian/patches/define_gnu_source.patch |   43 ++++++++++++++++++++++++++++++++
 debian/patches/series                  |    1 +
 3 files changed, 47 insertions(+)
 create mode 100644 debian/patches/define_gnu_source.patch
 create mode 100644 debian/patches/series

diff --git a/debian/changelog b/debian/changelog
index 31e69a6..5d08680 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -2,6 +2,9 @@ batmand (0.3.2+50+g06537ed-2) UNRELEASED; urgency=low
 
   * Upgraded to policy 3.9.4, no changes required
   * Remove obsolete DM-Upload-Allowed in debian/control
+  * debian/patches:
+    - Add define_gnu_source.patch, Define _GNU_SOURCE for all POSIX target
+      source files (Closes: #703540)
 
  -- Sven Eckelmann <sven@narfation.org>  Wed, 19 Sep 2012 08:53:36 +0200
 
diff --git a/debian/patches/define_gnu_source.patch b/debian/patches/define_gnu_source.patch
new file mode 100644
index 0000000..d81235f
--- /dev/null
+++ b/debian/patches/define_gnu_source.patch
@@ -0,0 +1,43 @@
+Description: Define _GNU_SOURCE for all POSIX target source files
+ Defining _GNU_SOURCE in source files differently can result in conflicting
+ types.
+Bug-Debian: #703540
+Author: Sven Eckelmann <sven@narfation.org>
+
+---
+diff --git a/Makefile b/Makefile
+index fe1f094f310469331b3a7ff32e0eb2859bc5c998..ce1e198863aa311d5572e205f68534320d8f8431 100755
+--- a/Makefile
++++ b/Makefile
+@@ -27,6 +27,7 @@ LINUX_OBJ =	linux/route.o linux/tun.o linux/kernel.o
+ 
+ ifeq ($(UNAME),Linux)
+ OS_OBJ =	$(LINUX_OBJ) $(POSIX_OBJ)
++CPPFLAGS +=	-D_GNU_SOURCE
+ endif
+ 
+ OBJ = batman.o originator.o schedule.o list-batman.o allocate.o bitarray.o hash.o profile.o ring_buffer.o hna.o $(OS_OBJ)
+diff --git a/linux/route.c b/linux/route.c
+index 119ebb2c08d0babfacdfa34ca38c74cc3160ff43..bceac95f1fc57c37bd18e1ada15d6f55582043a0 100644
+--- a/linux/route.c
++++ b/linux/route.c
+@@ -21,7 +21,6 @@
+ 
+ 
+ 
+-#define _GNU_SOURCE
+ #include <sys/ioctl.h>
+ #include <arpa/inet.h>    /* inet_ntop() */
+ #include <errno.h>
+diff --git a/posix/unix_socket.c b/posix/unix_socket.c
+index 5bed217e286c247278046967783a197781c9a59e..02a0a3a97284fbf803565e12cebd8b22d305e66f 100644
+--- a/posix/unix_socket.c
++++ b/posix/unix_socket.c
+@@ -21,7 +21,6 @@
+ 
+ 
+ 
+-#define _GNU_SOURCE
+ #include <sys/time.h>
+ #include <stdio.h>
+ #include <fcntl.h>
diff --git a/debian/patches/series b/debian/patches/series
new file mode 100644
index 0000000..f9b7991
--- /dev/null
+++ b/debian/patches/series
@@ -0,0 +1 @@
+define_gnu_source.patch
-- 
1.7.10.4


--nextPart1426864.AEXAifWujZ--

--nextPart2581391.oDo3UBkN11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJRSsO8AAoJEF2HCgfBJntGX7QP/026Y2pCh3XSv2TXEaSBIIS/
eAwwS7UbPRu7p3brKe0nYxNEXng7DjWMHDPmpYENhGjhoAR/w5jUdRxipOZ4o1oC
Ul/jtY/yoZ9Rm4RC7NS8B/d26rFJk4wwlx54/RnUaziSQP3GSEuDX5HOJ/fbfhSw
2AHYt2A3RBjYtEcWFV30DRnmpGvglnwMhh99w2rAuyiEd5Wcyb6dZfEycP6jSTuI
5b8YQfLvqXEhAOrTskid1kcoxQu86zTf9BOdkDHhfxCZNdTi85WivAVJ3pmRVPe4
eXRHjh6Q7cw9vBomXoAZFYfrNDSh+K5KXYNQ93evbSiBtjtBWlUgPiDs0NcUkw/d
jKHkEMhYisaZ2UmCPgUmQY666PEzm8qUyOjx0c0JVdDTNbf+wl1eTmbwbSzmFiyg
RMIohT5ZDGvJm5eA84BjEOvJforbLTAGrfFOvW6ccmPILlNa7btpK1XRCUei4fXi
lh/0yNAlQNaCWlzsPl5e7nTDVS9sPyKsUKbdVbq/I/4m7flYoxbNlkLgJXfEjdsh
zha93x29QQwaRinhQFL8d70q0dctYAYI8zYQc8nDKMc/FxnC45GVw/jm6RES0QtA
3UX89zIO42U0fj/RfdAq5y3hGGPQimgWXdXHk/sJ1JtQTgqdxgXIVIv2xRbiFNt8
tlpT8pQGOEJE8XjYujvl
=q9Zl
-----END PGP SIGNATURE-----

--nextPart2581391.oDo3UBkN11--

