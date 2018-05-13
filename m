Return-Path: <a@unstable.cc>
References: <20180512220223.3039-1-mareklindner@neomailbox.ch>
 <2624592.SrqEg3jeUP@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <fa4a5de8-9d10-11db-b758-745ce9f187e1@unstable.cc>
Date: Sun, 13 May 2018 17:19:52 +0800
MIME-Version: 1.0
In-Reply-To: <2624592.SrqEg3jeUP@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jx7yiFZVGspn49JSufos2ojBlnf00e2CO"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: disable ethtool link speed
 detection when auto negotiation off
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jx7yiFZVGspn49JSufos2ojBlnf00e2CO
Content-Type: multipart/mixed; boundary="fOEfhL0TNdJdCyfNTB1SYVPQNdUmS0gax";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <fa4a5de8-9d10-11db-b758-745ce9f187e1@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: disable ethtool link speed
 detection when auto negotiation off
References: <20180512220223.3039-1-mareklindner@neomailbox.ch>
 <2624592.SrqEg3jeUP@sven-edge>
In-Reply-To: <2624592.SrqEg3jeUP@sven-edge>

--fOEfhL0TNdJdCyfNTB1SYVPQNdUmS0gax
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sven,

thanks for your comment.

On 13/05/18 14:56, Sven Eckelmann wrote:
> On Sonntag, 13. Mai 2018 00:02:23 CEST Marek Lindner wrote:
>> If link auto-negotiation is disabled the exported link speed can
>> not be relied on.
>=20
> Why is a manual set speed less worth than a auto-configured one?

if the user wants to configure a "default throughput" for the interface,
he can always use the default_throughput knob in batman-adv.

The problem with autonegotiation disabled is that the advertised speed
is likely to be a random number set by default by the driver.

For example, some people in the freifunk community have tested this
patch because they wanted to see how the tp_meter would perform on VPN
links. Unfortunately the tun.ko module sets 10Mbps/AUTONEG_DISABLE as
default settings.

=46rom there we thought that, after all, if the autonegotiation is
disabled, we should just assume that the speed is likely to be bogus and
it's better to measure it.


Does it make sense?


Cheers,


--=20
Antonio Quartulli


--fOEfhL0TNdJdCyfNTB1SYVPQNdUmS0gax--

--jx7yiFZVGspn49JSufos2ojBlnf00e2CO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlr4AzgACgkQB6U8WA7y
zXT9kg/+Iho8CZdyplOWPwz4uY08/L9l0wexR2iTsaSpDQ9w24AtBX/CqiRjD6u8
VnBIxCKPyRG6Q4cl2/h/kLYFQhRbQ5/vMDu1fbmTpuWebPsvQ/80aBHXtH3TwhSt
g4FBL8SErBa4tjgyxltqWAVDgpibZw773yZNzm805BIzVgKcpaPkypYHGiqdtffg
vb/HjfARnpTaVHNOBd0rAjMkeYU+U6/1gCo53+Vd9XKTJ8GAL0Dbs8Gn+L1HEIKb
50t9EBu1cNbHvxrVB8J/PdWWs30cFBQRCVdzQju50SRJEexPzvIoUvpi+LVYqEdv
Q8ArqHRk6u2DYxXHbmIAkGkfXRmtj90sRCN9lpZ/KKPJiqfnU0rlomR5mcLoMJSk
qSc7JtHCPP8OBzxeVF+NZiVuFNmhV8cbDnu4/BnLCelJR/UeJNFvLxNKd2ybHFMh
A3f+KCe2jO9wzjsAGRQZj7ouyKv0rQqhrt/FB22V+9AldUKHVpDlIuVZZtNd/WEy
bqg/0O32bt5DSHPque6P4F/ZfRJGbewtqSWZVHrUiEKIYnftLN5grnIyKRZQ//8C
chN00FGEcg7xcbRhNBp3hG1x/EWyuXEXLpjPR//+SF9CGHds63PiZUuw6n9z8y5l
izQFS5kjtjFwCuSVyrjgXFGj8aBmn/UMoXwlR/Ph01ykUaSkEac=
=9cLc
-----END PGP SIGNATURE-----

--jx7yiFZVGspn49JSufos2ojBlnf00e2CO--
