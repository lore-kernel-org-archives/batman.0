Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 May 2016 23:22:46 +0800
Message-ID: <2305430.23xWrhkkD4@voltaire>
In-Reply-To: <1462898487-9696-5-git-send-email-linus.luessing@c0d3.blue>
References: <1462898487-9696-1-git-send-email-linus.luessing@c0d3.blue>
 <1462898487-9696-5-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3791716.1ASpjSFOUb";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv15 4/4] batman-adv: Add debugfs table for
	mcast flags
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

--nextPart3791716.1ASpjSFOUb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, May 10, 2016 18:41:27 Linus L=FCssing wrote:
> This patch adds a debugfs table with originators and their according
> multicast flags to help users figure out why multicast optimizations
> might be enabled or disabled for them.
>=20
> Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/debugfs.c   |   23 ++++++++++
>  net/batman-adv/multicast.c |  104
> ++++++++++++++++++++++++++++++++++++++++++++ net/batman-adv/multicast=
.h
> |    3 ++
>  3 files changed, 130 insertions(+)

Applied in revision f1f0fbb.

Thanks,
Marek

--nextPart3791716.1ASpjSFOUb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXNJ/GAAoJEFNVTo/uthzAPEQH/2F31UxeWJHzy6sldeyz3Hq4
idHB1udp65520jeilWblD9/heHT1MW1QBhHJs3GaSLyfm0FqkaLkboZng+Q6WD0S
+67Rj7TK/e6QrLLIDDpHxnz37YACjhsWR87E0U3wk34nml8/fK3IimhHzr19mBhP
GZfzsEszOmINQYZUsru4+mNAjn6xG9pO/zvUc0ZFQ204bnPDhmKfO/xJzj58EsP6
0cesfJBrQ8RAFUaIVFqBAvqbn2lePZm83lbCbSpwOLtMQjPrysQPhqUjJDJgsXSC
0J7zhIkjNPFgaiWJg27A8ESjvdqlwEue2oS8ikrIPwxqYzjAr7Ut6JBvwr7zNNU=
=ANx7
-----END PGP SIGNATURE-----

--nextPart3791716.1ASpjSFOUb--

