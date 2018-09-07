Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 07 Sep 2018 18:25:33 +0800
Message-ID: <45216149.LrRsuFWNSN@rousseau>
In-Reply-To: <20180522211214.GG15580@otheros>
References: <20180511185723.20138-1-mareklindner@neomailbox.ch>
 <20180522211214.GG15580@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5067488.0HYdFVKV6q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC maint v2] batman-adv: fix adding VLANs with
 partial state
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, lemoer <freifunk@irrelefant.net>

--nextPart5067488.0HYdFVKV6q
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, 23 May 2018 05:12:14 HKT Linus L=FCssing wrote:
> I tested this patch but so far could not spot any issues either in
> dmesg or logread.
>=20
> I've added these patches to a branch for Gluon here:
>=20
> https://github.com/T-X/gluon/tree/tt-vlan-patched
>=20
> And used these images (warning, they have my SSH public added):
>=20
> https://metameute.de/~tux/Freifunk/firmware/ffh-tt-patched/

Any update on whether this patch has caused any grief ? If not I'd submit a=
s=20
real patch.

Cheers,
Marek

--nextPart5067488.0HYdFVKV6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAluSUh0ACgkQU1VOj+62
HMBMVwf5AZ7tiJUDafShhzSz16fVvy8HPCXg9CxIuAWTGr21KWt0gVpxpQJAGA7B
9kScQplWIZiiILT2GpibBi3GQRad/P6NdqCxFlEIe/NjlcAijqNGQPFxBH8RalEU
KgANfl82Y2gKjnhdbTLxb37sxmyto7K3kgtuORQBp8YfE2DOJr37jdE1pBw3gw3/
Vcp62DaHD5f8DBuFCv32pUIV89UtJsmK8YKNRlLYpIZFQlvWSY8pzQj46pDiFhFc
VskafyXNrt/EcnqGN81V3iq7UmsIs2i9QE8ymKtTcSxvk4lenYAbDH4hM4jWfwWI
54uChsFSRjAYuPUfrILbfO7whChJuQ==
=gosc
-----END PGP SIGNATURE-----

--nextPart5067488.0HYdFVKV6q--



