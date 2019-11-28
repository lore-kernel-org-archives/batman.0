Return-Path: <a@unstable.cc>
Subject: Re: Host endianness dependent DHT lookup
References: <1815609.duLnqLk4gF@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <29e86b84-9f03-030e-8681-1d4a7b83bf0c@unstable.cc>
Date: Thu, 28 Nov 2019 11:13:21 +0100
MIME-Version: 1.0
In-Reply-To: <1815609.duLnqLk4gF@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R2iJoC1flewOdhqlbwkiYbgcieOyErQrW"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R2iJoC1flewOdhqlbwkiYbgcieOyErQrW
Content-Type: multipart/mixed; boundary="FripAv6tSDWOpLg3cW89hSy2gdiywOgsm"

--FripAv6tSDWOpLg3cW89hSy2gdiywOgsm
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/11/2019 11:01, Sven Eckelmann wrote:
> Hi,
>=20
> I just saw following in batadv_hash_dat():
>=20
> 	key =3D (const unsigned char *)&dat->vid;
> 	for (i =3D 0; i < sizeof(dat->vid); i++) {
> 		hash +=3D key[i];
> 		hash +=3D (hash << 10);
> 		hash ^=3D (hash >> 6);
> 	}
>=20
> But the vid is in host order - not big endian like the IP part. So the =

> batadv_dat_select_candidates will select different candidates depending=
 on=20
> whether it is a little or big endian system, right?
>=20

That sounds like a correct statement.

We access the VID byte by byte, therefore different endianness will lead
to different hash values (and thus different candidate selection).

I imagine I haven't observed this issue so far because I always worked
with networks made up by very similar hardware.

> If this is a correct assumption, then we would have this problem since =

> 3e26722bc9f2 ("batman-adv: make the Distributed ARP Table vlan aware")
>=20

That's it. Very nice catch!

Will you send a patch?
I guess converting the VID into network order before accessing it should
be enough, no?


Thanks!

Regards,

--=20
Antonio Quartulli


--FripAv6tSDWOpLg3cW89hSy2gdiywOgsm--

--R2iJoC1flewOdhqlbwkiYbgcieOyErQrW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOj/Eejms5Fxtp0v4pNfqZUlHtXIFAl3fncUACgkQpNfqZUlH
tXI/UA//RoWrsUN1ycbNNk5ssKW5rT33B+WWWVmAgbjO9gpTANk96NeChasJ0aaL
7dXswjcCfZJO5YDxPXCGpCXYhtKtK0sMrg5gQ+CPTH8+QzOODnqX0PRgR7h4Z12Z
bZycGgbufJLC29cxWe3IWABInVXdhvo6IUje/NUnMA47QbBqelYZEbwjOnVHFOCi
ap9icuPOcgxq9vVZ87zUaxijjHbdhA/Eq9ODi4jpIih7M1WM943Qe+m137Pp4DoA
EPUyCbmLGANWQUF9MpP+3tAQngkM49LYtde+mBoUHdVxVHnq5UsVwTKQv4A2yt2g
dxEt0nxcm6qMdfhIREWfRu6idkBOiK8IIqI9MfmmTIobR2h4UotHN4WVDeTgVw4F
79N8Fc6fIohgShuOweb/ww8G0qccxKn6vFOKV/8StU6xB8JyR3VnTJZRdYWf0Jbb
pbXDYaLBrAGON1SFoTG+5oTfjezJqMzuElZV827Kc3vA8ycc5Zg3sbyIDrhsRR4a
QYQBO1gw3AHFDKy6lgoEOoxHCaaSyPbpRK5mNB7AZ86v9+cj1wiLkejGLUQpsPsd
qDVg3PdUuwMS5sAQ2U8iXBVvTwmeKTFQB4SXfcv8CUEvHS7ix8w/lC1R77wpUWHS
GjYRfzIcL1vqvuWp9SWertydw7R7Cy78zVqYJGpTeDqMwWEFWQ8=
=aIIA
-----END PGP SIGNATURE-----

--R2iJoC1flewOdhqlbwkiYbgcieOyErQrW--
