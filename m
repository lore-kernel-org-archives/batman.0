Return-Path: <antonio@meshcoding.com>
References: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
 <1440170118-10876-5-git-send-email-sw@simonwunderlich.de>
 <55DC3C65.3010903@meshcoding.com> <2860695.DF0VuzRtbN@prime>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55DCB3E0.9070402@meshcoding.com>
Date: Tue, 25 Aug 2015 20:28:48 +0200
MIME-Version: 1.0
In-Reply-To: <2860695.DF0VuzRtbN@prime>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MDrqp4psINR34NrETkHS4h6eqpp6M4vo3"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 4/4] batman-adv: detect local
 excess vlans in TT request
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MDrqp4psINR34NrETkHS4h6eqpp6M4vo3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 25/08/15 17:31, Simon Wunderlich wrote:
>> batadv_orig_node_vlan_get() returns NULL if we don't know this VLAN fo=
r
>> that Originator, therefore the CRC check fails here.
>=20
> That's right, however it only sweeps through the VLANs announced within=
 the=20
> TT-TVLV. However, my addition tries to check if there are any excess VL=
AN=20
> locally which are NOT in that TT-TVLV. I think this patch doesn't take =
care of=20
> that, or am I missing something?
>=20
> For example, think of having VLAN 6 locally with a couple of global ent=
ries at=20
> the originator, but the TT-TVLV only announces VLANs 3,4,5. Then the fa=
ct that=20
> we also have VLAN 6 is not detected, and these (probably wrong) entries=
 are=20
> never cleaned up.

Right, this check is required, but what about just checking the VLAN
count in the tt packet and in the originator struct ? if the number is
different it means that there must be an excess in the local struct.

Cheers,



--=20
Antonio Quartulli


--MDrqp4psINR34NrETkHS4h6eqpp6M4vo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3LPlAAoJEOb/4TMchkvfyCkP/0Q1dORIsxiXx6cDcSfNuz1+
u4bLHUN3lEv+MrMUoA4U9U5nBMy+GcsTwMTxMSZCJYCeMaQV+tdjCRyG1Xt77IJ0
MPqZgYqnXcUN516d+GuchHG2ZyFcqlvoUMYEmMbi4BDANeqQD/4RA+O7bP7Db86f
oevxP84OwS6SmW+c8zN1Bccbjsi5kVAVbuwEl0OsSYc5oXEiE1sAmNes7GStwgxw
f2/onOPoshAdmfuTipTXLQoci54La7dy7gRrTyd/zItqPeYG1VD+eHiltjuzI6tO
3w3U6SQ/Zc5CKGNKXPcajc7zeoPe8yIitRY2dySkFyLM22wS+FpiYExTqn2Q/RYt
+SgDGeV9Yfea/QgdboeSviVTeAiycUYCfXjlONOEoB4InFRjKmuM9uSevJ7oIAxF
UE9Yw/fRglGjKQl7wwiwxL8GFxLgXoUk8BJAdexjosGHR6cB3KJs6fmo98dr2umO
0yOZC0cU0d1q5iVQJg6RZg+Rya+BkncREmO30IPVjPJLHjVUHu9XHk/GLS8YkpF+
kgt6FQtvwnSemNM+9pD9IK5Y1OsPVaK76d8aZPhEWwpt+1zvS1e7wFiuNCHTA9vg
iRSXPGEIEwfpuuJXOgDGnwwia2l5LIQliTyfzy22StT5H24yUhVEQnOSQpciY3nD
wuhdhuJY3Hgr56+6+Y+o
=vVR3
-----END PGP SIGNATURE-----

--MDrqp4psINR34NrETkHS4h6eqpp6M4vo3--
