Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 18 Feb 2014 12:45:14 +0800
Message-ID: <2396808.4J5DmCeU4f@diderot>
In-Reply-To: <1392552062-17927-1-git-send-email-linus.luessing@web.de>
References: <1392552062-17927-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart99482334.BSddBFLDc3";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: fix null pointer
	exception for kernels < 3.9
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


--nextPart99482334.BSddBFLDc3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 16 February 2014 13:01:02 Linus L=FCssing wrote:
> The compat code of the new multicast patchset leads to null pointer
> derefernces for kernels 3.9 in netdev_master_upper_dev_get_rcu(). Thi=
s
> is because the initially NULL is assigned to upper, which is equal to=

> dev. dev is dereferenced one line later, though, leading to a crash.
>=20
> Fixing this by assigning NULL only when we are sure that the accordin=
g
> pointer is not going to be dereferenced anymore.
>=20
> Introduced by: 532cadf26cfbb1099ef31fae9ccafcbbfc37b9b5
> ("batman-adv: Multicast Listener Announcements via Translation Table"=
)
>=20
> Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  compat.h |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Applied in revision 65d8217.

Thanks,
Marek

--nextPart99482334.BSddBFLDc3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAuVeAAoJEFNVTo/uthzAttwH/AgMwndMiqV2wJnt+E+xYrc0
n7FI9evOzuYQju6OazHdVtFwRzpoFgkKaaVUVj0EehiFN/Drhryrklw5Xy754Zut
BXGBr8Poxr30/edrT1SZ0L5xY2KpRXP6UMyn0yOVmRJCO0n0UrBACJsEJnS8kb4g
DTWuYw40C4EMNVdalTdqhn1zjAi6vPEnFGZehjt66uoZuaw8W+YiBFvmMeaMyAqX
HifXeuxQ3rCRKDAX6dZ47Uaj1isAk4sLtwKOdjzd+x9+KjU6PYGrhKuHaMIJ07DF
GFg5Z8kj9vX31g5P+lm0zDr8q83pBPnZqFKK3Hzp/Ba2Uesp2JhK4gLFpGs7UT0=
=sFRn
-----END PGP SIGNATURE-----

--nextPart99482334.BSddBFLDc3--

