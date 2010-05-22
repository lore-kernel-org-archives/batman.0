Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 17:08:44 +0200
References: <201005221616.46785.sven.eckelmann@gmx.de>
	<20100522143520.GB4070@suse.de>
In-Reply-To: <20100522143520.GB4070@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart141622011.XjxBSiDUvF";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005221708.45102.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/26] Staging: batman-adv
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
To: Greg KH <gregkh@suse.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart141622011.XjxBSiDUvF
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
> On Sat, May 22, 2010 at 04:16:45PM +0200, Sven Eckelmann wrote:
> > Hi,
> >=20
> > we've tried to fix the outstanding problem regarding the sysfs filesyst=
em
> > and fixed some further smaller problems. I hope that it is right were we
> > put the ABI documentation.
>=20
> Not really, but I responded to where it should go on that message.

Thanks. I will move them to the right place.

> As we are now past the .35 merge window, you should consider what
> patches should be acceptable for the .35 release, and which should wait
> until .36.  It looks like about half of these patches should be queued
> up for .35 as they are bug fixes, right?  The api changes by moving
> stuff into debugfs should wait for .36.

The merge window is already closed? v2.6.34 was released 6 days ago. Or do =
you=20
mean that your merge window for staging is closed?

> So could you split this patch set up into two different ones?  One you
> want to see go into .35 and one for .36?

Yes, will do that.

Best regards,
	Sven

--nextPart141622011.XjxBSiDUvF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9/N8AAoJEF2HCgfBJntG6nIP/2k2B6NmoOmNI2R0LI5XzGcy
ksOhUZcPBXRqIAI8y5xJ648sELstZAUxI76RCX7VXa35JqhkNKlC/3281R6EMlly
5B+nBA3AUB8qsIuWpCCa9v/2Y8zzCfZTH2TvjMCoXEqOgZ4hPfCx8ydsU/6arhra
HQ4wZgBSXHr2ZBwd4pIVqEJR9czyv6WykGfnb5HG+t1vyHP5u4SEAHvhto447UWp
PQnmgVEbsQSAYp0QuKbIBLDdOd0SQazKRdudnpvQcW5jDzoosULM7C5/1fjZaxbR
i+QXhaLsVR1NOLNhWvhKEntqVeU2x2cvo7WIVMzgSn+R++xwsXsZfYzk9wRnXzqN
WidMoRH6uG255bQl8tDkQ6zQ7MG5PkBK7+qB7yI1bsLCtDzeh9eneDRWBlcejXjC
IWC2UCqhNtjmwg74dQC8U42rx5eM41MnOhB3vTzKxyp6EPCQKNoOXTmImSDwBvpY
gFUCfMNXXjGsQZVt+e0JpYVwwvLDNcfcKg3trGRzaX1d1DZFdZ63+KmThZqOC8Mb
ILNXSwqjiEpdLxZ6emDa5XPp3aJ3OqJYNiKgeWstbHWY+lqnKQC/REb2sMtJqOGn
fN1wyfqk1RsvTWd9nBoLX2wF875Ukk9Ryp0wJWW0pesXoQ8XWMtXVr88rAxyt+st
5avxqtpg4IWDj8QNq45i
=jiPR
-----END PGP SIGNATURE-----

--nextPart141622011.XjxBSiDUvF--
