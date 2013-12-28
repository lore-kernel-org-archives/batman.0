Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 28 Dec 2013 16:37:27 +0800
Message-ID: <5282103.sW0R888Hkr@diderot>
In-Reply-To: <1387831419-3848-1-git-send-email-antonio@meshcoding.com>
References: <1387831419-3848-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12510186.2VESkAF4W4";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix vlan header access
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart12510186.2VESkAF4W4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 23 December 2013 21:43:39 Antonio Quartulli wrote:
> When batadv_get_vid() is invoked in interface_rx() the
> batman-adv header has already been removed, therefore
> the header_len argument has to be 0.
> 
> Introduced by 580d7919f19e4f73ccd79e82a532af2bdc638042
> ("batman-adv: add the VLAN ID attribute to the TT entry")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  soft-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision c03be25.

Thanks,
Marek

--nextPart12510186.2VESkAF4W4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSvo3LAAoJEFNVTo/uthzAmiIH/RElabNvPFFXupEVqUeIL1F4
f3J1EUdV6JEdhcW06ReetzEKRh555UFS06+HI0e0O3krZ6xe14cwPjuw04OReh6r
scqXqZucbwljxzl5sYSUHd6s6R1ancidvKo6eZiOGL5iO8fCUkBsfxLsbw9oD8R4
6DpGPO2xrmf8c0WLvFQqW4TG0PIuck7uxgoHRZEZcR0WGN5k+Ox/btsUoacwiNWp
6rQABQIUGPLacntzQEnc4W1+CqYkTuga5tfjEJMQRMJsycTWZhtkri5W3Oyz5wmz
s43yOVoD3vs9YVVo/SV0nrJSvTmFC09gGN6ANQtwy4RbSDAcA8KMQ+GxEBPcyDw=
=B298
-----END PGP SIGNATURE-----

--nextPart12510186.2VESkAF4W4--

