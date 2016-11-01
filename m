Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 08:31:40 +0100
Message-ID: <11639897.EMEoDdmWnt@bentobox>
In-Reply-To: <20161031072719.26286-1-sven@narfation.org>
References: <20161031072719.26286-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3642574.lujKKlmdNi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [maint, v3] batman-adv: Install module in
	$INSTALL_MOD_DIR/updates/net/batman-adv
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

--nextPart3642574.lujKKlmdNi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 31. Oktober 2016 08:27:19 CET Sven Eckelmann wrote:
> depmod may skip the batman-adv.ko module in the $INSTALL_MOD_DIR/update/
> folder when it contains the word "build" as directory name.
> 
> Avoid this extra directory "build" in the installation path by making the
> obj-y dir relative to build/ in the source directory.
> 
> Reported-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
> Fixes: 66ac14a09445 ("batman-adv: Introduce compat-patches support")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Tested-by: Martin Weinelt <martin@darmstadt.freifunk.net>
> ---
> v3:
>  - adjust commit message
> v2:
>  - Remove clean target change which was accidentally added to this patch
> 
>  Makefile | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Applied in 22c08574065743dd31d1359fa82c83d0c74984d4 [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/22c08574065743dd31d1359fa82c83d0c74984d4
--nextPart3642574.lujKKlmdNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGETcAAoJEF2HCgfBJntGNTsQAJ/eZmPOGQywWs5fQJeakwyx
edLDoXyh47xzBAs4NPrMqD2fZ0/1b3RGdVVlkXr8uevvRSfDcSSVQ+4v3HuDuNKE
feZXW15NIaDBS87MEcstdCF87d/ZWVqThhYm32xc0jyj1iYlIGM1cz30JnaDuTP0
hw0qs2CLdOI8AIGoaSauGf2bJjKAM8vLuqxTts19mE1tAU08Pk8HFlQKF1Zw+6Jm
gI+UmO7ZRM7oHBc0R2ILrje8EBI9Kcu8iv9dBSNFMNxh99wWVv9SZoRtoJzLWC4u
uVtBHijMbllabRVJ1ArPLDHFxrUKOqtou0irfPH126Aj9OfQS4K365uCleKYW0Nk
0DC18IssjopTU0JudZYI1dtng390qxyOGZdfoDq6j/nQfcm5vg6ipPihn6u9Pg4l
lYtQsNg+XP69DKVHQV44XwOd9lgzPaJe+KUzCOVrm9LAqPU83ZvPu3kBhYWXqs9W
l1lRSHDd1+wzbMZZRqzlV9CbFmUOwyrthGfgzm2kCXsZgF7O3h+5sANBgzGJTcB2
OElVbbO315g73xI6Xf1GacmjcFQRFj4bYxUJXRK3TFbEF9jNO/BMTLzjv+IIbE9p
h/B9JyzzH/66EzBNpDGDOg9jpJSJeKJDu/mTZKHZfHBUwAsPD6cVxmTbJ26EwhiY
keNg1MFwH483rAnmm9PT
=CTO/
-----END PGP SIGNATURE-----

--nextPart3642574.lujKKlmdNi--

