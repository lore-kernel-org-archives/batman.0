Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 15:55:44 +0800
Message-ID: <1769791.tLJkjoEo51@voltaire>
In-Reply-To: <1467542795-29647-4-git-send-email-sven@narfation.org>
References: <1467542795-29647-1-git-send-email-sven@narfation.org>
 <1467542795-29647-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2059964.g2jJea0Esm";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 3/4] batman-adv: B.A.T.M.A.N. V -
	implement GW selection logic
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2059964.g2jJea0Esm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 12:46:34 Sven Eckelmann wrote:
> From: Antonio Quartulli <a@unstable.cc>
> 
> Since the GW selection logic has been made routing protocol specific
> it is now possible for B.A.T.M.A.N V to have its own mechanism by
> providing the API implementation.
> 
> Implement the GW specific API in the B.A.T.M.A.N. V protocol in
> order to provide a working GW selection mechanism.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v6:
>  - remove comment for get_best_gw_node in batadv_gw_election (added to
>    patch 2)
>  - fix possible integer overflow in batadv_v_gw_is_eligible when comparing
>    current gw throughput (+threshold) against throughput of potential new
>    gateway
>  - use seq_puts in batadv_v_gw_print
> ---
>  net/batman-adv/bat_v.c          | 223
> +++++++++++++++++++++++++++++++++++++++- net/batman-adv/gateway_client.c
> |   5 +-
>  net/batman-adv/gateway_client.h |   2 +
>  3 files changed, 226 insertions(+), 4 deletions(-)

Applied in revision 80b2d47.

Thanks,
Marek

--nextPart2059964.g2jJea0Esm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe2gAAAoJEFNVTo/uthzA5UIH/2rJyB/HUNslZR7wPN2iIiB4
Ft0htXM9GwLDVlI/JguU+oEJO3n9+DH+WSO8oJlk1yT/44cL/qZTRe/5p1vq2qnb
mtSvAhNgKh7FgKAO//gQuwZLfCB2IBdFRtr7d1xxXeCZDZNKbnrHq0QJ/wWISBg0
N03kEnFMT3kZDNTSCHgyEVSx5hHUlx4+wx3rpVB7hR7F4Yn2F+vuKlw39nev7va5
aGi1aG/O5j5ix2JzNnJ2YKIBEVGyqRTdMkPdogkZIlImOJIhY/No9Jh0WuLpd1rp
RiFSt231lP6eRJSKMqRtxBUysYnynKgzuYX47PP3cYFGSRsWkHideUPmMlm1Ego=
=TATf
-----END PGP SIGNATURE-----

--nextPart2059964.g2jJea0Esm--

