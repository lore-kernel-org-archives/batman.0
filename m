Return-Path: <ordex@autistici.org>
Date: Tue, 2 Apr 2013 15:41:55 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130402134155.GK4024@ritirata.org>
References: <1364760198-17043-1-git-send-email-ordex@autistici.org>
 <1364760198-17043-2-git-send-email-ordex@autistici.org>
 <201304021641.31457.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
In-Reply-To: <201304021641.31457.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: tcpdump - print subtype for
 UNICAST4ADDR packets
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2013 at 04:41:31PM +0800, Marek Lindner wrote:
> On Monday, April 01, 2013 04:03:18 Antonio Quartulli wrote:
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> > ---
> >  tcpdump.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tcpdump.c b/tcpdump.c
> > index 39239dd..bf4edd4 100644
> > --- a/tcpdump.c
> > +++ b/tcpdump.c
> > @@ -562,7 +562,8 @@ static void dump_batman_4addr(unsigned char
> > *packet_buff, ssize_t buff_len, int
> >=20
> >  	printf("%s: 4ADDR, subtype %d, ttvn %d, ttl %hhu, ",
> >  	       get_name_by_macaddr((struct ether_addr *)unicast_4addr_packet-=
>u.dest, read_opt),
> >  -	       unicast_4addr_packet->u.ttvn, unicast_4addr_packet->u.header.=
ttl);=20
> >  +	       unicast_4addr_packet->subtype, unicast_4addr_packet->u.ttvn,=
=20
> >  +	       unicast_4addr_packet->u.header.ttl);
> >=20
>=20
> You added the subtype printf format string with the previous patch=20
> already. You might want to fix this.

ops, thanks! I did not realised that when I created the two patches.

Thanks a lot.
Will send v2.

Cheers,
--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRWuAjAAoJEADl0hg6qKeOuIwP/iWw4vWSOtdgt0Ta/cWu8T/s
xskaINs90sBziYOp5NKjiaKZuzd8Gi2QhtX4blqqVQbLN+kLB4GpexSBdCSWdAOD
pxb0v9XeunHOHZ8vdSsn6R1X+iz1dMZtArBag0k07qVDnz6t+9o/a74IbNHC3NpO
lH1JCv+coSd7zX8lNLx6zLd7hhPEWEBkS9GO59j9xixhsp4D0m0Nm7msB7LvoQT/
fuacGlcb8ObpWLOlx0Nk9zHekNCxTbzvX+SmHaGdJ++IEmU2gH3V1ZPmyibj1nXm
adnx3riDqT1cJYcPiJqdMrqgk26Sd/lp9ATMMHNiCjKGyL/rS4nyRD/zNEyn1r4q
cy2lP3Gbwo6jkEYU9Aq534Ig+lzMdJxfGObdEBPW0pkSveyFSMcRzju/fUmXWWld
KcWLqoGCf7W9oUwW9dHedX5B2VN5c0LJjNMKfdVDMMcmRz5MhVMVyAr9CJ9pfA3Q
Vv+E6uwBerzwyuYaDuk/Kua8TB6qVAelvTdK9Lqtbb86y7u7pSaosAN97UoZ26dx
aVxD95Mi62XQGRTqWzX1yXIm5cndpdrYTgUsLIhd9suOTZ0QCpOORehjlXOevr/R
fnmzf9ujkcKx3MDvYDIf//yEF+dOqH/H9uAkK3BI7oWz29x9jZMjWJSxe9dVpEBQ
Tg8jozkHwSbgIsV1516N
=E6xm
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
