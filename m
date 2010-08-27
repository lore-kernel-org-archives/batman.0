Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 27 Aug 2010 11:59:26 +0200
References: <4C6437BF.9080909@web.de>
	<201008261028.35755.sven.eckelmann@gmx.de>
	<4C7720F1.5030604@bb.banban.jp>
In-Reply-To: <4C7720F1.5030604@bb.banban.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1307900.N0xSM42Eqn";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008271159.28345.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] problem openwrt-trunk + ath5k + batman-adv-devel
	in my case
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

--nextPart1307900.N0xSM42Eqn
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Kazuki Shimada wrote:
[...]
> "exit softif_destroy\n" is not printed out.
> unregister_netdev?

Thanks, perfect work. This is a new bug which was added in the multiple mes=
h=20
patchset. The problem is that the rtnl lock is taken and we still use=20
unregister_netdev when we process an event using hard_if_event.

I have to check other code paths to ensure that I don't destroy other thing=
s,=20
but a workaround for you would be to use unregister_netdevice instead of=20
unregister_netdev in that situation. (Just check v0.2.1-30-g992bfd1 for mor=
e=20
information on that subject).

The problem is that softif_destroy is also called when we unloading the mod=
ule=20
=2D which means that it assumes that the rtnl lock is taken (which it is no=
t=20
when you don't use unregister_netdev there). So I will work on a complete f=
ix=20
and Cc it to you.

Thanks,
	Sven

--nextPart1307900.N0xSM42Eqn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMd4x/AAoJEF2HCgfBJntG+SEQAICQqnIW4FSQNE5kbX2aRuEY
vAcVkr0+b+gL4y8OdWAMk4CAGvaoSyuRFcFVYaXoAR5Za+YZK4dl9MOAgViU61Jy
iXV2V9TJCjiM6G/XJ2iAQLKQnX0HJaURELr/pLy6i/2IASTm9Mc2+YqBiJI32OF1
WTVnGhiBQ92L933XuEPN5dPMUtK/YhXysP/4s3LyQfugSK5gUESsizlzaShl2Fo4
i+e0UoPxM/3m1p1mEaUyLYyn0ajkNQzhEpL4SZ7NWzVoTMc8pFDMYzlfzTOJT0rI
PFGlTlZvZQBWlGC+qDT8ZjQTGJ2dX7P8UJVBfXbdsLis+viRIKfYl8kD4CO/KweX
SsDl/XTbdmDVl5tufz9r5gTyKH+Ee3wmuJagDubVUPVOX2OgQPFFu8zbHvSQ/oJL
hQ+vT6HtQSylKsK27FvzpPKfnEebvXlCihhkP1QhXVvo2Htra53n13F0b/pr7BoG
98O+WQniDvsqpEewSdt0b2clVd/iVkbmgEMt6VNXM/pb/FYoaENzgdf0gqEbi8To
nJ1H8b4gptylyJYad1ke0eMqMcWpcJ6I5VuwTgR+InuphKaTKpdtnbPl15uxleib
SJZXHYWDwRbEVFxbNG/oBKcv7U5rVOj70LFX9R8b+RVqfFatqsGWJoJ6obApSWIg
sGK3cFTM2Q+RxhpNOY4i
=S/qy
-----END PGP SIGNATURE-----

--nextPart1307900.N0xSM42Eqn--
