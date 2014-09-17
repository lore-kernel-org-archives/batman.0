Return-Path: <antonio@meshcoding.com>
Message-ID: <541938E5.8010701@meshcoding.com>
Date: Wed, 17 Sep 2014 09:31:49 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CABQkniB+rTunkzArRbkfxp07zwj_CKP4_VysZkzUpzwPpGt2mw@mail.gmail.com>
In-Reply-To: <CABQkniB+rTunkzArRbkfxp07zwj_CKP4_VysZkzUpzwPpGt2mw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c7fb0v1ADNosGf9r823P5s31N4h3CWXmR"
Subject: Re: [B.A.T.M.A.N.] IBSS key in batman-adv
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
To: zaki.bm@gmail.com
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c7fb0v1ADNosGf9r823P5s31N4h3CWXmR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Zaki,

On 17/09/14 09:04, Zaki wrote:
> Hi,
>=20
>=20
> I have a short question.  I am using IBSS to create batman-adv mesh
> network.  To secure the IBSS, i am using the IBSS key.  I noticed that
> when i am on the mesh network, any device that is not having the key
> also can ping and iperf to me.  I thought IBSS key is supposed to
> allow only legitimate device.  Does anybody know where i do wrong
> here?.

This is more a linux-wireless question other than a batman-adv one.
batman-adv itself can't do much in this case since it does not know
anything about what is happening on the layers below.

In my opinion you are doing something wrong while setting up the
IBSS-RSN mechanism. (I guess you are using IBSS-RSN right ?)

A station not having the correct key should show up in the "station
dump" output of the other nodes with the "Authorized" attribute set to
"no". Is this the case? If not, then something i wrong with the
wpa_supplicant setup.


Cheers,

p.s. I'd recommend CC'ing the linux wireledd mailing list if you have
further questions.

--=20
Antonio Quartulli


--c7fb0v1ADNosGf9r823P5s31N4h3CWXmR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUGTjpAAoJEJgn97Bh2u9eMmkQAKvZt6UCJvnp2OsRqVL/Hj/H
T6G2EoE7umFqjITMBupZwwxge0QsqnU81B9Y7m1mjoJpsqR+Yt/1G4N/04RmNLS+
8W8BPPxsaeXh0XoHRRZEHL3T6Yqhyq7VyHtSz37Y66/CrvzvRWbR7+sNt/zPNsR6
9+xVqy41aEjhfd2V7iFap/JUkoplE8H/Ij/8p0tHR6+l0E13H/isfuIykaycBXNQ
qT+Q6e49P/+JxBU0Jigl5nXIS8kVgJ2Wa6u9g6ziRVzulTqXq4gcDvfqAma1rd4S
/M9unq2HN5gvLsRKzjl/9SsodAxyjHB3RZDHWG4K1LXwHHdZSMI9wFQCg74IbUI+
sj2iifzOfFrtYJ1/ofKMejaCXzwba95Dwbqg9OnWaAiXJ+LYIDQFNnYdz+6+XFxx
cbDFGgN/TjFsO1iCsdwYHpshk1A/N7Fnn4HGVzeYD6gt6A7pwdhXym+0S6pqbT0r
nXKHN+F3EfxrHrToQE0jsXULFS6RHrppNMM46TRRf6xit4CaOlqJ5O1O5V2w3cvC
kZoAjxERQm38LmhaNjeNZbaH0qToWA5hoxXy6tZApjZl79YyrYbnGt4G8LYhqQL6
eB/dtiBYXDxP7zRPT6VuZ/k7aFX1EuplSmt9hyjU3Cd/lOT/g2/pnXUQLtAlnS2t
27D3kW+tm9/QPI8Yx3C1
=3PWG
-----END PGP SIGNATURE-----

--c7fb0v1ADNosGf9r823P5s31N4h3CWXmR--
