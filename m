Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jan 2016 23:15:39 +0800
Message-ID: <2447772.BLZGBemBL3@voltaire>
In-Reply-To: <1452933619-6712-6-git-send-email-mareklindner@neomailbox.ch>
References: <8047297.0qIFjkW2bL@voltaire>
 <1452933619-6712-6-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2282624.qfJpb2Kxkl";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 06/12] batman-adv: OGMv2 - implement
	originators logic
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

--nextPart2282624.qfJpb2Kxkl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 16:40:13 Marek Lindner wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Add the support for recognising new originators in the
> network and rebroadcast their OGMs.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> v2:
> 
>  - rebroadcast packet immediately after best neighbor timeout
>  - add a flag to avoid forwarding the same OGMs multiple times
>  - move TVLV processing out of update_route() and into
> batadv_v_ogm_process_per_outif() - code comments improvements (typ0s,
> clarifications, etc)
>  - mark OGM packet as new when protection window is started
>  - remove redundant throughput checks
>  - simplify/fix best neighbor check
> 
>  net/batman-adv/bat_v_elp.c |  41 +---
>  net/batman-adv/bat_v_ogm.c | 556
> ++++++++++++++++++++++++++++++++++++++++++++- net/batman-adv/bat_v_ogm.h
> |   4 +
>  net/batman-adv/main.h      |   2 +
>  net/batman-adv/types.h     |   4 +
>  5 files changed, 566 insertions(+), 41 deletions(-)

Applied in revision 667996e.

Thanks,
Marek

--nextPart2282624.qfJpb2Kxkl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnlMbAAoJEFNVTo/uthzAtNoIAJuW/n7OkEjIRBZ8mRGCPDAX
R7ulUJinfnhAIOkF0CrLdDCwXNyZRFFRsCxiA5XynMNMDprtTDWJGtkOEUZqerv1
q8pt6vtyw+n4rgHGl6sS1nMZCvgk+3YLB2gEa5HB16cVpKaR3t9/Y7nTMqFRg9cU
ztaKCZlftXqZrTIJnq+3ON1VRU07w0R4fsdMNXY1epHSDwsmYuJur4JFdD/z4nQt
Ey++nbP479HrBJR1A6utizVX7OypSBFDRxPirvxyfSpOuhkVz+Q9eEdbTo85sNwr
xjXVtroWTOsuhfncKV4esl2PP2majXubpSdJT7OEga5Z+loeaG9hxXz7kCBq2J8=
=HdvD
-----END PGP SIGNATURE-----

--nextPart2282624.qfJpb2Kxkl--

