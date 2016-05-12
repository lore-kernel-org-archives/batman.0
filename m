Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 May 2016 18:04:38 +0800
Message-ID: <3966287.AqV7F3pn4W@voltaire>
In-Reply-To: <1462817016-17867-3-git-send-email-andrew@lunn.ch>
References: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
 <1462817016-17867-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart97537887.1Z0bQN8o1H";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Include frame priority
	in fragment header
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

--nextPart97537887.1Z0bQN8o1H
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 09, 2016 20:03:36 Andrew Lunn wrote:
> Unfragmented frames which traverse a node have their skb->priority set
> by looking at the IP ToS byte, or the 802.1p header. However for
> fragments this is not possible, only one of the fragments will contain
> the headers. Instead, place the priority into the fragment header and
> on receiving a fragment, use this information to set the skb->priority
> for when the fragment is forwarded.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/batman-adv/fragmentation.c | 2 ++
>  net/batman-adv/packet.h        | 7 +++++--
>  net/batman-adv/routing.c       | 2 ++
>  3 files changed, 9 insertions(+), 2 deletions(-)

Applied in revision 4f241fc.

Thanks,
Marek

--nextPart97537887.1Z0bQN8o1H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXNFU2AAoJEFNVTo/uthzAeYQH/2Ypovr9b22RcKCh5coDh5Fd
kSgds7pxcYuQwLJwiHkiYJ7tDocNmOA9g9d50bErYNT7un06R1TKL/6PlnLkg7JR
1wzy8/Qiv/QHZkZ6rxTCims1dW7wtv8nbB8bupabRPom2JZf7eerek9cBX5JhemF
Syij7SQ/gcd78cjZ5yx+Ypuev02jk2FeKB3dwK2hYoix1MeGBLPRBAeGiGi7bBC5
yR4bjKA09hX/+wCBn6rXvXfYtzAEJ4E6aNGfbI+zKVhdxrtp0tD8wepJcwbR4vNW
GM+PVMf++xwQT4MH3WWv+NFrE4YjkeBMrRs5DRLwJG0AQ0i5+et1DE1/nxWt7yI=
=T4y9
-----END PGP SIGNATURE-----

--nextPart97537887.1Z0bQN8o1H--

