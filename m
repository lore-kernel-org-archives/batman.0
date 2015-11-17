Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 Nov 2015 16:06:59 +0800
Message-ID: <6295766.E4lI2BmnDx@voltaire>
In-Reply-To: <1447103060-8960-1-git-send-email-sven@narfation.org>
References: <1447103060-8960-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1533220.6uxvslpeQy";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add function to convert
	string to batadv throughput
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
Cc: Sven Eckelmann <sven@open-mesh.com>

--nextPart1533220.6uxvslpeQy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 09, 2015 22:04:20 Sven Eckelmann wrote:
> From: Sven Eckelmann <sven@open-mesh.com>
> 
> The code to convert the throughput information from a string to the
> batman-adv internal (100Kibit/s) representation is duplicated in
> batadv_parse_gw_bandwidth. Move this functionality to its own function
> batadv_parse_throughput to reduce the code complexity.
> 
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> ---
> v2: add kerneldoc for description
> 
>  net/batman-adv/gateway_common.c | 117
> +++++++++++++++++----------------------- 1 file changed, 49 insertions(+),
> 68 deletions(-)

Applied in revision 348a5da.

Thanks,
Marek

--nextPart1533220.6uxvslpeQy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWSuAjAAoJEFNVTo/uthzA3nsIALXypIqxLlpq1a+bArgDsYIw
uuMRWue65EUGwlH1BoSEbn/d/gJ3eZjesbYToNkuNhG7zt1/ePKtuQrzm+eUlEb8
yDfaopa/L9ZZ7r4I5kceSIxZghb77HiWKseq7hDH7dnTWJ2M2yTbfv6xc4Td8A7g
EXfTPoT2bWZJo/QX4GOFJW79d5LJyuMwW306h6g/+X2VlHMkLnTJO7xJa/quil2C
1mi08HkqVfZk1pvHpLEqN6aJ9eUrekYVhHAGI/t4g5y3eNv4GCj4+PgN2xfHg7/o
Yr98E6fUR5CIe+sKa3uMgTosqWH09mdUou4/aAKMS/vRhFeWM2K8H63t9n+NHMA=
=FTQv
-----END PGP SIGNATURE-----

--nextPart1533220.6uxvslpeQy--

