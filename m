Return-Path: <antonio@meshcoding.com>
Message-ID: <54A9663F.9070008@meshcoding.com>
Date: Sun, 04 Jan 2015 17:11:43 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1418509935-11849-1-git-send-email-linus.luessing@c0d3.blue>
 <1869722.k5Ufm3Cai9@diderot> <54A964D7.5070107@meshcoding.com>
In-Reply-To: <54A964D7.5070107@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GfqOO31hSV0n4UKgCBw5QJadWpiUuN6C4"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix potential TT
 client + orig-node memory leak
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GfqOO31hSV0n4UKgCBw5QJadWpiUuN6C4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 04/01/15 17:05, Antonio Quartulli wrote:
>=20
> Hi Linus and thanks for fixing this TT bug!
>=20
> I agree with Marek about extending the commit message with a better
> explanation of the actual bug, but at the same time I think it is good
> to keep the commit message and ID of the other involved patches.
>=20
> Moreover, please keep the commit ID of our batman-adv.git tree - I'll
> then take care of converting them when sending the patches upstream.

I forgot..for the patch:

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

--=20
Antonio Quartulli


--GfqOO31hSV0n4UKgCBw5QJadWpiUuN6C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUqWZDAAoJEJgn97Bh2u9eW1wQALxL5pTvWUON+skdd6CDrCsS
GSpt3DMuiGQWJwfHJv3d+Hh1eNCIcU6kVvvV2JHedPEtz8VcGTLoKgjGrsUm/tp4
RJwCWXhdhnAPJ4aYA3XfIjWStRImOBGgNc/sh9K/MvUbIJ3JN9DOkrKH0iUYsyoc
J603+IoRHrNP0n6B9B8+Z4qX1DQa/tpITTqdvxUaPEoaSxG7N/ZhyMCMvyhgwrGg
NbfhZTNQ9+n0OZSAgSPOJEe6PD7uFJmPZsk8EP3i2+aB+YmXuvkpdRGDm2eAZxTv
pbRMz0kA53FiaszwcPHY1sumylNj+e/KRxbQExOTH8NIzZW/v3r+olbvYlatbDMd
XHZduk78fLdgE6r4FBrsP1YykIHGnewNJVNAfS3MVuEESwPNw18Uus4wvBFP9L7p
yM+GMVHhmRHDG0r6g/7C3/CjRXdlm8rqbTdMpM5GciLX9uCInvq0y+aXZkC1TdZb
xEqlIMyniiByeW6eOJ1iVSFIm7DxU0iebxPY11APny95uwMYnXX88tWSP2hszhaZ
1hLEWdwr1c0C2TSVui/tDj2JYbXHqbZgLb+ju9vzrdpkwLDcQmcoqMWgjwfldHR0
uB3ZPM69AsA2K/2fcXK9PsdKfqx4djl+rgYNeeoVvxrJZDX4Zf7iXustYqAqdtoQ
rFLFOkWo5FEgfhq5+Vxm
=CWas
-----END PGP SIGNATURE-----

--GfqOO31hSV0n4UKgCBw5QJadWpiUuN6C4--
