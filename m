Return-Path: <ordex@autistici.org>
Date: Fri, 25 Jan 2013 14:27:07 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130125132707.GB8211@ritirata.org>
References: <20130124151221.GA8211@ritirata.org>
 <1359047907-23522-1-git-send-email-mschiffer@universe-factory.net>
 <a6ad84c212e89c411dab6b40ac613a61c8b9621c.1359047612.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <a6ad84c212e89c411dab6b40ac613a61c8b9621c.1359047612.git.mschiffer@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: check for more types
 of invalid IP addresses in DAT
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


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2013 at 06:18:26PM +0100, Matthias Schiffer wrote:
> There are more types of IP addresses that may appear in ARP packets that =
we
> don't want to process. While some of these should never appear in sane ARP
> packets, a 0.0.0.0 source is used for duplicate address detection and thu=
s seen
> quite often.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Acked-by: Antonio Quartulli <ordex@autistici.org>


Please merge into maint.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRAogrAAoJEADl0hg6qKeODX8P/j+BxQwzZLe0DmI724p0EFM/
hT4mTn1UyDVAwUwiuEwD2EMPRN4bDVLDcwwZ4BHP8gf6ZL+pl3x6h3svZCj9ddKS
7OLFCLpekEDR4GKxuCetAQtI7yLpOnfIv1IXwdauFzc0bgVzw9khuCzWVNIn2YQS
Qu6dNvdhDx9V1jcb9gmuJOng3v6/bjtuY96s885hpqw8wh2UgwfZquJW9//MHx20
daf1MQ+6Sh8ZGLnhY5WqIr3I+1Z7HPcEq9KWyEQrabCvlu5uAe3hcdqpK48YFfuv
GSuCdanYVHPYqphkz5s1E/fz5eRw6U3beXqREgEcNDcBUQnaZqpLTmYfXlMKXWkR
CxyA01Hu+SvUnLNUBADqiA+0kyeyTCVQRHg1Z8wocZ6/xoNWiVXqun8EFhBwQxOY
ZpJZcVmWFKNzvr/FWm3jbS2cL1+n4dA6t2PJc507aIB5S+xhB1VfuSXWdtn5/RBr
WRU/o4AEtkXGskl7qUFwdORl7j9iEuSU2v3wzE0YNOYNwECNVSNZZF3RB6tCjuGa
prHZHaCQV0rbAQIck0cMMMATudNdMvGDPV6ofxVwZIyq6m2Uf5lbVLHF2++vdxY+
wOXx1u8tbYX6eTnr8C5atm9myFK782C/cR+R4kMdsQbL+AvOLtR1HHtUVcFfVw2a
P7ePE1vTggDWBoTvRMKg
=KkRh
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
