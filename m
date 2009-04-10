From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 10 Apr 2009 12:31:07 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16978878.qN7gMrYVnl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200904101231.14877.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Out of tree builds of kernel modules
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart16978878.qN7gMrYVnl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I have currently following problem with batman-adv-kernelland and batmand-
gateway:

Danial Baumann supports building of kernel modules against the current Debi=
an=20
kernel in sid with his linux-modules-extra-2.6 package. The module sources=
=20
must only to support build over the kernel headers. It is done like that:
 /usr/bin/make -C /usr/src/linux-headers-2.6.29-1-amd64 M=3D/batman-adv/

So it calls the Makefile in /usr/src/linux-headers-2.6.29-1-amd64 to build =
the=20
sources in /batman-adv/. This seems to be a quite common way to do the buil=
d.=20
There are different problems with the way the current Makefiles of these=20
modules are written.

=46irst thing is that there is a Makefile.kbuild which is included with=20
 include $(PWD)/Makefile.kbuild
This will not work in the current situation because the PWD is now=20
/usr/src/linux-headers-2.6.29-1-amd64. Is this extra Makefile.kbuild really=
=20
needed?
The second problem is the check of KERNELPATH of Makefile. It will check if=
=20
the sources of the current kernel is installed and quits if not (+ error=20
message that someone should set the KERNELPATH variable). In the current=20
situation we don't have the sources of the current kernel installed, but th=
e=20
kernel headers of another kernel are being used automatically. Wouldn't be=
=20
following check

 KERNELPATH ?=3D /lib/modules/$(shell uname -r)/build
 # sanity check: does KERNELPATH exist?
 ifeq ($(shell cd $(KERNELPATH) && pwd),)
 $(warning $(KERNELPATH) is missing, please set KERNELPATH)
 endif

ok too?

The batmand-gateway cannot be build for linux 2.6 if the current kernel is =
a=20
2.4.x. Isn't it possible to make the obj-m and batgat-objs assignment outsi=
de=20
the check for the kernel version?

My current workaround is to install my own version of the Makefile in the=20
debian package, but I ask myself if this is really needed or parts of it=20
should also be changed upstream.

Best regards,
	Sven

--nextPart16978878.qN7gMrYVnl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknfH+sACgkQqQGwKVlMoDtO9wCfdi4omehFS/WdY17b+JkgFF6M
KrAAoMAQkOYA5vIx4amAkpl8IDIddCR5
=XR8l
-----END PGP SIGNATURE-----

--nextPart16978878.qN7gMrYVnl--
