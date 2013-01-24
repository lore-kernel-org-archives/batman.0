Return-Path: <ordex@autistici.org>
Date: Thu, 24 Jan 2013 16:12:21 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130124151221.GA8211@ritirata.org>
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <201301242136.11695.lindner_marek@yahoo.de>
 <20130124133858.GB2507@ritirata.org>
 <201301242147.51470.lindner_marek@yahoo.de>
 <510148D3.1010807@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <510148D3.1010807@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: filter out invalid DAT
 entries
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
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2013 at 03:44:35PM +0100, Matthias Schiffer wrote:
> On 01/24/2013 02:47 PM, Marek Lindner wrote:
> > On Thursday, January 24, 2013 21:38:58 Antonio Quartulli wrote:
> >>
> >> I thought the same, but in batadv_arp_get_type() we have a general che=
ck
> >> that discards wrong/bogus ARP request.
> >>
> >> Here instead we are filtering "correct" ARP requests that DAT should n=
ot
> >> handle.
> >=20
> > What is the difference except for the naming ? In both cases we don't w=
ant=20
> > these packets to be handled by DAT.=20
> >=20
> > Feel free to move these extra validation checks into a separate functio=
n that=20
> > gets called from batadv_arp_get_type() if you wish to emphasize the dif=
ference=20
> > between the types of checks. Having all checks in the same place will h=
elp to=20
> > avoid overlooking things later (as already happened).
> >=20
> > Cheers,
> > Marek
> >=20
>=20
> In my opinion, the DAT should handle the sane one of source and
> destination if one of them is sane and the other is bogus. So I would
> maybe rather move all the checks to batadv_dat_entry_add()? There it
> will only catch the add case though, not the lookup case...

I agree with Marek: adding these new checks in a separate function is proba=
bly
better. At that point batadv_arp_get_type() will directly refuse to parse
whatever ARP packet that DAT does not like.

>=20
> At least a check for ff:ff:ff:ff:ff:ff should be added to maint as soon
> as possible, as such entries were actually overwriting correct DAT
> entries on my test node (and maybe even preventing ARP resolution as the
> DAT node answered with these instead of the actual addresses).
>=20

Yes, I agree.
What about modifying your patch following the comments above and resend it?


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--huq684BweRXVnRxX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRAU9VAAoJEADl0hg6qKeOXv0QAIqOuxklncA49gzxzKhtTNbS
fghFKk/KM0piNqsEgF9nojZIl0qsqLfEw2LPotOoYZYOjZHUubgeafkrqF1i2f1N
yRGszBiyupkMWq8S59xIZXaQyAGg+u/GsUBwfZPe5cIFYWYLPQsSINUu+kaPHhtg
hwCVac+iSEPZ2UpKKp45gfpRmT6B+y5QwlQXnPt44GQKv3NhJrwjlJHHzgFZ+Y8K
H15kXKdi5z4RFEBZsvplrwziDXF+YTJyKyGyqq1W2M6aYOJu1bk2pTi5JZaMxsP0
nMr/bbeTlnVgG+kGES9s7fwQU66lWpOTmn7Q2E9K6TsOkwVLINAP80q8Ffx/3KPt
MLveD0TW/vAd9goweomm+LgZ45fA0oanlQ8rGCpiNIS4sjUfN+D6goR4f3rqLMPW
mtfEP5rtp2V/RU8OjJom1s0S5cRhTVPoQkrutK1b/sivSRa9K1urHN71+Q6SLsAS
i9FSkBS0bWuGirUBeY+nYdl8LIR40dz5KXdgBEWstsQB3HebTdm/WQ6Oz/jCi5oV
Q4kJCTVBTl4nEdLc77jDOpR5eTJzztRlva0a79LLH77LHTowk8kGCLif8ctLA5Wi
OtRNm4Lf/R/oUjbCT7WCbdfuPeepVhmXbRi3J60r//MiSgVHT5Z5/xLXHTcGSM9L
Lq8YvzBQdWo26bs658fL
=C8wH
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
