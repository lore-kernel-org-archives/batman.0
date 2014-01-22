Return-Path: <antonio@meshcoding.com>
Message-ID: <52DF0B77.3070106@meshcoding.com>
Date: Wed, 22 Jan 2014 01:06:15 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net> <52D66D45.4060301@wirelesspt.net>
 <52D66DE4.3050300@meshcoding.com> <52DED209.5000207@wirelesspt.net>
 <52DF0A14.3030705@meshcoding.com>
In-Reply-To: <52DF0A14.3030705@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rIx54Oe6upc9j1bm9mwVo9GvMh6Jb6loI"
Subject: Re: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rIx54Oe6upc9j1bm9mwVo9GvMh6Jb6loI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22/01/14 01:00, Antonio Quartulli wrote:
> On 21/01/14 21:01, cmsv wrote:
>> Yes i understand that but it keeps on increasing.
>> [   28.600000] batman_adv: bat0: The MTU of interface adhoc0 is too
>> small (1546) to handle the transport of batman-adv packets. Packets
>> going over this interface will be fragmented on layer2 which could
>> impact the performance. Setting the MTU to 1560 would solve the proble=
m.
>=20
> Have you tried applying this patch before testing it once again?
>=20
> http://git.open-mesh.org/batman-adv.git/commit/746d6436f88899a79c1cb3b2=
7af0614510368bb7
>=20

Actually this patch is already part of the batman-adv package in openwrt.=

Therefore the question turns in: did you update the batman-adv package
before performing your second test?


Cheers,


--=20
Antonio Quartulli


--rIx54Oe6upc9j1bm9mwVo9GvMh6Jb6loI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS3wt6AAoJEEKTMo6mOh1VPpoQAIdVE4BU0yfZr3thZEkvHZSJ
pYrFAYdzXwbeKLmSVT65jY2B6RBSX8Qvr8Y4VZGcd7nqbMB7kcLjVn+6Tk2e1Pso
D3wvctTrnHh3wv1aynmV5B5Oww8BtynMCE6jNW3Qrj5qYIodD8uyWXdDbFkzwBpv
ZI+q05L2mSzut4abquS/b9KBLEyssJ6UnMLQ0EGB48KBkxohjN+cEsayBs/Ha9DN
9NKdoewLbcqXbXNYBFZ17bgulKtv6lcab+v75zM1pH8n1RLRuF5i/hjN2okTmg2x
Bq4Rt/CIPR9LatlQHMZscxSNorB2YIdEnicAigzQMfUow1P6bd9qnJITEoGmHzSc
tylQI9MlBNB/1BrQrWZ6xwuo5ebLLJO8Ve2I6BnGIoIPPbKtBK55yDxRv8L75opN
66jTDAoyiuXw67VBEFDRuOvbzWqsncYivju3ylZtTl50w9bbA/DIirZpKU1nzBFC
XFxKZDMmuTzz6B4zWKpe3uOem15qPSPYFg+AikyPiUcEhuIYLwn1sLspFLaaGtSt
GUuIqRRYuQG/d1reDlVRVLHP4zR8N7hqYC55e0kHktivV7HIfFZD/ZZg9BsZcwwi
GlsoeASP5GO7ErjDkyiMg8B3IoTpjp+2twEulBvPJLdw3ArNls6rBfBN938pFXGi
oBQ6vEyu9l5LFqKoxuv5
=Y1Ur
-----END PGP SIGNATURE-----

--rIx54Oe6upc9j1bm9mwVo9GvMh6Jb6loI--
