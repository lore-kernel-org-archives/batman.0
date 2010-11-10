Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 10 Nov 2010 17:46:37 +0100
References: <12893476522148@site> <201011101117.03979.lindner_marek@yahoo.de>
	<20101110160455.GC10561@suse.de>
In-Reply-To: <20101110160455.GC10561@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11312976.AWeBc4gtNr";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201011101746.42904.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] patch "staging: batman-adv: Use
	linux/etherdevice.h address	helper functions" added to staging tree
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
Cc: tklauser@distanz.ch, Greg KH <gregkh@suse.de>, Marek Lindner <lindner_marek@yahoo.de>, siwu@hrz.tu-chemnitz.de

--nextPart11312976.AWeBc4gtNr
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 10 November 2010 17:04:55 Greg KH wrote:
> > I'm wondering why you accepted this patch despite the raised objections
> > regarding alignment problems. [1][2]
>=20
> Because at the end of that thread, it sounded like you all agreed that
> this patch was acceptable.
>=20
> If not, then please let me know and I will revert it.

The end of the thread was that he should remove parts of the patch and rese=
nt=20
it - or prove that all the data is 2 bytes aligned.


On Wednesday 03 November 2010 11:56:19 Sven Eckelmann wrote:
[...]
> > I don't think they need to be two bytes aligned, but I might be wrong.
>=20
> compare_ether_addr uses a two byte pointer to access 3x two bytes. This
> makes it necessary to have all those 3 bytes aligned to 2 byte boundaries.
[correction sent later: "6x two bytes aligned to 2 byte boundaries"]
> Otherwise the compiler has to generate special instructions on
> architectures which don't support loads on non-aligned addresses. Usually
> he doesn't do it unless he has some indications that it is necessary
> (__attribute__ ((packed)) for example).
>=20
> There is also documentation available on that topic in
> Documentation/unaligned-memory-access.txt
>=20
> And maybe it is good to use is_broadcast_ether_addr, but leave
> compare_ether_addr part open (or prove that we always have those two
> operands correctly aligned).
[...]

None of that happened yet. And yes, this wasn't the last mail we sent to hi=
m=20
to get some response - no answer till now.

Best regards,
	Sven


--nextPart11312976.AWeBc4gtNr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJM2sxuAAoJEF2HCgfBJntGI/cP+gPXMfjuV4r+GrjYzJsDZvNW
IfDwhOwnazb8S/rE4CU1wvaNm5FKemBJTj/zTOm+Mi3I6uuRCIWvyFDXuA5/IbiO
VCwCsFxJEtDVOehFI1PmINtDvFPrs/gbk/D4bIpJkJM4AlmM57ZGlBx7rTccoO91
zeNw2gvygsUgSgUKTNWs0tdiwV2OfPz29KDPumXJ13FxRvAerBx2GlEFWTt55QIY
aMz+Qncb0vUt7hoF7G/dRj2mBR/DkQwZw7XHg1WWkSJ7CFP0pSD5HaHaNcNDc0gm
K/ai/PLtr/4KM7NifgU4cCuw8tuTS+61hxN0cEQEPuI+uMM39cpGDgxIJfGr0i4K
xPEMGyZeR8KYogTEmTWKNzEokBqTLznJoTuc3ndiaPlsrbSG3FIdqxzPeILRwr/p
sU7iB8M4SU7sDIZ6zrfEyEwipUf70JFTRwgXrpXiqp/N3ZmcLDU87LQWEE052hVj
W5gYEqD9fy3CP/UMd0R4FDPL5jPeu8TwALW9kgvZqEkjUjlMOtnBWZlPyNhIkbg/
te5Snyg2Bw83PCtPEd5D+tGlBtp5G9qB3ewaBNDJga9FpoQQv9fTXFJ2HtkKn470
8iQ22WAYO93ZvnIZbD+YzT68GsewvQNWRr1fCQeo1eFjuQ0arECLhfOcWxa1aXo1
Ush7ysfrGmf6GlKRMeF1
=ehGS
-----END PGP SIGNATURE-----

--nextPart11312976.AWeBc4gtNr--
