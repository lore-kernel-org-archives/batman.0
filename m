Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Feb 2016 12:38:13 +0800
Message-ID: <2465891.8WB3Uyx6em@voltaire>
In-Reply-To: <1455616027-22089-1-git-send-email-sven@open-mesh.com>
References: <1455616027-22089-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2851753.YHBtyvCbeq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix integer overflow in
	batadv_iv_ogm_calc_tq
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart2851753.YHBtyvCbeq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, February 16, 2016 10:47:07 Sven Eckelmann wrote:
> From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> The undefined behavior sanatizer detected an signed integer overflow in a
> setup with near perfect link quality
> 
>     UBSAN: Undefined behaviour in net/batman-adv/bat_iv_ogm.c:1246:25
>     signed integer overflow:
>     8713350 * 255 cannot be represented in type 'int'
> 
> The problems happens because the calculation of mixed unsigned and signed
> integers resulted in an integer multiplication.
> 
>       batadv_ogm_packet::tq (u8 255)
>     * tq_own (u8 255)
>     * tq_asym_penalty (int 134; max 255)
>     * tq_iface_penalty (int 255; max 255)
> 
> The tq_iface_penalty, tq_asym_penalty and inv_asym_penalty can just be
> changed to unsigned int because they are not expected to become negative.
> 
> Fixes: 46e44fdb96ef ("batman-adv: add WiFi penalty")
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
>  net/batman-adv/bat_iv_ogm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied in revision 789b846.

Thanks,
Marek

--nextPart2851753.YHBtyvCbeq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW0nm1AAoJEFNVTo/uthzAaKsH/jnO3O0dD2W3vuQBvyZz+1C1
6C6uQbqqkAiA1wA4PAOpAROyFLY4DfN+q4F7OwChbNC6HaGoUHWhO+aXFYeK00N/
FIHwjHiE62Igq5M5s7wHwyQEfbkNcNSw8YVkc68atItI8N4E+30sAvioKeO9fy8/
8aAuAcAf2uiVDJwNWWkYeQZczMyvYcQNVhdqpIW8PF7qzoRggdPaSUx0py7oxKXS
+nJfkFhihLsxa/gxrELOlIq37L9XZq8lkBH2J2puVOseRSYjKNYFuyWGnB7Ud/iS
XwXS3MDwkn3w8Fa5wK3A7tOQeNJNSpmYSZmWs62GPZR9x8mU4QXUMXYfOW9gdLQ=
=KTJd
-----END PGP SIGNATURE-----

--nextPart2851753.YHBtyvCbeq--

