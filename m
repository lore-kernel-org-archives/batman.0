Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Jan 2019 10:07:02 +0100
Message-ID: <2950323.HpkOYXhreU@sven-edge>
In-Reply-To: <20190119061422.32335-1-linus.luessing@c0d3.blue>
References: <20190119061422.32335-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart32935768.MIEstAOJOn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add multicast-to-unicast
 support for multiple targets
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, David Bauer <mail@david-bauer.net>, jiri@mellanox.com

--nextPart32935768.MIEstAOJOn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday, 19 January 2019 07.14.22 CET Linus L=FCssing wrote:
[...]
> This patch introduces a new sysfs parameter even though upstream has
> signalized that we should switch to / add netlink support for
> configuration.
>=20
> If upstream were to complain about yet another sysfs-only parameter, I'd
> argue that netlink config support is advancing but needs a bit more
> discussion and maturing. And it has no advantage to halt progress in
> other directions for that.

No. Either we use switch to netlink or we add more sysfs configuration file=
s.=20
But not both.

I see absolute no reason to say that this patch is a special emergency.

Kind regards,
	Sven

--nextPart32935768.MIEstAOJOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxC6LYACgkQXYcKB8Em
e0bCWA//X7jAeBlOJeGnQNV+W2UyjL3Tuts9MgyJGm9U8NVAzEXuHV1Bs9LJJMBj
ddV1hlDsxPUVhgp1PtRlTwWBE6IfrykwSDvWKZ6W2xaKwRz+zlvaRGtruP3I5vuP
CGQYg17tNNaoQfMomSCOEKWavza5eYtyDaYKqpQEGiVY344LMLGBlgaxqOUaBIHA
arWqd69zzzEKAI6wZmlf8CU9+QGQHEWT3X/n5Ue1cxO1U2uEN5ESYrPfT5reBuTE
HANQ3u+Sd/7HK6KYBMna1zIjDq/3GuXXo26hpo8WfLRUx+FK+KNzOYQFS3LtqMmy
yULYPWeUxk23P5NsOS0Lm7rKuoRetJPlIj7gmKy6v37nStfgbAiQLsEl5m6nNk+Y
tDW5x2iCFDCZArotDOhr3H1Ye2MWJ6+ZyZVsSn82ZeCzJ0+g3/qacbygyeFp3caN
xfsVVRWPOoqmDqPHdh0Yp1V1gogDZQoFlapGqSBsfC+dm7nXbzIfTrKkKYpRyRZl
16yrR1YBtXG7xOpvNO6KRn0g35BZvxlu9+j2vQfb9vR+TD1kmcsXufdyCGYw//8u
kD/7Fel0RrFcIhOHIKb6IBmm95vTH1q1CFA5zuxNfGF/Ai8XhU0XFNyMMmyU1EKW
8UyaQCy0gECAMDX0y7hc2lOGSBKxgYxheghep6A5FpUGQf1O0QQ=
=yM9k
-----END PGP SIGNATURE-----

--nextPart32935768.MIEstAOJOn--



