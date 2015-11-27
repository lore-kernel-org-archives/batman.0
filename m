Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 27 Nov 2015 09:59:36 +0800
Message-ID: <2247189.JEYZehYVi5@voltaire>
In-Reply-To: <1448305042-5806-4-git-send-email-sw@simonwunderlich.de>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
 <1448305042-5806-4-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2341523.c2znrlydzI";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: add seqno maximum age
	and protection start flag parameters
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
Cc: Simon Wunderlich <simon@open-mesh.com>

--nextPart2341523.c2znrlydzI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 23, 2015 19:57:22 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> To allow future use of the window protected function with different
> maximum sequence numbers, add a parameter to set this value which
> was previously hardcoded. Another parameter added for future use is a
> flag to return whether the protection window has started.
> 
> While at it, also fix the kerneldoc.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  net/batman-adv/bat_iv_ogm.c |  3 ++-
>  net/batman-adv/main.h       |  3 +++
>  net/batman-adv/routing.c    | 13 ++++++++++---
>  net/batman-adv/routing.h    |  3 ++-
>  4 files changed, 17 insertions(+), 5 deletions(-)

Applied in revision 544f94c.

Thanks,
Marek

--nextPart2341523.c2znrlydzI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWV7kIAAoJEFNVTo/uthzAOLMIALdSpo1cEd0NbcBPEbl7eZc0
ShAfoHuz/7o9X+GeyyFT3bMeNB+2D7kvEyTHgD0B8v1EWsSwHFL40zumeJsTgHHs
2afVBDv/Xe9+uKH6xFBfT16nVp/oqyHmbcLuVAJ6uai9tLhjOkoUzU1PYeAzL6lU
TCzIJrhFd9+dCRYh8TPJDcASN5BTplziGcrhXM8Tlm7nBCHHjUVCTzMOU3hfV7oK
hpOWxGgaBOORn0TK3O7IYLRBBQVrUhHj6YdWXbljrkg+t14UMPVKCjVxLAyjzZdw
fPZyJRVZaHsJ+d64W6/AON/LR0uAdLoVhptmWaSyDdmL2v7QYYUelMDqGfWCEfE=
=u5Hl
-----END PGP SIGNATURE-----

--nextPart2341523.c2znrlydzI--

