Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 Jul 2016 13:58:15 +0200
Message-ID: <7898765.RLjox62xtH@bentobox>
In-Reply-To: <1468314486-29592-1-git-send-email-mareklindner@neomailbox.ch>
References: <1468314486-29592-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2894949.hLBRlSkAGD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: refactor wifi interface
	detection
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

--nextPart2894949.hLBRlSkAGD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 12. Juli 2016 17:08:04 CEST Marek Lindner wrote:
> The ELP protocol requires cfg80211 to auto-detect the WiFi througput
> to a given neighbor. Use batadv_is_cfg80211_netdev() to determine
> whether or not an interface is eligible.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/bat_v_elp.c      | 29 ++++++++++++++---------------
>  net/batman-adv/hard-interface.c | 26 +++++++++++++++++++++-----
>  net/batman-adv/hard-interface.h |  1 +
>  3 files changed, 36 insertions(+), 20 deletions(-)

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart2894949.hLBRlSkAGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXhNtXAAoJEF2HCgfBJntG7K8P/3DjrAZblgbUFpHgZiaIgMf3
pBgKkRwyIiD3X67dUyFcSKwG9IbJFsePWfg/AKTC3x1izS6LDgPY9EUfmFxg8Swa
Z0BimhO3KzqNqLK7PF/Y0uoUnJxE80HMGzcPQ+hwZtSfkI2pYX6I99FErHCE9UTB
ROmi+1bCM4kfvFoZ5k1+m/nelkq/Gy6vWyM4fKwrN75w6/dRG5moaQR4WFR4t7BI
U6IsgTpS9xLifJxDg+Q2m3uoL6wqaQnaoa1DT6smlidbDDPCqtbIDmT8Z86UA85f
jlNXV1p8QmjdlFO5kfOeyARHMn33P/EEhIMoNsm6zQDpQeejAdtSbnfVxxnOCpPt
aYDPkCwvDG/NEYsEdEm6RdJCUuawz2fwmPRpy/uH8Lyv7J/p0cnjHh6NcEqHUMG9
ZOeC0rPJCcT9XoV2WNH5D93P2TSHzEQnEuz0YO/KEQW0h7W37HQfL6KQm5YfybgI
zpnZQWluyXUYXQ3sBqtMjQkhQ+jAU81drRUPQ9srIT2uG9dBj0EPMgxl8+mP2/ht
gPIJtib/FS3Xh58HchIYUspWJ1vyUw9/aSdaLZsG9XKX0O62aFuywKa39mlOXAj3
5eEbLDDivGX0Ik22OEsU+MSoJr/rmpJAFFoekKZypl8xiIe7eUBSr4IzpS36BL3g
9oHJ0DIM/mrHLbGqwsBR
=KsWR
-----END PGP SIGNATURE-----

--nextPart2894949.hLBRlSkAGD--

