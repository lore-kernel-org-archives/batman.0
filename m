Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Mar 2016 13:08:31 +0100
Message-ID: <3424620.VtrxI3VZ5G@bentobox>
In-Reply-To: <OFE8016C97.82D26F0A-ONC1257F76.003FBD12-C1257F76.00416CB9@phoenixcontact.com>
References: <1456652670-18226-1-git-send-email-sven@narfation.org>
 <9978680.AHfZt94x15@voltaire>
 <OFE8016C97.82D26F0A-ONC1257F76.003FBD12-C1257F76.00416CB9@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2524602.Wmehs0XipQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: ELP - use new
	ethtool_link_get_ksettings API
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

--nextPart2524602.Wmehs0XipQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 14 March 2016 12:54:36 Andreas Pape wrote:
[...]
> This patch breaks compatibility with older kernels (2.6.32 in my case ;-).
> 
> Is this intended? If I try to compile this I get
> 
> ..../compat-include/linux/ethtool.h:49: error: implicit declaration of
> function '__ethtool_get_settings'
> 
> I stumbled across this when I tried to update and test my patches for dat
> and bla due to the feedback I received after I updated the master branch.

See https://patchwork.open-mesh.org/patch/15881/


Kind regards,
	Sven
--nextPart2524602.Wmehs0XipQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5qm/AAoJEF2HCgfBJntGjZAP/0k5W84TipGuLyrv+IrJLTLQ
nMS9yf8FmIFkn2yH+lT3AtP3kFpSaRMmt4oy1CpF8occPJA4CogVgAXWYSStoP4t
aeVFJUJWnFvzVweGrxmjrrI9Zd4Vk7ma3NuQ3ABK/P7d0WQKZWBLh5veaPqh/OlN
zSYbhxRP2+ADhgUAL/yBRxJzvRmgqgTcblA20dUAKor/n+eaexZttJl+I9P8lf0A
50IC8TShf1qrnO0Bw/MNrd53/GZuO8IL5XAGD2YvZqnu9OAFyqihEeI3B3HNTUx2
UiXmZE7Hw9N9ISwsvYEo1i7lSrr18GPoig/VydK9X5W06AGBQ/P2vZmCZE3gpwcO
5fMQiute51jKrg9Q5RSI9c919b9g3we8xS/U+xET5gmLZN4bwFYo0FAl2qo3vlZj
T6e9vSIabD9VmlmhYmzoUaqlvvwN1HRLEL3sQ7//DUKrN7pCrNGsscqEXaOV7nh4
3967fjoTDqqnNF6fWvL1wns2Cul9PL91/cnFVOViFTIFZFaOsbDEazFvWjtFL5m/
aaHb7iPl1YIqvfICNrPLkcIp+qqC4iB9LRvOrsGbYzfocpMQrsvjYx1pYwtzKbWy
6JNFWBtYYoTtlNFwJssi2ltQbWpH5dgc0rkvJHk1qva3xj9g+dWA33OTMTY3TS8S
zxo5JvnXKVejs+kbociy
=V5sA
-----END PGP SIGNATURE-----

--nextPart2524602.Wmehs0XipQ--

