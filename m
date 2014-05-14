Return-Path: <antonio@open-mesh.com>
Message-ID: <5373DCED.90209@open-mesh.com>
Date: Wed, 14 May 2014 23:15:25 +0200
From: Antonio Quartulli <antonio@open-mesh.com>
MIME-Version: 1.0
References: <1397484205-20905-1-git-send-email-antonio@meshcoding.com>	
 <1397484205-20905-7-git-send-email-antonio@meshcoding.com>
 <1398440818.4152.29.camel@jlt4.sipsolutions.net>
In-Reply-To: <1398440818.4152.29.camel@jlt4.sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BiBKvhn1MwhRKuMLxUV1VSdPaBI1cq5jn"
Subject: Re: [B.A.T.M.A.N.] [PATCH 7/7] cfg80211: implement
 cfg80211_get_station cfg80211 API
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
To: Johannes Berg <johannes@sipsolutions.net>, Antonio Quartulli <antonio@meshcoding.com>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BiBKvhn1MwhRKuMLxUV1VSdPaBI1cq5jn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 25/04/14 17:46, Johannes Berg wrote:
>=20
>> +	rdev =3D wiphy_to_dev(wdev->wiphy);
>=20
> That's _to_rdev() now.

Thanks, will fix that.

--=20
Antonio Quartulli


--BiBKvhn1MwhRKuMLxUV1VSdPaBI1cq5jn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTc9zxAAoJEEKTMo6mOh1VQegP/RQW53TDyxonlo3wUFGFZ8eT
DqE/3yjAv6jXy1aIq0xikeBlUMUCd5h1QnNj6NPhxuIRJkQeP+oahURcklva/UbX
6jLIe4+6j5JaBAs5m1xw0kf6ebue/zmLctRF5GIOqjeRf6EHK/J2oAw2Kw70qhZZ
JiS+4r7l5HnF62H2VReMIvR179GgVQ/Wzaz6D4UwMGbzh3VC9xufyOa/RBAS5HKP
ILzX0qQvz2chahWRXm5ltnRYJQcUkMWEl4Jb6gojYZDSewx5U9zTlPjl0wSfMhv8
oerUzSL45hjWiakDFeA72bhYXjbTePbWynH7BJGk648nFM+2QJpyscm2oj56m48g
2xPTU3wXGOYZhg62NQe6w/E5LriGpGVTPtz3VqNkFZroNzkmv/7EreGotNCjaDL3
RU2mlbkCMQoHx/krtG6IsCKWPUxzkwUOMZ5CzP41J2uo+o4OoNYdI6poSzyrO5TJ
Ztq4P+soNbWfSKGG5fhoTQWbgWb2CPraIqGX5moVxCQlOO3iPVzDmVUXq7Kl52aY
1pLtK/QXTZHjm7HuD/VqcJF83RaTDty4mdRljpl0tQyp+6VK5rrEV110y8630trk
7UvWK3vxwm/yTwr8MSUY7L5JQ5/V9FQ/cdIewzo0dKAIxSJJYklPSqyWFc2flCC7
DKUnBQiptwHNVilqgLH6
=AEvm
-----END PGP SIGNATURE-----

--BiBKvhn1MwhRKuMLxUV1VSdPaBI1cq5jn--
