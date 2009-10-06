Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 6 Oct 2009 13:55:46 +0200
References: <200910061328.04894.holger@layer-acht.org>
In-Reply-To: <200910061328.04894.holger@layer-acht.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1928017.krmTX2DvKK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910061355.49409.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Fwd: Re: Debian extra modules
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

--nextPart1928017.krmTX2DvKK
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Holger Levsen wrote:
> I've shortened Gregs mail to only have the relevant info for this list :-)
> Full mail is at http://lists.debian.org/debian-kernel/2009/10/msg00236.ht=
ml

> > batman
> > ------
> >
> > A mesh routing system.  Maybe a candidate for staging; try asking
> > upstream.
> >
> > Debian: http://packages.debian.org/source/sid/batmand
> > Upstream: http://www.open-mesh.net/browser/trunk/batman/linux/modules
As far as I know it isn't a part which is currently not targeted for linux-=
2.6=20
(staging or netdev) as this isn't self contained, but just a "hack" to impr=
ove=20
gateway speed with batmand. Marek has to decide what to do with it further.

> > batman-adv
> > ----------
> >
> > A mesh bridging system.  As for batman.
> >
> > Debian: http://packages.debian.org/source/sid/batman-adv-kernelland
> > Upstream: http://www.open-mesh.net/browser/trunk/batman-adv-kernelland
>=20
> Please post this code, if it's a module, and the developers want it
> upstream, I'll be glad to take it in staging.
This one should go staging sometime in the near future. We are in contact w=
ith=20
Greg KH and some preparations are currently done to make it fit into stagin=
g=20
and get it to a review for linux netdev soon.

Parts which are important:
 * TODO list for staging inside batman-adv folder
 * removed compat.h and remaining LINUX_VERSION_CODE (net_device_ops,
   unregister_chrdev)
 * clean Makefile and Kconfig
 * anyone who says how the further development should be done
 * anyone who sends the patch to Greg (probably Marek)

Also a open question is how the "issue" of the closed mailing list should b=
e=20
fixed. Vger doesn't seem to want us before we are successfully reviewed by =
the=20
netdev maintainer. Moving the mailinglist every month doesn't seem to be a=
=20
good idea. Opening this mailinglist could according to Marek create this ml=
=20
useless as there is a big amount of spam send to it. There is a third optio=
n=20
of having the ml semi-open with moderators for mails send by non-subscriber=
s.=20
But we have to decide who does the moderation.

@Marek: Is the postfix server configured to do greylisting? If yes, do you=
=20
have a some statistics about how many spam mails come through and will be=20
kicked out by the mailinglist system? If it isn't that much I would do some=
=20
moderation for some months before we maybe move to a better option.

Best regards,
	Sven

--nextPart1928017.krmTX2DvKK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJKyzBDAAoJEF2HCgfBJntGD2EP+gJnBgmvGWmZdTTzB/pGPosc
c7Pjb0AQ5y7aFzPzWwq6omCnA3OwyR5sJ4J/6liIQKOaPhk2nrOrpAJdJxoDIJmC
Z70iLigRIZOzSsIxHXZRx5Z9Bz0TvfZIqha9zRwDAJxHb3/QqvZVBhw3yeK0/XY6
XdCO5VU+/xGq6nqUr+/ovE4ebaH820TtAZ2o29a8xoYb5rUE5IBzBR+mc3ittX7w
FzrxAIk7TqUyml3xOTO4RylrEJuEtgDKo/qztSLOcQYTPekrBMmjFwb2J3fA3LD1
i5RxE/gNurs02sHPhXjlYPwa73qDgxfoH86bTnGLB86TS06kJuHSKbZxX8/FvsSK
L1tq8QKbFgBG8yJXVureGYZamt0qwM4Lsg3Wlz0NlMXr/lpnjvEIbqQdnsPk/3jD
FYQGv4zvfdd3p9KaCjwz6d1fds/8FpIyaRq68zJ7mQ2zjStZKfd7O9MlMSFilB6i
HnSzeE42b9lrJ2eVSAVM8zka4RvIViOhPBYBmpRDkxsDvawApAg5v5ZccNvM4dxa
fBhaQNNOnsaIexjVtG5T42MopbeXkDACa6Sd2Xwh4ANmGZ+3GGFdfF7rxfsa0L4s
vtq5L9sb69oWWsJszp/+IZ5ECoPOwsHvaToqqZRamFjunWSuBO1CFfWBCzRMT2Nb
U4oMh8/Prgr0aEmMAKoi
=8sjA
-----END PGP SIGNATURE-----

--nextPart1928017.krmTX2DvKK--
