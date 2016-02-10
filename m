Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 10 Feb 2016 18:22:46 +0800
Message-ID: <17331368.yIBrKbZIZt@voltaire>
In-Reply-To: <1454308474-23211-3-git-send-email-mareklindner@neomailbox.ch>
References: <1454308474-23211-1-git-send-email-mareklindner@neomailbox.ch>
 <1454308474-23211-3-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3941454.Kqo2UUSjtu";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 3/3] batman-adv: fix misleading
	default throughput warning
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart3941454.Kqo2UUSjtu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 01, 2016 14:34:34 Marek Lindner wrote:
> BATADV_THROUGHPUT_DEFAULT_VALUE is expressed in multiples of 100kbps. Make
> sure the warning text converts it properly.
> 
> Fixes: 5c324517 ("ELP - compute the metric based on the estimated
> throughput")
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/bat_v_elp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied in revision 41d1e61.

Regards,
Marek

--nextPart3941454.Kqo2UUSjtu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWuw92AAoJEFNVTo/uthzApYAIAMBlCbrNZ2GYpd4I75nq1g0X
0wvs3g0f/XksEwg8VKAF0aA2utytSUqYbvQy3cRxjB82v3Ra3hsg26KEI4UItKsp
n7fpr7WCykjsdgvwli2UK3XanBI35Bi4odSeSMxccHoipAI3hOAo7hJrx3YiUFDo
y211/AmmHB2BT34BxocDipQnDR1KleLxxJ2DUBZcMD6nLF3LdgAl3FS/C0WbT39O
lSEIlLlwtdkGeca1eZvMjMApm7h+cJAe6GhvGOt9jVMcP6kEOPFrE61XVgn/466x
JUz9Pt06sqw9K+LLj0g3kkwTgX3uuTaa9EH3ma9gKpRwK4APRDOh94ok0UT9p6M=
=9kL+
-----END PGP SIGNATURE-----

--nextPart3941454.Kqo2UUSjtu--

