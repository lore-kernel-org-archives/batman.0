Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 09 Mar 2015 08:31:11 +0800
Message-ID: <9025446.ZzMPtjaoT0@voltaire>
In-Reply-To: <1425225386-19712-1-git-send-email-sven@narfation.org>
References: <1425225386-19712-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2264280.1yy8AgoFOL";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unnecessary check for
	orig_ifinfo == NULL
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart2264280.1yy8AgoFOL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 01, 2015 16:56:26 Sven Eckelmann wrote:
> orig_ifinfo is dereferenced multiple times in batadv_iv_ogm_update_seqnos
> before the check for NULL is done. The function also exists at the beginning
> when orig_ifinfo would have been NULL. This makes the check at the end
> unnecessary and only confuses the reader/code analyzers.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_iv_ogm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied in revision 8435e41.

Thanks,
Marek

--nextPart2264280.1yy8AgoFOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU/OnPAAoJEFNVTo/uthzAZLYIAIIIPRNhhuCQRJUYzlKBHcmJ
9M5Bis58e7rkelzEGSpfALwel0WiAP3nSrZYSf3nBpUP16FJOK+rSUF43Tf96fNA
+1y5ophjf3Ql0CnP6+6OD9Y8AicgBBIFjFVwEyDW9SmcR6ih7usKhbYW4QRDBByH
NDdKZIqkyxYilMSVDg8A2Y7CTpUoKNyojyUVV9cGHq+2Gcd/kIs8aIqG/RZcz5Zu
woRxBG5toMAesPo71inZlo6iE62l40kAIhz2ygs2aMERVIyOTy2/2If0oM4uWZNR
JlQMElK6x7d1aolIJQlPoRagH9e3EwojRMcVF29Zrkd36+Sg6iKW0pB3/Ul4MNs=
=y9Wo
-----END PGP SIGNATURE-----

--nextPart2264280.1yy8AgoFOL--

