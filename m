From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 14 Jan 2009 02:36:54 +0100
References: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
	<1F63FEA4-ED42-48C5-B45E-87BF3764F4BB@7degrees.co.za>
	<200901140145.34127.sven.eckelmann@gmx.de>
In-Reply-To: <200901140145.34127.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1486953.3hCWv0dtgv";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200901140236.58441.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Compile vis under FreeBSD and OSX
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

--nextPart1486953.3hCWv0dtgv
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



On Wednesday 14 January 2009 01:45:26 Sven Eckelmann wrote:
> On Tuesday 13 January 2009 22:29:25 Antoine van Gelder wrote:
> > On 13 Jan 2009, at 20:46 , Sven Eckelmann wrote:
> > > PS: Interested in porting batmand again to *bsd plattforms?
> >
> > Possibly - it would be nice to have the option to mesh with a beastie :)
> >
> > Do you have a rough idea of what broke since it last worked ?
>
> Don't know when it worked the last time but it doesnt compile at the
> moment.
>
> There are also some parts marked as "not implemented" in bsd/route.c
> You must check if all functions in bsd/*.c are in sync with linux/*.c

The biggest problem seems to be posix/tunnel.c - it uses struct iphdr from=
=20
netinet/ip.h. FreeBSD will give you struct ip which has completely differen=
t=20
names. So you have to find a good way to get both versions for linux and fo=
r=20
bsd without creating a big mess.
You have also to include netinet/in_systm.h before including netinet/ip.h

Maybe the best way would be to add a function to get the protocol of the=20
tunneled packet (from buffer) and a function to get the destination. After=
=20
copying the implementation for linux you have to implement it for freebsd.

I hope that the rest compiles and links fine and the time to test it begins=
=20
afterwards :D

Best regards,
	Sven


--nextPart1486953.3hCWv0dtgv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkltQbYACgkQqQGwKVlMoDvWGQCfasNYBrKR+aATTB3wJLedTJPl
w+AAn1u2AuqfB9OevJrc/s4IRu/nrsa4
=WF5I
-----END PGP SIGNATURE-----

--nextPart1486953.3hCWv0dtgv--
