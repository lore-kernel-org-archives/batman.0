Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:31:38 +0200
Message-ID: <2164425.2NJUHuNKIV@bentobox>
In-Reply-To: <20160920135917.24290-1-linus.luessing@c0d3.blue>
References: <20160920135917.24290-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2281211.jFTeEANukq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Allow selecting BATMAN V if CFG80211
	is not built
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2281211.jFTeEANukq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 15:59:17 CEST Linus L=FCssing wrote:
> With the new stub for cfg80211_get_station(), we can now build the
> BATMAN V protocol even with a kernel that was built without any
> wireless support.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat-include/net/cfg80211.h | 24 ++++++++++++++++++++++++
>  net/batman-adv/Kconfig        |  2 +-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>  create mode 100644 compat-include/net/cfg80211.h

Applied in aeb194c3a45fef9cc094e3509066bb2fa6627c05 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/aeb194c3a45fef9cc094e35=
09066bb2fa6627c05

--nextPart2281211.jFTeEANukq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBggaAAoJEF2HCgfBJntG3bkQAIcAAtrFr4NENqfnwEbBUmVz
90PV8yOdCgWuw9Sq2CIpubPVUl12RH2UxRUrCnuXmksGbLPoEz4Nc660Sk5s8jkf
71QXjSHN6cwSKBrgchbhxBFI3/uOyGyXz878Vf5YmeD/rQSz2/5KHssIqaub76ve
As6V2bKWG2kQAYOmAYGhVRvaZeIFPvdrKu+Kmt2LHjSqykVhDD2+B7uHyCAZODo0
NoGuNRfD8CFS/rGQTaOLfKSAo0FiT04Z8zpP4wceW8cVTbHlGzl1Sv53RxXEXeAH
0zhZ0M1JOzvYRinWYKIWwdeMiL1L455C1oRaHx7Byb7PaOZn+igR9C9T36mfEkZO
MEXRq7WdskdqzFGxUVlI2ojWtMqeBb1KPQsc76C4mAJEF8kjhWgUz15K+8RRZ/Ac
hBBjwWIRE+c7xJD2whvCYBMnYt7e5l0p6V1fLoIz5Zs4qEQht8fuMhpZv3T7THbC
mt09nR1Sf76zq68e5p625m9gL5QOOGBCKfIOrmRfdlNBMddsamrdU+DIuXOACrUu
PRE8pat+VbMzuHMQnGzPa7NE0YeGY5LSdGHwyHtleG7oiZpBIKt/oxet6jElQOOo
3/WOWzzo1TFrd27dleC8k2sf3iqBrmFLEa/kzfq0bcLGBs26/xAGfFlZ4/GhPYCP
qVG3/9GfJA7SZr+offXt
=2ctX
-----END PGP SIGNATURE-----

--nextPart2281211.jFTeEANukq--

