Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Oct 2016 08:35:40 +0100
Message-ID: <1637163.TC9CcXIrIP@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3120250.DSUSTJpM4J";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/6] batman-adv: Revert coccinelle compat
	support
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

--nextPart3120250.DSUSTJpM4J
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

it seems that the coccinelle package in Debian Jessie is not able to parse
semantic patches [1]. This basically breaks the batman-adv build on many
stable systems and thus makes the out-of-tree module unusable on these
systems.

I have currently no better idea than reverting these patches.

Kind regards,
	Sven

PS: Linus, do you want to try to get rid of replacement.sh?

[1] https://www.open-mesh.org/issues/303

--nextPart3120250.DSUSTJpM4J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYFvRMAAoJEF2HCgfBJntG4dwP+wV6/kYZh1P3RWZ7UDU0KxiG
99b7GWxvCQKrK41+qRp40lVXQQj/4PcpKrjFysTA4EdmxWTRLqS6K5HnxTtzFwvb
340kjYYD3l+VN5wG2hoB9QM6tIvYpQ2onfiPk5pU+JgyLpbGR2hpZ8ABj0i4a7Z4
Q3MZXfs0nZ3LgFBJH3lX2VoEEpNpmUxACJ6sMIM+2hw0Y1HcTL3qjnl5iPgc4eed
IMYLaCK6I02FFy7jAQImHCye6USIOkaz9lNm4IgiGYWrrSG1cLtDazhpfw819CMr
GULCTCjvpc45WeU21li6WpAPo84C+MH7ChvJwGaAdHMHJibYbTDZI8NwfcRlTCmb
aPKAvZz5SO6VgMuZ/sKmOcGzfkvkNmYLZFZ7W9fBkd0qE4okZKfm65mT4C9bHrRV
Hm9JOTkIdSa2K44pdwQrXpEB+xNCuwELopk661b8qwtdTmNdJHK2R8JTiGwpLN6s
0410wVgh9pnB1oYY8wJc7Q8IapdQaJ1S/jUq8DqELbbCaBtl3oqH0hm/RX6wikEW
PwRVa7yYFo7HS1IuoF71Ck21vJlrKah/zDpt2OQWYCLK/IrDvEEn0KDDyOzfE2a/
S8uqejSO/8hINPMp2PpLbldcsASWDC3BIFypC0mTKnlpnPLXWST3//xumxqDj/sa
NafISOvQZZntziLImu2h
=AUqa
-----END PGP SIGNATURE-----

--nextPart3120250.DSUSTJpM4J--

