Return-Path: <ordex@autistici.org>
Date: Fri, 25 Jan 2013 14:28:49 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130125132849.GC8211@ritirata.org>
References: <a6ad84c212e89c411dab6b40ac613a61c8b9621c.1359047612.git.mschiffer@universe-factory.net>
 <463977c0dcf7b3fcc6a2aebbb87add0d2377d3de.1359047612.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <463977c0dcf7b3fcc6a2aebbb87add0d2377d3de.1359047612.git.mschiffer@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: filter ARP packets
 with invalid MAC addresses in DAT
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


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2013 at 06:18:27PM +0100, Matthias Schiffer wrote:
> We never want multicast MAC addresses in the Distributed ARP Table, so it=
's
> best to completely ignore ARP packets containing them where we expect uni=
cast
> addresses.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Acked-by: Antonio Quartulli <ordex@autistici.org>

Please merge into maint.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRAoiRAAoJEADl0hg6qKeOFWgP/1ZjkvgV3yh4VRQgJ8JwKZQ0
RKDLiPclk94Ry04WSV+H+mwGfdw2wdCcz9aOSeREhtt+BfgpNUV3+3E5Qvac8grI
XcyI52UQ44JLTiKLRZejWrz/XYrsSdLFxYJrJRtmbWcG+S4XgWTIL8xiZSd9+F9v
m4I8QWh/irCYPLnkrSLe4zYjyRS06PRRokPHdvN6OS1K4egiWAMoJE9jCPsi0GeG
CM2nFiifPGmGFUFJHyYalssrscV83cZVFfi5Ra2B9A42q3Y48OcVHr1A2Ni1jUOj
W1LMvPRkLoWZyhnY87ApPyGDsv4fEsX2yhAEo67PShdFyEShRoCtkhBIHvMmsDSN
D7rd7WvLB5LznNh2uRW8Ih8e5Tiqy+/3F9gxx0phaV66tEfQhGgxM6bAukcNm9ao
frDKnxdS8UDIJFE2K+0aPejhClhSVWjKiTrJZ4J7S2jeVFV1eF0sXiaIHc+8XwoE
moLF2G061tqjQwOH29wOSegUbSq4/UebCsRoTV4OHwYJLvJWGyrI441Ku1iKeq20
NE0xuIi6BkGp5w98IIO151q/uSOmLRhHBOj+1yy1ac2l4jzLop737w4L6DUK1TcU
sUezYBswGNac8r5K3bHw6He4CK6ucQ3l1WAshHuSpByf7XqVagB+zpl6pzmnYKb+
SNmN0Cy41UxoqJdDHQD2
=3eti
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
