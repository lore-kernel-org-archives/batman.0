Return-Path: <antonio@meshcoding.com>
Message-ID: <52E532D0.2000907@meshcoding.com>
Date: Sun, 26 Jan 2014 17:07:44 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net> <86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net> <52E08DFE.9030604@makrotopia.org>
 <52E5063E.3080408@makrotopia.org> <52E51A04.8020800@meshcoding.com>
 <52E5322D.60202@wirelesspt.net>
In-Reply-To: <52E5322D.60202@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bLnjTQrJTwwskIc94LhdGmB1jVlg0xTjT"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
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
--bLnjTQrJTwwskIc94LhdGmB1jVlg0xTjT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 26/01/14 17:05, cmsv wrote:
>=20
> Will this patch also be relevant to attitude adjustment ? The reason wh=
y
> i was if because with AA right now i do not experience the reboots.
> I should also add that i am using mac80211 r39150 and hostapd r39155 on=

> top of the latest AA.
>=20
> Can you explain in what exactly your code findings have an impact on ?

This is a patch to fix the memleak we were discussing about.
This bug appeared with and it is meant to be applied on
batman-adv-2014.0.0 (regardless of the openwrt revision).

Cheers,

--=20
Antonio Quartulli


--bLnjTQrJTwwskIc94LhdGmB1jVlg0xTjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS5TLUAAoJEEKTMo6mOh1VinQP/iKeINYmmXYL6g4w+rM12FJS
RTqR/uokcV6wBtvNjduelufFSHmVD+iGJmjX6yOOY7dBlsViycR1CcTsyU7rhvbp
Y5cfT8PUhqtC3lGeXZvpNSzz7NMO0ucwkEt6Oqx4gk+pbpZ2SiLn4cWq6Vqrzopy
G1iPxuZ17RthnusBZt91JWAPU+0bS4LYHJggAK2lO8Kv8XeEHz88aa5SiL+ClfiM
8/XZVL+ns5iCHm9jYCC/Cp7tKP2cXqReGk7JKaC6OUpm80B52mZEHjLF+JjOFtIB
aG2iAxJNIMONtE5VEisHuuCFbEsZO9bYYR3rcxEy2R1536mGcB40EZy9iHV9Cr7d
aNEu5sTzqST9LM+IyNXMs8TUOi7YQrN3NeHpidcyTFTvdLo5E90B9B9gPdPvRiR1
FMRoRf182QcFRtQRIcxhpDqNZjIP2joFdSMBH7LyBkzc6vQoQWlNeQu2cn1bJ2kR
s0/F8EoFxeuqNoQyna2X6cEaAXTMqcd69iCLoy5MVpkKcx/V4M6rK/LUpb0X70PR
0ag0r46cNxAMzXnZsiXkOkm+xGeZ5NzjAuSSt8iZI+choHT38d7zb6r6jn+pqQIC
55OaRDCCgJsk6lPRU69ym7DkhOpCh053+/+75v0ljS7R9h5iBccPpYGb0l3jRJja
Mdf5e5PN10anp4H1Q8zh
=tbFV
-----END PGP SIGNATURE-----

--bLnjTQrJTwwskIc94LhdGmB1jVlg0xTjT--
