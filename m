Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jul 2016 16:48:59 +0800
Message-ID: <1709149.ntyVMelbak@voltaire>
In-Reply-To: <1467545508-7333-2-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6769122.b7P3V7TXux";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 01/16] batman-adv: Handle parent
	interfaces in a different netns
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

--nextPart6769122.b7P3V7TXux
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:33 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> batman-adv tries to prevent the user from placing a batX soft
> interface into another batman mesh as a hard interface. It does this
> by walking up the devices list of parents and ensures they are all
> none batX interfaces. iflink can point to an interface in a different
> namespace, so also retrieve the parents name space when finding the
> parent and use it when doing the comparison.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven@narfation.org: Fix alignments, simplify parent netns retrieval]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  compat.h                        |  7 ++++++
>  net/batman-adv/hard-interface.c | 50
> +++++++++++++++++++++++++++++++++++------ 2 files changed, 50
> insertions(+), 7 deletions(-)

Applied in revision bea804d.

Thanks,
Marek

--nextPart6769122.b7P3V7TXux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiKN7AAoJEFNVTo/uthzASIoIAJLaSZlEZsFa6Q7fChgOsCff
Da5+ZVkrdg5tVa16hDWMrF//03fqtME/S4/9p/A8scUMDFzDoSKY+jvo80uc5F4u
c1SNK03z1WMftinaESghGsbGloDnqw7gCMVUm3GAhCEU0FOIs1M8FFoGl/qIB2H7
859vK8mdFR608aK1Tf7e0pOe4ofqAijEBzgTosW1YYByA2M99nabtxlk8P32PKjs
Z2ZhKGTitSklibj+IHDvsGQpXOPi9eWDGl6V1cgiLtA+SGNX+Q79gxsA+IBOj3xD
GHcxEwzVrShHGqRFw2a+rN+BQSwioBZQ6vVvbrpiAwDuowU2vXx6V5v4z5ioXTM=
=kW0v
-----END PGP SIGNATURE-----

--nextPart6769122.b7P3V7TXux--

