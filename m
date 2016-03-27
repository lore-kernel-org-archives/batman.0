Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Mar 2016 15:49:16 +0800
Message-ID: <5307224.UIH421Bh0F@voltaire>
In-Reply-To: <1457189761-9275-1-git-send-email-sven@narfation.org>
References: <1457189761-9275-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2462014.juSJ0fyrXH";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix function names on new
	line starting with '*'
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

--nextPart2462014.juSJ0fyrXH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 15:56:01 Sven Eckelmann wrote:
> Some really long function names in batman-adv require a newline between
> return type and the function name. This has lead to some lines starting
> with *batadv_...
> 
> This * belongs to the return type and thus should be on the same line as
> the return type.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bridge_loop_avoidance.c |  6 +++---
>  net/batman-adv/main.c                  |  8 ++++----
>  net/batman-adv/network-coding.c        | 18 +++++++++---------
>  3 files changed, 16 insertions(+), 16 deletions(-)

Applied in revision 39c3bcc.

Thanks,
Marek

--nextPart2462014.juSJ0fyrXH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW95B8AAoJEFNVTo/uthzA2nkIAKlrDW4GVW4vfpC8RfLP20pJ
53lXTsI24Z3koH8QnmQktqffDlOAES275KMnxu159xtSTmVP3hpAZEDqZAnNIKYS
5kyu50LkGLDcx4acEF1s4VD611Q2K1NMRH7NIPHGjl+oe1tRPu5sh89u3BkMObi/
4hdDFAvechecHTpPM901SQrYiR229fhW7AkB/drbusDWn3wOh3Qqfj+SiGHPC2eX
5vMaRH+XATja0qXBaIEiI0AU2VpEJj5HNpaq/OE2LE/wtPIlIXhdhpFY1hScLXsh
ZrkuCeuwoXwkdM+CGjUqEGsk+xmcxNEA26yPKmIOtjKZZbxM4bcFzTndCsxjwQU=
=0v22
-----END PGP SIGNATURE-----

--nextPart2462014.juSJ0fyrXH--

