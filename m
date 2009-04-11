From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 11 Apr 2009 10:53:27 +0200
References: <200904101231.14877.sven.eckelmann@gmx.de>
	<200904110634.39509.lindner_marek@yahoo.de>
In-Reply-To: <200904110634.39509.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1772088.EVYXADZHMk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200904111053.31967.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Out of tree builds of kernel modules
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
To: b.a.t.m.a.n@open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1772088.EVYXADZHMk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

> > First thing is that there is a Makefile.kbuild which is included with
> >  include $(PWD)/Makefile.kbuild
> > This will not work in the current situation because the PWD is now
> > /usr/src/linux-headers-2.6.29-1-amd64. Is this extra Makefile.kbuild
> > really needed?
>
> the Makefile.kbuild was introduced to support OpenWRT better (OpenWRT uses
> the kbuild Makefile only and replaces the main Makefile with its own).
> Could we do the same with debian ?
I do something like this at the moment. I generate the kernel module source=
=20
=2Etar.bz2 by with Makefile.kbuild (renamed to Makefile) and add "all" and=
=20
"clean" target. They are needed to be able to run module-assistent at the=20
moment... maybe I can change this in the future slightly and only use=20
Makefile.kbuild as openwrt does it.

> > The batmand-gateway cannot be build for linux 2.6 if the current kernel
> > is a 2.4.x. Isn't it possible to make the obj-m and batgat-objs
> > assignment outside the check for the kernel version?
>
> I'm not so sure what you have in mind. Could you explain it further ?
I was thinking a little bit too loud. The problem is that the version of th=
e=20
current running kernel has nothing to do with the version of the kernel whi=
ch=20
will be the target kernel of the new module. So if somebody (aka build=20
servers) have a 2.4 kernel running and want to build against 2.6... nothing=
=20
will be build at all. So my first idea was to change the lines

 ifeq ($(strip $(findstring $(LINUX26),$(LINUX_VERSION))),$(LINUX26))

 obj-m +=3D batgat.o
 batgat-objs :=3D gateway.o hash.o

 else
to
 obj-m +=3D batgat.o
 batgat-objs :=3D gateway.o hash.o
 ifneq ($(strip $(findstring $(LINUX26),$(LINUX_VERSION))),$(LINUX26))

but as I don't know what possible side effects are - just forget it. It sho=
uld=20
be better to check linux/version.h like madwifi does it, but this adds extr=
a=20
overhead by calling CC and again the problem that the batmand-gateway path =
has=20
to be known when compiling directly over the  kernel source/headers as linu=
x-
modules-extra-2.6 does it.

The really problem when using (unchanged) Makefile.kbuild in batmand-gatewa=
y=20
is that the check for linux-2.6 is not in there - but to patch it for debia=
n=20
is (in my opinion) the cleanest version for everyone.

If no better solution comes to my mind, I would say that nothing should be=
=20
changed at the moment.

Best regards,
	Sven

--nextPart1772088.EVYXADZHMk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkngWogACgkQqQGwKVlMoDvE1QCeIfxTa5MwagbqE/1M0TpZPlxN
ImQAnAmYuPkU5W79qM1Z2DuEHlubul/h
=OCnb
-----END PGP SIGNATURE-----

--nextPart1772088.EVYXADZHMk--
