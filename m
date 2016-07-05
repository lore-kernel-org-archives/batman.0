Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 16:41:30 +0800
Message-ID: <3052840.PXnslLM2oB@voltaire>
In-Reply-To: <1466445289-17840-1-git-send-email-sven@narfation.org>
References: <1466445210-17616-1-git-send-email-sven@narfation.org>
 <1466445289-17840-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12764151.pILtKxgPd8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next v2 3/4] batman-adv: remove
	NET_XMIT_POLICED
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
Cc: Florian Westphal <fw@strlen.de>, "David S . Miller" <davem@davemloft.net>

--nextPart12764151.pILtKxgPd8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 20, 2016 19:54:48 Sven Eckelmann wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> BATMAN uses it as an intermediate return value to signal
> forwarding vs. buffering, but it did not return POLICED to
> callers outside of BATMAN.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [sven@narfation.org: rebased on top of TX path rewrite]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - rebased on current master
>  - added patch to a common set of related patches
> 
>  net/batman-adv/send.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied in revision ec76a65.

Thanks,
Marek

--nextPart12764151.pILtKxgPd8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe3K6AAoJEFNVTo/uthzAadQH/A372bSAjQURGRztyWo6iQHd
V0ppooyajITrGGdRJyQ1N5emvRoLjSSLEV2zsJcIX02PcyQUyd/t5g73jaq0GD0a
FnaQw9df4zy7dMr2lMvAewDzRUKTXajZZ9r6RupLytJrGEiGuDyilNQ+3OeI71Ux
dWgdZy4V9X1w+BKqkVtnIyOIeR2VXrn52E0/1L5h1pvbLz+sO5zPJ17j0nRKmmKw
bzzc3ZyHI45ZFK5uPvJ27LLO+pbxwPuegL/XegRLmhWzpU50lQ0umK53qIaBYBg6
rD6p62oubPtZEJ4XcfeA2/4Eq8C22I5n6eCtuWTAfhyx+NVLmxJqo+XDQNjfVtw=
=BzmD
-----END PGP SIGNATURE-----

--nextPart12764151.pILtKxgPd8--

