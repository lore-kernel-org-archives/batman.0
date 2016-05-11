Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 May 2016 16:06:50 +0800
Message-ID: <2256730.67eskflOoc@voltaire>
In-Reply-To: <1462817016-17867-2-git-send-email-andrew@lunn.ch>
References: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
 <1462817016-17867-2-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7582636.QNUfXo0PF3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Set skb priority in
	fragments
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

--nextPart7582636.QNUfXo0PF3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 09, 2016 20:03:35 Andrew Lunn wrote:
> BATMAN will set the skb->priority based on the IP precedence or 802.1q
> tag. However, if it needs to fragment the frame, it currently leaves
> the fragment skb with the default priority and actually overwrites the
> priority in the unfragmented frame. Fix this.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/batman-adv/fragmentation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision e374d75.

Thanks,
Marek

--nextPart7582636.QNUfXo0PF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMugaAAoJEFNVTo/uthzAeNkIALlyvWLtVTSpKfKuafvzJzbg
Fji/+c55xetOXvknNcLjDEy9asgNIavD2sh9E9Ia3J/iwoTOLoKyjpN0f9Zs9Ng5
mlIE8N8x9gjyAUnW2wScJrODk8ykRa/YdWzOC3CNICbl4ZcV7Gm7NIFjZWae7Ei6
hagsfka2Be1v+7IbFJuAysI5/Bt6I5X0C4CfKO3y3taS/jbnRcFuU0Ml5/c06bsB
A8C4nHL99CZO7yAAmCYHz8SRTD8r55JRBG58W4NKMHW8tK5YMh6ykM2jYZsvY19d
YEeSu15gzzuG2ybCm9KJg+oJaY6TVB80wZGY6OY+X/WMPSO25r0aMp2U0aMR0AI=
=iQhB
-----END PGP SIGNATURE-----

--nextPart7582636.QNUfXo0PF3--

