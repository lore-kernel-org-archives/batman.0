Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 17:31:35 +0800
Message-ID: <4893842.MKhylzvCye@voltaire>
In-Reply-To: <1467310294-5892-2-git-send-email-sven@narfation.org>
References: <1467310246-5820-1-git-send-email-sven@narfation.org>
 <1467310294-5892-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7935045.iWXBQcPMdf";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/3] batman-adv: Fix reference leak in
	batadv_find_router
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

--nextPart7935045.iWXBQcPMdf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 30, 2016 20:11:34 Sven Eckelmann wrote:
> The replacement of last_bonding_candidate in batadv_orig_node has to be an
> atomic operation. Otherwise it is possible that the reference counter of a
> batadv_orig_ifinfo is reduced which was no longer the
> last_bonding_candidate when the new candidate is added. This can either
> lead to an invalid memory access or to reference leaks which make it
> impossible to an interface which was added to batman-adv.
> 
> Fixes: 797edd9e87ac ("batman-adv: add bonding again")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - get refcnt for new selected router before assigning it to returned
>    variable
>  - move refcnt cleanup of all remembered candidates/routers to central place
> ---
>  net/batman-adv/routing.c | 52
> ++++++++++++++++++++++++++++++++++++------------
> net/batman-adv/types.h   |  4 +++-
>  2 files changed, 42 insertions(+), 14 deletions(-)

Applied in revision 6ecc711.

Thanks,
Marek


--nextPart7935045.iWXBQcPMdf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe353AAoJEFNVTo/uthzAsv0H/0SOj5PcK3qV0FcZpWsTL0ZE
R8hQPPsa0SribgOStgErd70icr29WtdC/w3WFFavlR7v+9FCRw31+NIlGdfdzFeq
NNGMR1sPJ4cDnqpgVTa2K2kcQ0+tEccUwiQOmzrueRDYBGdqShiLArZR2rDZFfs8
yjEbxk2WgUGIjDpiPEokAl0uSQhNIVD6lSVuLlBR7vvBVEr/Q18XOfc3ncePHx7t
E82uvsAEdRxxxFoLBzaTa3i+TkbdxG4eLrk29gGK2o5eqBfiCfpJrAnA4ikWOVsG
Q76dgc9rF6rYYWiNH9A2rN3aCc7HinXV6imL2bpgeTLvk9/lfIlWQv5ECZF7SEQ=
=sRGN
-----END PGP SIGNATURE-----

--nextPart7935045.iWXBQcPMdf--

