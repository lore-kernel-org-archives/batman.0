Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Apr 2016 21:04:41 +0800
Message-ID: <4234386.Ftqvtf5DcC@voltaire>
In-Reply-To: <1460372800-26049-1-git-send-email-sven@narfation.org>
References: <1460372800-26049-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2493516.5g4QqtNQv7";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Use kref_get for
	hard_iface subfunctions
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

--nextPart2493516.5g4QqtNQv7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, April 11, 2016 13:06:40 Sven Eckelmann wrote:
> The callers of the functions using batadv_hard_iface objects already make
> sure that they hold a valid reference. The subfunctions don't have
> to check whether the reference counter is > 0 because this was checked by
> the callers.
> 
> The kref_get function instead WARNs (with debug information) when the
> reference counter would still be 0. This makes a bug in batman-adv better
> visible because kref_get_unless_zero would have ignored this problem.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - Fix imbalance in batadv_iv_ogm_aggregate_new
>  - Adjust commit message
> 
>  net/batman-adv/bat_iv_ogm.c     | 14 +++-----------
>  net/batman-adv/hard-interface.c |  7 +++----
>  net/batman-adv/originator.c     | 30 +++++++-----------------------
>  3 files changed, 13 insertions(+), 38 deletions(-)

Applied in revision 04614cb.

Thanks,
Marek

--nextPart2493516.5g4QqtNQv7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC6DpAAoJEFNVTo/uthzAKZQH/RIvERPYMPD1Q+1PzNpwr1hY
gjV6tK1GQgIWx3hNZjCScEmuBvPhNdTpJcpvokGj5Ps/sR25H5fSAhDc8hivNGbo
LebujB4QaU0C5J+9Z9hliD7oxcX2tVChpuM8ef0OwIJWY89Ia5P6DKeyPF+xNjOa
k+biN+s1b7//v3vSL0PtO7fzU80Nc4wE8evIYySTNceL7mnocGjQkWKhrhuj83pG
bHAlwsccnGv+CwY0egkfq0QVXpIyVYCquiKiOWH797QgdTZf4Qy9UzG1TJcUGU/O
A3xM4yU1el3++gzbBt7/D4s/zsArzxt2R/BrobewhpERuOdPmkHgv4CR95tTMfI=
=XZr9
-----END PGP SIGNATURE-----

--nextPart2493516.5g4QqtNQv7--

