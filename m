Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Nov 2013 11:37:10 +0800
Message-ID: <2679403.uqHTqpnomK@diderot>
In-Reply-To: <1384599832-3959-7-git-send-email-antonio@meshcoding.com>
References: <1384599832-3959-1-git-send-email-antonio@meshcoding.com>
 <1384599832-3959-7-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2452604.cSVp2tYSju";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 6/6] batman-adv: set the isolation mark
	in the skb if needed
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2452604.cSVp2tYSju
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 16 November 2013 12:03:52 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> If a broadcast packet is coming from a client marked as
> isolated, then mark the skb using the isolation mark so
> that netfilter (or any other application) can recognise
> them.
> 
> The mark is written in the skb based on the mask value:
> only bits set in the mask are substitued by those in the
> mark value
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  soft-interface.c    | 18 ++++++++++++++++--
>  translation-table.c | 26 ++++++++++++++++++++++++++
>  translation-table.h |  2 ++
>  3 files changed, 44 insertions(+), 2 deletions(-)

Applied in revision 6fa38a2.

Thanks,
Marek

--nextPart2452604.cSVp2tYSju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSiDnmAAoJEFNVTo/uthzAvMgH/iJygC9EsSGRR0y23q6fPSe9
5ai/M4CA4fw0iZ3RkVqHWsXlpDj7Uhtc4QRuPi/isW9csw85fHMF06cDQucM4pvv
A0Nh6QhmQHwEAE7ECkJ9OZGSzl+2Si9PiW+IysOSOvX9V7jc3DEL0EoAsKxrlhkV
GP+V0lBxX8iaHhXYZ2HEEzN2AiNey7gCb96+kHm0lGDJJ0gyNiBpmGHKbvz7oyGM
+gYj4sZCdOWCWs0ek07hvxCoVz1B9a6oUOUcanyk9dTZT6QnzxFv3x+My+oy/zEU
gtuxedZo2EFXVWJXR1YfnVPrDsDUhos+l6NpPMmphDrlL8KemFkXJGQ8znEtKgo=
=As/D
-----END PGP SIGNATURE-----

--nextPart2452604.cSVp2tYSju--

