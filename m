Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 26 Apr 2010 10:49:32 +0200
References: <20100425165152.GA1577@pandem0nium>
	<201004252248.20341.sven.eckelmann@gmx.de>
	<201004261555.59856.lindner_marek@yahoo.de>
In-Reply-To: <201004261555.59856.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7120024.dRyRAm55ma";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201004261049.42172.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] 32bit sequence number and TTL for
	broadcasts
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart7120024.dRyRAm55ma
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Monday 26 April 2010 04:48:13 Sven Eckelmann wrote:
> > First thing: it doesn't compile here :( (UML), but I am quite unsure if
> >=20
> >  this is a UML problem like many other things or a bigger problem.... it
> >  seems that it is uml specific as ATOMIC64_INIT and other thingss are
> >  defined, but the implementation of specific functions are missing... b=
ut
> >  this is not the first time such thing happens with uml. Maybe someone
> >  with some time can check different openwrt builds.
> >=20
> > For example other architecture seems to use the generic implementation =
of
> >=20
> >  it: * arm
> >  * parisc
> >  * powerpc
> >  * sh
>=20
> I think Sven got a point here. It seems that for atomic64_t to work one
> needs a CPU which supports 64Bit operations otherwise the linux kernel
> will use its generic implementation.

This is not really true. There are optimized implementation for different c=
pus=20
which don't have 64 bit atomic operations. But yes, the mentioned=20
architectures doesn't seem to have it or I've just ignored their=20
implementation.

> Apparently it uses an array of 16
> spinlocks to provide this functionality. I wonder whether this might be a
> lot of overhead for our needs.

Yes, it uses that array and decides which spinlock to use by hashing the=20
address (probably address & 0xf) - it doesn't use all 16 hashes at the same=
=20
time. It isn't really perfect when we have a lot of cpus and/or stuff which=
=20
generates a lot of interrupts and uses atomic64_t. But I don't think we can=
=20
avoid using spinlocks when we don't use platform optimized atomic*_t.

> Furthermore the generic implementation was
> added recently (as far as I can tell 2.6.30 does not have it) which raises
> the question of backward compatibility.

Correct, forgot to check in which version this functionality came (so it is=
=20
not Simon's fault, but mine). The basic problem why it was decided that it =
is=20
needed to use atomic64_t was that until 2.6.3 atomic_t only provided 24-bit=
=20
useful bits. This would result in in big caps while checking the seqno=20
(problems for restart detection or other things).

The documentation still states that we can only hope for 24 useful bits in=
=20
atomic_read. So I would guess that it is maybe the best idea to ask the ker=
nel=20
developers if the statenments in arch/mn10300/include/asm/atomic.h and=20
include/asm-generic/atomic.h are obsolete and 32 useful bits are guaranteed=
=20
after 2.6.3. Otherwise we have to choose between backward compatibility,=20
spinlock overhead or a magical third option.

Best regards,
	Sven

--nextPart7120024.dRyRAm55ma
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL1VOdAAoJEF2HCgfBJntGxTMP/j0SmS+5QBlp73BHHs8Mp/sC
vapxT/KxU73ccNAiNkU77epEGMpJXlk3VM9r9xr7W9iX5g42K+0LU+MHlbyoS16c
jD90rFXBknJt0COIrZbOWqfGuedcV008UXp6Zlzh+TcLjjxFaphNWL2hPdfKm90n
HK4JKgUye1GlgzWHTzs4lvccIu3iimRPWL1d7rjPcadvAxn5+xCOR0b3CV8SjOki
wQES6OemCVcLuizl900SjZ7SgoKcxTnNjy8hRa7/kA4Y7Y5RFskafSNkXAWf61w5
6QCy8xATm5RfFFpT8qdWmc7PIFC0nV/a2MXvPpEGuY774xi9J4z+I1BLJfJND+4l
iQrfyMAwJzVAS0t3tMq9jIU73LOVcbNbqXbosZ1p9lkzTGVf4l8DZAn6YUMwNu2d
vVJ60pMbIINq5IyW6CWEtU36hZ+l/QDe34yByP7RXCnlK9j7nmYbdihOCtnOuxq1
UmIp0jbVMwEa0q3MC0K5pq5JeBVlb9Yp04sCmVM4C2EDhB9Qpa2g1t17DlCcJawz
J6nPEM4IxIUAklbSKjymtgCnDvyCIfGZvkUQtPSjAIs/G5Ii8VtlWQwRWR8iTCIu
gGG9qTJj0/697+FNW4nmPvAL5uXUZcVZ4nS3NX2pBxq0apXtoJTFZBzajWI0MUts
BMvBpyajFBPSupOM2liO
=Sfms
-----END PGP SIGNATURE-----

--nextPart7120024.dRyRAm55ma--
