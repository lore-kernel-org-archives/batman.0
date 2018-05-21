Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 May 2018 18:36:50 +0200
Message-ID: <8629384.6jJhJXCue2@sven-edge>
In-Reply-To: <20180518014754.23644-7-mareklindner@neomailbox.ch>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1970395.Ijo2mcNZ4K";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart1970395.Ijo2mcNZ4K
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Freitag, 18. Mai 2018 03:47:53 CEST Marek Lindner wrote:
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/bat_v_elp.c | 63 ++++++++++++++++++++++++++++++++++++--
>  net/batman-adv/bat_v_elp.h | 21 +++++++++++++
>  net/batman-adv/main.h      |  1 +
>  net/batman-adv/tp_meter.c  | 37 +++++++++++++++++-----
>  net/batman-adv/types.h     | 14 +++++++++
>  5 files changed, 126 insertions(+), 10 deletions(-)

This seems to create weird (as in incorrect) looking results. Here the ones=
=20
from Matthias Fritzsche:

[2018-05-21 18:19:41] <txt-file> ordexm, marec, ecsv_: Now I have one route=
r and the its neighbour with batman_V with tp-meter. https://paste.debian.n=
et/1025691/
[2018-05-21 18:24:28] <txt-file> ah =E2=80=A6 now "batctl n" shows a tp of =
16064.1
[2018-05-21 18:29:07] <ecsv_> uhm, isn't this rather... high
[2018-05-21 18:29:53] <txt-file> ecsv_: I think so. This node has an upload=
 of 4 MBit/s
[2018-05-21 18:30:34] <txt-file> now (6 minutes later) tq=3D2.2
[2018-05-21 18:30:48] <txt-file> which sounds much more realistic.

The setup is using an gluon based router (TP-Link TL-WDR3600 v1) [1] which=
=20
uses a vpn connection (fastd) to a server=20
(descartes.routers.chemnitz.freifunk.net) in the internet. The automatic=20
throughput test runs between these two devices.

Kind regards,
	Sven

[1] https://meshviewer.chemnitz.freifunk.net/#!v:m;n:c04a00e44be0
--nextPart1970395.Ijo2mcNZ4K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsC9aIACgkQXYcKB8Em
e0YcLxAAsyEGmHdaboaQ/teFxS3ZkywmMymTfWF90VZRvA9FpQl8HKf4Worp8rBQ
vwXQwRryxTfyBlKBX2dJ5Uuewi5V9ISHBmGRkJYgD7aH/hXf7x968JuWOdW+ICkp
xjrd1fyL4Jpj6Qj0FiFoMjL6kJ1rzWIjj4YBteYY7MQ94A9upKeYckInvIr3HHIS
+ZFXJ0zNZrPp6fHi/BTHA+grU6mVYl011buMiVuceW9eN6TZwlh18rlUU5YAV0Hn
j5mr6hOClwmqbdmxKPaJJwzwZ2V7exM331FfrXcwVDOsHso4wI5uqa4wIVsflBSO
j82qJuzw8wOTamIMVrjjnxqh2wZAkUKfKz2eCeHuvdGxsTZ5zlwjCTQcaCUbrClU
xCSlu9Q3+KSU3TvD4vIupBzdmQa5Tm4MdTCNAzIcKUBaOkt8ifDQGIY0Gt5GHML9
X4K0pwSlt2gLyQk/VuQs3wnaUebIJybcRpMAPFXB1jKWMNV/hmjUqLyu13WzjoCt
qwauqjVlzuXRnBqFwhOIaYZdJSLnOC0ZiOc9FtIhlzOtVJ/GMBTCHX2eOq/0qg3q
xLnA9lKzj04eUdr69+gaQDMkh/mHqn8sIVhTPYDBilpBxV5AhvtOXwhrZEvmIE9q
07kBmA9tA8hoC5VnRsX2GtGBcvbn4At7V1iq3Erw9AWp3pV4lrI=
=2LPt
-----END PGP SIGNATURE-----

--nextPart1970395.Ijo2mcNZ4K--



