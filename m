Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 14 Sep 2015 16:53:14 +0800
Message-ID: <48086839.DUD6itolVk@voltaire>
In-Reply-To: <1442130285-3725-1-git-send-email-sven@narfation.org>
References: <1442130285-3725-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5947877.aGNESqiCaX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Place constant on right
	side of comparison
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


--nextPart5947877.aGNESqiCaX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, September 13, 2015 09:44:45 Sven Eckelmann wrote:
> checkpatch warns when the constant is on the left side of a comparison.
> 
> Fixes: 56fd0bab9c18 ("batman-adv: Fix gw_bandwidth calculation on 32 bit
> systems") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2: fix stupid error in the commit message
> 
>  net/batman-adv/gateway_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision cef7403.

Thanks,
Marek

--nextPart5947877.aGNESqiCaX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV9or6AAoJEFNVTo/uthzAIeYH/3FvRQ8wmuFCGhVxYnvwwjDt
/csu5LD6QX/78YgBEAz9qD2nyNNUO8xm9Fp/A234jqk0/McC1w0KNXtadWiVESiw
jWFOsPhqD2I6yEFAUekbNkg7ulQj14rN0Eajp4EPPdBYL+PhvilXD3NwKo4BULvU
8xaSjEGnnAje7n5yrrkHeHNwNTyXaJ5/AFNFwXfPY66d7QCfJJ5wqj1k1t9RMc8R
cIGC4Xd+qSZY1FrfnmEFYM1qDN+Q2GUkn43aoATRdnvvMhtN8zEt9I2I0ualazJ4
hFKEImGyl/n2xNbK38VKr5MtIGiEOLLC5C4V3kJzPVWaKmLdTB8xmxOD2QBl8gs=
=xsp1
-----END PGP SIGNATURE-----

--nextPart5947877.aGNESqiCaX--

