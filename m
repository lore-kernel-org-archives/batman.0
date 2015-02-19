Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 19 Feb 2015 23:43:28 +0800
Message-ID: <1865396.itnW5TjHtZ@voltaire>
In-Reply-To: <1424280024-4262-1-git-send-email-sven@narfation.org>
References: <1424280024-4262-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3780560.CxK0STfgDT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Use safer default config
	for optional features
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


--nextPart3780560.CxK0STfgDT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 18, 2015 18:20:24 Sven Eckelmann wrote:
> The current default settings for optional features in batman-adv seems to be
> based around the idea that the user only compiles what he requires. They
> will automatically enabled when they are compiled in. For example the
> network coding part of batman-adv is by default disabled in the out-of-tree
> module but will be enabled when the code is compiled during the module
> build.
> 
> But distributions like Debian just enable all features of the batman-adv
> kernel module and hope that more experimental features or features with
> possible negative effects have to be enabled using some runtime
> configuration interface.
> 
> The network_coding feature can help in specific setups but also has
> drawbacks and is not disabled by default in the out-of-tree module.
> Disabling by default in the runtime config seems to be also quite sane.
> 
> The bridge_loop_avoidance is the only feature which is disabled by default
> but may be necessary even in simple setups. Packet loops may even be
> created during the initial node setup when this is not enabled. This is
> different than STP on bridges because mesh is usually used on Adhoc WiFi.
> Having two nodes (by accident) in the same LAN segment and in the same mesh
> network is rather common in this situation.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> DAT is now removed from this patch because the discussion showed that it is
> preferred to have DAT enabled by default.
> 
>  network-coding.c | 2 +-
>  soft-interface.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied in revision 453dea1.

Thanks,
Marek

--nextPart3780560.CxK0STfgDT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5gSjAAoJEFNVTo/uthzAWdAIAKqAjHtiYfbriWu3zKgwjXqT
9hNiH5P3nqUV1tc4Y8tk58CorJyJrl0XP/TJFOyZlCmIDGugtQNPJyO/PvIBfowt
rhHb+nIk5IM5g41T+Z5bv5J/30qFc69thuTRVJFWah75ad0rbhpdkpySP7RIwhII
cbg0gkidcyg7shKAk/pTITYkiExNY1StQV6TChTgX3/8aA35Hudm2iOCkVv4O7Zn
/3bQ+M+btm/Mv2JufAE0//gcZoBGFgI4mZBg3yaWUYwl76qPyEX7sQP5r857tbG7
UoKjf4H+t8eeoH6OSqRnr3Tu4aBUNVU/KQTBbcBUBK2etbsf3FFWNGDpDMPciZo=
=UG7+
-----END PGP SIGNATURE-----

--nextPart3780560.CxK0STfgDT--

