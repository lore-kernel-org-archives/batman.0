Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 Nov 2015 15:33:24 +0800
Message-ID: <3383795.x2lQaIbbk7@voltaire>
In-Reply-To: <1446290970-24053-1-git-send-email-sven@narfation.org>
References: <1787438.NkeQ2a2MeO@sven-edge>
 <1446290970-24053-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7502484.s8oOWzWzr8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix kerneldoc of main
	functions
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

--nextPart7502484.s8oOWzWzr8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, October 31, 2015 12:29:29 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bitarray.c       | 12 +++++++++---
>  net/batman-adv/bitarray.h       | 11 +++++------
>  net/batman-adv/debugfs.c        |  6 ++++++
>  net/batman-adv/main.c           |  2 ++
>  net/batman-adv/main.h           |  4 ++++
>  net/batman-adv/originator.c     |  4 +++-
>  net/batman-adv/packet.h         |  6 ++++++
>  net/batman-adv/routing.c        |  7 ++++++-
>  net/batman-adv/send.c           |  5 ++++-
>  net/batman-adv/soft-interface.c |  2 ++
>  net/batman-adv/sysfs.c          |  1 +
>  11 files changed, 48 insertions(+), 12 deletions(-)

Applied in revision d7a21c1.

Thanks,
Marek

--nextPart7502484.s8oOWzWzr8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWSthEAAoJEFNVTo/uthzAE/0H/RBgr9xaWttO4mno/h+DoVjJ
zTxtJxOEqa5geQILIjoBvuJbtySPxLS+VqcaSe8BVc7i2Mulsm/M0Ot9C/ulSmOw
ZmUg1MflO4mrOyftdLehVHxAfK3UsnLSVK8C1JSpZ2Z1DZaf7f4o7e4tZSdfG312
AbpHZLiXQfCwLdQdYt7n0ZlyYRoVEB9kMed+nAXrcKyHeMZgNHRkHjVfG5fDV7Ua
oVS1TxGFZWe1tg0t0Z+lfFQpFCrm4TX5ivliHO7RsBhBI5SpU9zm3XN65xY8aq/T
XBSApSzn9k+ftiUrDnZeZA5aouuReQeDIRqg+vhtzvNvp9H6PM7zLKm7idxE7uk=
=PRNC
-----END PGP SIGNATURE-----

--nextPart7502484.s8oOWzWzr8--

