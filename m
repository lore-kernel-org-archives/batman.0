Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Nov 2013 09:31:33 +0800
Message-ID: <5944554.Wq8N1qi0C3@diderot>
In-Reply-To: <1384366492-27310-7-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
 <1384366492-27310-7-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1781145.uGXdUv1uQ5";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 6/8] batman-adv: add bonding again
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart1781145.uGXdUv1uQ5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 19:14:50 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> With the new interface alternating, the first hop may send packets
> in a round robin fashion to it's neighbors because it has multiple
> valid routes built by the multi interface optimization. This patch
> enables the feature if bonding is selected. Note that unlike the
> bonding implemented before, this version is much simpler and may
> even enable multi path routing to a certain degree.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCH:
>  * use new references for orig_ifinfo in the bonding code
>  * fix/beautify comments
> 
> Changes to RFCv2:
>  * style changes (allo variables on one line
>  * use new bat_neigh_is_equiv_or_better parameters
>  * simplify last candidate lookup (Antonios suggestion)
>  * remove last_bonding_candidate pointer when purging
> ---
>  originator.c |    4 +++
>  routing.c    |  113
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> routing.h    |    2 +-
>  types.h      |    2 ++
>  4 files changed, 117 insertions(+), 4 deletions(-)

Applied in revision 797edd9.

Thanks,
Marek

--nextPart1781145.uGXdUv1uQ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSjWJ1AAoJEFNVTo/uthzAlSgH/Rlj/lq346vTsyWd0uzb3KcX
pqYd/rotdPBq3nMlT+jmvNadalE0mZOY2vAMUzVkDdJxh43ECGkdfCyTiXXmHVY3
6uGGqROWnmK98bbst5+Qwcvuv21ixKxqmGqtHlaSGmUIoq5bUSBHEuIkj00sRTLi
QzbWf60yFno5MRsw9YqIX0n6PEQn+8GFmLtF4+HF8xjTuipV1l88LAi0BLe0F1Lm
ViOZWnu94WrHKCV0RAMNz9x7Z97u7pelIhrKctYhzW5ZAf4dmqZw5cwUWIYTjA5Z
EHKSeoDjgIq3N/kvfYqttwpCCZG81bXlZgjI0AJKmGaqxnQige13HMf9q9h4G1c=
=j5CS
-----END PGP SIGNATURE-----

--nextPart1781145.uGXdUv1uQ5--

