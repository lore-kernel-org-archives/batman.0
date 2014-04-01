Return-Path: <antonio@meshcoding.com>
Message-ID: <533AAC6C.80302@meshcoding.com>
Date: Tue, 01 Apr 2014 14:09:16 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <5339CBBD.9050708@sns.it> <web-133442820@sns.it>
 <1732522.mMifORosKp@vaio-gio>
In-Reply-To: <1732522.mMifORosKp@vaio-gio>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="37HSLL0r5CfqTLDJQxAIndgCiQF7QvHaU"
Subject: Re: [B.A.T.M.A.N.] br-lan: received packet on bat0 with own address
 as source address
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
--37HSLL0r5CfqTLDJQxAIndgCiQF7QvHaU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/04/14 12:35, Gioacchino Mazzurco wrote:
> On Tuesday 01 April 2014 11:33:01 Ilario GELMETTI wrote:
>> I tried changing the mac address
>> config interface 'lm_eth0_batadv'
>>         option ifname 'eth0.11'
>>         option proto 'batadv'
>>         option mesh 'bat0'
>>         option mtu '1496'
>>         option macaddr 'dc:9f:db:31:c1:38'
>> and that error in dmesg went away.
>=20
> Why a packet form eth0.11 should arrive periodically to the bridge ?
> Someone can make some sense out of this ?
>=20

I guess that the packet hits the bridge before being de-multiplexed by
the vlan code (or both the paths are followed till a certain point?).
We should dig into the bridge/vlan code to better understand what is
going on..

Cheers,

--=20
Antonio Quartulli


--37HSLL0r5CfqTLDJQxAIndgCiQF7QvHaU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTOqx3AAoJEEKTMo6mOh1Vip8P/RPOLv9HST1Cwt4dbw7joamt
uQCtC4BKgGAC131b2bsmYKjFpBniaVatbt4YC70wvNM4e4WOSEY5FfkeDaRi/MX+
1fRMwcjw0sthaqtlDl+wmIYTC0EYbAMbNwJb8D3Gv4Ddowze+yRAq6xnWwO5sYO4
izzZV8qQhXTp30agTmFoWuGYjhXqzV/5a6Ml3ZjMik6v76GLy+Y60u7xZBO1qTV4
o/pmHojWp6esuDgixbJODTPhtQCha94B0tohLlOkAQqplaIMN067xfFdW9sILSgc
XZ3He4MsEUVt504wtr0JOKYM5Fb2MIQzFDTqWnakmlGsD6HUlpyj2BPXzB4VD1gq
ka5dYh7E1TT+yJwcih5buEkUYKq+PFJGEXOBeFKfmmcult2XqA6pM73J80bDxKHE
w03WA9clvf4S74mIQbZwp33fBCk9Xv3FcnVee2RtNben8ReywBolzt2OWySoV9EY
83ECV4L+97lNYdSt6JrdlW4ZOBTChVClZ0ebti4QccnV61AQqCI/a7rXGh5u0y3c
sNszGbRYZy0LfHni6Vk/e7Wm+CLgIaoS6iqWA6+4N+HJe/X4zMzM5gXX8aSQqzhT
ZLY9oSaoI4Iv+zyM0JDUHnq/GJ0XUk/aUiK8LYYZnt/R2ZU4y+GfS5yMU4jDIOlB
ZF77a89Wrr/mgk510xRj
=uAfj
-----END PGP SIGNATURE-----

--37HSLL0r5CfqTLDJQxAIndgCiQF7QvHaU--
