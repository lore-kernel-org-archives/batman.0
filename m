Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 23:14:58 +0800
Message-ID: <1470998.TKTfVbPYRM@voltaire>
In-Reply-To: <1457701271-24248-2-git-send-email-sven@narfation.org>
References: <1457701271-24248-1-git-send-email-sven@narfation.org>
 <1457701271-24248-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2579587.cdcJ4Zxxu8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: fix debuginfo macro
	style issue
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
Cc: Simon Wunderlich <simon.wunderlich@open-mesh.com>

--nextPart2579587.cdcJ4Zxxu8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, March 11, 2016 14:01:11 Sven Eckelmann wrote:
> From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
> 
> Structure initialization within the macros should follow the general
> coding style used in the kernel: put the initialization of the first
> variable and the closing brace on a separate line.
> 
> Reported-by: Antonio Quartulli <a@unstable.cc>
> Signed-off-by: Simon Wunderlich <simon.wunderlich@open-mesh.com>
> [sven@narfation.org: fix conflicts with current version]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Patch was resurrected from https://patchwork.open-mesh.org/patch/3769/
> 
> I've requested an rebased version at
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014638.html
> but done it myself because it was rather trivial.
> ---
>  net/batman-adv/debugfs.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Applied in revision 2d34b55.

Thanks,
Marek

--nextPart2579587.cdcJ4Zxxu8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+UpyAAoJEFNVTo/uthzA7lAH+waA7cdrQ+05ph0Nw50MAFih
iDlFpNJFKsJJYQ1K8ZLZiWD0CqOMfQUwEyfaIheDbB1s+oVLxlh7XCw/Yj1qmOdJ
plqdvfABOscWiu2ufFVYdrRxLtnNWBb5382Nx3cEzPHiNHqo9jPX9x3gqNFfQ3XC
+4gIJ+zGQlxQwMAAe65iwXJsQ1DA7wm4KpjSMhJYlHilKbGZROQjAjEqHJQGQgaS
U+tJGE5kSuainBDxcSsdPQJaLn7VptYrx3FSokgNF85ofNsj/5ei4tLRRUstF7uS
CzY/WHTW8aGlAzP5/bHIW9ycH13NbYmTHPnSsSXWd8HN8vge48Z2fZUxPCi12d8=
=iaY6
-----END PGP SIGNATURE-----

--nextPart2579587.cdcJ4Zxxu8--

