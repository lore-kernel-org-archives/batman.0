Return-Path: <antonio@meshcoding.com>
Message-ID: <5419252D.7080809@meshcoding.com>
Date: Wed, 17 Sep 2014 08:07:41 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1410866367-14479-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1410866367-14479-1-git-send-email-martin@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BHwdHBfTgDNo31PFWgaUIKg59CkPcBJwX"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: clear control block of
 received socket buffers
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
Cc: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BHwdHBfTgDNo31PFWgaUIKg59CkPcBJwX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 16/09/14 13:19, Martin Hundeb=C3=B8ll wrote:
> Since other network components (and some drivers) uses the control bloc=
k
> provided in skb's, the network coding feature might wrongly assume that=

> an SKB has been decoded, and thus not try to code it with another packe=
t
> again. This happens for instance when batman-adv is running on a bridge=
 device.
>=20
> Fix this by clearing the control block for every received SKB.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>

thanks for this patch.
I guess this patch has to go into maint, but do you have any commit ID
we could specify as Introduced-by ? (if you are about to send v2 with
this info, please write "maint" right after PATCH)


Thanks!


--=20
Antonio Quartulli


--BHwdHBfTgDNo31PFWgaUIKg59CkPcBJwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUGSUxAAoJEJgn97Bh2u9e8soP/j3K9/N1Xz0CVs+7SUa6dIqM
ixxbu1rIMSWOnzWUskQvXEmGe5wULaO3WZr13zfLkftDPhGTXCnof4ViD6QpF3Oe
/x5EQLR0ALaqEwQ7jgxA/Hjpp4BqbZ9oItbKaw3UnR9JRQqtRVOeUWl0HwG6f7BV
buP+lz9ATJqXxVN2qj/uGznkq+fnIewXOYD0OBShB3cgmforo8DTzHhUkBUQ2CL/
LU0lyQ7Vpr+Qi97VaRN5PQRK/v7UJCWmMg9tPmwn7uPK+A6Z3T3Dfcl4ueZQu0/z
Trlv5vagf/6/9u01Y4AbFmebs3Q2BIu3ON/tsGlKCIbnH9O4DYvaqDmKWw2g6sPY
K0zoidwUotNhmmeJJtL3vCUke5Lg/VDgNpZm2DuakXE6gr2tywkugFum2IWgjxAy
cGH2qdwepUPJV5kcJEqXVq3SIR5+TtC59LP1iDknFFNlBf9DmvNHHOhcfVu79Elq
hKDq+3rP1Z75StARuVnfsAADlPtQuqTS7bgMvA8/51CqtgUShZq8hW/PCLSTiFYD
KzD/EPN67yYssh7suW9gsOhilsRHWUe4xTaZQ3WN7JmrnWFZCULdRe4cTDuQ9hX4
u29izCpX0zmsSm33dY3EZzZlbfnmYuCx/tCayDM7hJUM9Lq5OVcLdeMTpoO4fx+I
J/SPY4ZeXR126zKq0WLG
=35Qs
-----END PGP SIGNATURE-----

--BHwdHBfTgDNo31PFWgaUIKg59CkPcBJwX--
