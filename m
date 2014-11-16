Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 13:40:26 +0800
Message-ID: <1840064.G6OQvTfxZn@diderot>
In-Reply-To: <1415719343-2989-1-git-send-email-martin@hundeboll.net>
References: <1415719343-2989-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1798054.LiSf4lT2I7";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix lock class for decoding
	hash in network-coding.c
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
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>


--nextPart1798054.LiSf4lT2I7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 11 November 2014 16:22:23 Martin Hundeb=F8ll wrote:
> batadv_has_set_lock_class() is called with the wrong hash table as fi=
rst
> argument (probably due to a copy-paste error), which leads to false
> positives when running with lockdep.
>=20
> Introduced-by: 612d2b4fe0a1ff2f8389462a6f8be34e54124c05
> ('batman-adv: network coding - save overheard and tx packets for deco=
ding')
>=20
> Signed-off-by: Martin Hundeb=F8ll <martin@hundeboll.net>
> ---
>  network-coding.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged in revision e7ba36c.

Thanks,
Marek

--nextPart1798054.LiSf4lT2I7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaDjNAAoJEFNVTo/uthzAiE0IAID+ULX7e8X7XDtV2fao44vW
xUG/GSLOsVKasCcMff/23eD8ve65IjNb6R73jWxzdgRyWIrjOCOkwod+KYdHN5Fs
T+4wfoxHE3nGywCAeexJdA9/qw9lqqzMBQxArrgaoEXFcTpqDoAyKaooo6Mjr5ym
cC8DwQ9SuVjl6AWUavQQ1CDNMK71jGxj6oVCSqgmzMDvhXqYKaBktOv25wAcybj5
kMhtBAmIb3VJJP3M95GpvlWDk72ZCqyst2mssmB6q0t/ndeSS2Q2c8mk/p1WuvuH
+0mFlWElIbWvxQJZKvtTxMNtuLHRmGVaYAlHubwF6lUy2UQWN5NOZBd5vJDecbI=
=GiX6
-----END PGP SIGNATURE-----

--nextPart1798054.LiSf4lT2I7--

