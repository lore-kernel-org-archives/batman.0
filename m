Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 14 Feb 2019 15:04:54 +0100
Message-ID: <11497659.iQavgr9jVl@bentobox>
In-Reply-To: <20190214134452.GA1602@otheros>
References: <20190214124301.6222-1-linus.luessing@c0d3.blue>
 <1687264.beubBEU3KB@bentobox> <20190214134452.GA1602@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3392283.QXiKtGg81k";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add multicast-to-unicast
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
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, David Bauer <mail@david-bauer.net>, Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org

--nextPart3392283.QXiKtGg81k
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, 14 February 2019 14:44:52 CET Linus L=FCssing wrote:
[...]
> > No new sysfs config files.
>=20
> Why? The bridge for instance does the same.

https://patchwork.open-mesh.org/patch/16763/ - here the quote

On Samstag, 29. Oktober 2016 12:33:01 CEST Jiri Pirko wrote:
> I strongly believe it is a huge mistake to use sysfs for things like
> this. This should be done via generic netlink api.

We don't need to configuration interfaces - we only need the preferred one.=
 If=20
this is sysfs for you guys then we should not have started with generic=20
netlink at all. And why wasn't this brought up now *after* the stuff was=20
merged by David. It isn't the first time that I've stated clearly that ther=
e=20
should be no new sysfs configuration files when we switch to genl.

If it now preferred to have sysfs again for configuration then please discu=
ss=20
it with the netdev folks and find out how the new generic netlink interface=
=20
can be removed again before the next release.

Kind regards,
	Sven
--nextPart3392283.QXiKtGg81k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxldYYACgkQXYcKB8Em
e0Zk1xAAqJLplDVLvZZi0wF9GAcTX8bx52NRRJlNWaPxg47sbj2ZkGpwwczw6ScJ
yRv3LNZ4d5FmT4XXZKuNY8vUsptFbd+mGb7bszkEz+2APw3K28YQhW/im+23j2Ij
9FXqcQxIOvvuSzg4K31b7lRv6SwNtrEwns762gh7rG/EvyrOUeMNFE5NSnxMtf8N
kZidaryiCmFrZKAizQrsKQIf9KNQ8IbRxtPxNJDBMi9YDVI0Z3yCd9Y69X1bGYqw
ZRZhhetHHaVfk2GGa+rbvxJkXyQXFuZIgGwudF1d0ptAyDYBB2G6VIjTxbZgA6Hh
Isu/BkVlBbFKjCx4pItzRfTk+qkDNDNQEVOzdqhHZHwu4iYui0+jENtdJpY33Ywf
56FfQU206Ydp8X5VEyckQXnKLaWPiONJRUzEp3IuXXDdbi7pIZuLF0zoxUuXT4Ya
ar5r1LZVASrF0Ruslvdhk/86yY3mUVnZ+gJ42LkJntBb/CzWPo9uhuGrE0cHIPag
TDpY4tGHU5ROa2kG0pAGXH/xOTaaHSS27FFV6VaB4SLjg1r4OQcHcV9uTgHg7X/E
K49yCMdxnX0EfL9z6tyzoABReJlmfErTPmNApUF6lXr26JU9Nf3uLsXy+25QXoHd
FNdvWwO9JX7DiJ1pn88oIdP7XLedJAbFFHcToo93jgXn4t/ZjBA=
=ehEm
-----END PGP SIGNATURE-----

--nextPart3392283.QXiKtGg81k--



