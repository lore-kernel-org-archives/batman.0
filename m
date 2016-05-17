Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 May 2016 17:24:19 +0800
Message-ID: <3762391.2eZSvXGPdB@voltaire>
In-Reply-To: <1463157342-13195-2-git-send-email-linus.luessing@c0d3.blue>
References: <1463157342-13195-1-git-send-email-linus.luessing@c0d3.blue>
 <1463157342-13195-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2143234.i7LPl3jjH1";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix mcast_flags debugfs
	output
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

--nextPart2143234.i7LPl3jjH1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, May 13, 2016 18:35:41 Linus L=FCssing wrote:
> We recently switched to the atomic variants set_bit() / clear_bit()
> / test_bit() for originator capabilities.
>=20
> Unfortunately, this was missed for the new multicast debugfs
> entry, resulting in an empty multicast flags table.
>=20
> Fixing this by using test_bit().
>=20
> Fixes: f1f0fbb2c956 ("batman-adv: Add debugfs table for mcast flags")=

> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied in revision 8151e97.

Thanks,
Marek

--nextPart2143234.i7LPl3jjH1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXOuNDAAoJEFNVTo/uthzAwUEIAJ1Nq59qhQHgxYJwcQqllpZp
HXYk8LA9bFzoHSHEbnydxbFUggEjPcvWN9/gEG0z5SkC+RcVaO02zOprQTc+7bJ7
0JPDNjdpUmM5ilKKiCMeikVrlL0mAwRf1bep/v+0vSpLxWJwcqZq1kX6ivDYCuJt
QF+4VGo5JsI+oj+9mhXrYgs3Bnkga9S8vwPOD4cCAOrpzwlP5JV2Kcp8ycXzh4kN
G83HLtyplsb2nlneClsPFP8rAlhrTjvg/azBVO5kVJ1hsskrbMa9wdQTi3ribxCN
1h5ntDtyCFNH5Vw1K0/Kd/HR5JoEW295jd57UVt25QQsLm5bhiEJxM1FCbeq+m8=
=mGqf
-----END PGP SIGNATURE-----

--nextPart2143234.i7LPl3jjH1--

