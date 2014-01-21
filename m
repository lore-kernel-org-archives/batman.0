Return-Path: <antonio@meshcoding.com>
Message-ID: <52DE4C6C.10904@meshcoding.com>
Date: Tue, 21 Jan 2014 11:31:08 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JWo5HPVTTXGoewvhHc2pAsKe1PJf62E8O"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix soft-interface MTU
 computation
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JWo5HPVTTXGoewvhHc2pAsKe1PJf62E8O
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21/01/14 11:22, Antonio Quartulli wrote:
> The current MTU computation always returns a value
> smaller than 1500bytes even if the real interfaces
> have an MTU large enough to compensate the batman-adv
> overhead.
>=20
> Fix the computation by properly returning the highest
> admitted value.
>=20

Introduced by f7f2fe494388fca828094a4ebdab918a7b2d64f8
("batman-adv: limit local translation table max size")

> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--JWo5HPVTTXGoewvhHc2pAsKe1PJf62E8O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS3kxvAAoJEEKTMo6mOh1VcVIP/33f+N/894Hpw/v4sZLugUkC
K1txbzG3Ilq01yeFgtAP7S7epkHSTDGZ3ceGpRZd91mNhuNGSN/9TAcuMnTPBpVj
K2lYFN3TYaCExwpFlhWYY4Vf6eb4n7kuc0CkMDZ1pmLJZ4IhsSekohjjwDFAXtWY
Np926E/CeqwJSa9olV6JE14jmUWzRAszY9KzzV91yiRVSVBw3W+ZVApbTR1G7nF6
qFvcUAszQpWyt3NW2Fc0+9weQc2WYy/b7jscdan+eQO0ZAUa5fPCD8btvbzcppIL
lXYZKFQCXMi+At2EXHuAJyvKmrOZW6QsZ9R4jXZPvPkFLUPpAFXIUQgGL5CGLY/s
zsvcufg7ehBXzg5NWFTaXmEB5vaUHqwitGYjndz4VWc1bfbV+sQWb5N68VUkhuXd
RNfE1OK4X0BrsW8O7s8BJ+uTSWxl+F2XhNujk8wY6zVmlYVN5/WJX4rloShcSN63
jyyQTttp3mByWNcckcCKthl4GB9P2Og97nHkdgwHzTVJnQoJ8iSY+1+hBcztLepM
hosJB+HT79LuQ7NBhq7bR2S/JXVj8MbJQ/BqysEG15DmY5ZBqbqunw0UvDuAUZbq
gMey2MoUhlix+qI0z87NVmydbKqKYGPQqgNJob9tjcxYoTBW+yaUu4oib1KW3yVi
lORKmYrC2hNS1BpkK3f4
=ari1
-----END PGP SIGNATURE-----

--JWo5HPVTTXGoewvhHc2pAsKe1PJf62E8O--
