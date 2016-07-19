Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:25:32 +0800
Message-ID: <1812715.rUHurWOSKo@voltaire>
In-Reply-To: <1468597173-25378-6-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart146893147.hRnfsDVEp2";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 06/18] batman-adv: Place kref_get for
	orig_node near use
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

--nextPart146893147.hRnfsDVEp2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:21 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/bat_iv_ogm.c     | 7 ++++---
>  net/batman-adv/bat_v_ogm.c      | 5 ++---
>  net/batman-adv/gateway_client.c | 2 +-
>  net/batman-adv/network-coding.c | 7 +++----
>  net/batman-adv/originator.c     | 1 -
>  5 files changed, 10 insertions(+), 12 deletions(-)

Applied in revision de6330c.

Thanks,
Marek

--nextPart146893147.hRnfsDVEp2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeP8AAoJEFNVTo/uthzA0IMIAKepyh5vC8yZR5bkGqwk80nD
s4wocpL0QX4m08WwBYhQIk4HtzdvAavFrXjRqIAQN/iTg3j6p4xRBZp4IdbFQjen
1u6LS4mgAH71civq7yr3x31plYTRsxzv5FWeh9XJQBAcadkGGCIRfqrDOiIT1Zrt
TUJUQX/ec1jm9OMK+FhPfDSHePVF/J4P2x2cOpFyGYdSY7ptOFOLRsofeaxfVxos
vYvFWtyRZBKanaugzMcfnOY8GH1uCq24pUA8AK5ReB3nszG6HFVSvdD5ZbTIdVtl
dTCPU23d/rbYgWLHdbPszXOWSqoVxpp7lCKZfRSfkiUkcERGQHcy6hIN3gWfM8o=
=PWWj
-----END PGP SIGNATURE-----

--nextPart146893147.hRnfsDVEp2--

