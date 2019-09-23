Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH trivial 1/2] net: Fix Kconfig indentation
Date: Mon, 23 Sep 2019 19:56:12 +0200
Message-ID: <2354684.0ZvKvX0iQ3@sven-edge>
In-Reply-To: <20190923155243.6997-1-krzk@kernel.org>
References: <20190923155243.6997-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2306317.z6aVZVsvuq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "David S. Miller" <davem@davemloft.net>, Michael Grzeschik <m.grzeschik@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Jiri Kosina <trivial@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, lvs-devel@vger.kernel.org, rds-devel@oss.oracle.com

--nextPart2306317.z6aVZVsvuq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 23 September 2019 17:52:42 CEST Krzysztof Kozlowski wrote:
> --- a/net/batman-adv/Kconfig
> +++ b/net/batman-adv/Kconfig
> @@ -12,11 +12,11 @@ config BATMAN_ADV
>         depends on NET
>         select LIBCRC32C
>         help
> -          B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
> -          a routing protocol for multi-hop ad-hoc mesh networks. The
> -          networks may be wired or wireless. See
> -          https://www.open-mesh.org/ for more information and user space
> -          tools.
> +         B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
> +         a routing protocol for multi-hop ad-hoc mesh networks. The
> +         networks may be wired or wireless. See
> +         https://www.open-mesh.org/ for more information and user space
> +         tools.
>  
>  config BATMAN_ADV_BATMAN_V
>         bool "B.A.T.M.A.N. V protocol"

Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart2306317.z6aVZVsvuq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl2JBzwACgkQXYcKB8Em
e0YTVg/+PgtfvbyO8UPeEG3nkvaRcMywQsGWWB2nkRfHXA+QnFghJNXsvPHonkd+
QQ1E5I3loiK90VFbdRR8R0o5G57WPTFAivY334UAL1m5qOZT1bMKwI971dT0GCny
a9+BhZEjt729e7WlSOvkT/v7BHo8lxyHH5+x33dxMJF0oSD5UDdH8VZX9PCBTJ1g
4+O3e18WyQdsXFi3G2N75DcT+OhRle2P7T6yfgD0Ro5ViMqeTigsdmw+kpq8x8IK
fyUN3oo5vqFnH3sEEXFshmxAqAVjPjzzoRYTFTupTw8yDOTL2REIgU75HZ0WP2w6
eQ03/+7hKhujukr4V/bwVPMf6WJ1mi9+cz88Op8BkY/UgFgAYJSUhnfeoLo1pK6q
ewEwagQfFibXUqtebAoam3z20Mb7rnrUmQJbUvPLQatL76qUaonJp3yxUMnrOWo+
GmDWR4zgHgwatjOBeGCPBuF3PBMPWe1NBrA0EF7+33gZu6pttf3Z6XLNUWCw3unx
xQCR1dn7VzUA+/FdFZfVoUlGBPeqWzqdyp3Os2ymDHJRp6jZWTd2gX6KvldvWTDR
dU2SmyvoOovNLFWyBd7rC7vud0aWMJUHypD2IlEMCPprnu+m33Lhqx8nrbF/goZL
drH0F1BJDs5jlWehfTwnnaNdqZEuzamWT8GEJAUBj8Iq5R6+35s=
=OS2O
-----END PGP SIGNATURE-----

--nextPart2306317.z6aVZVsvuq--



