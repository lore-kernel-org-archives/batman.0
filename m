Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 26 Sep 2015 22:12:56 +0800
Message-ID: <7637660.lmaZFmOlyF@voltaire>
In-Reply-To: <1442130168-3628-1-git-send-email-sven@narfation.org>
References: <1442130168-3628-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1967592.NxLJckCU26";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Place constant on right side
	of comparison
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

--nextPart1967592.NxLJckCU26
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, September 13, 2015 09:42:48 Sven Eckelmann wrote:
> checkpatch warns when the constant is on the right side of a comparison.
> 
> Fixes: 56fd0bab9c18 ("batman-adv: Fix gw_bandwidth calculation on 32 bit
> systems") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/gateway_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision cef7403c.

Thanks,
Marek

--nextPart1967592.NxLJckCU26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWBqfoAAoJEFNVTo/uthzAUcgIAMJCm7jcIC1JoEr6strPO7zc
30AB83w06oKfkUbiCf2JGjMCUWq4lZ+4z1mjrZyg/+mCEGEpRhpoSqqODKYsba3t
XIYGqeFPpos6LvEml/vbut6MloQi3aeC1IE9rEDXumHBWbVE5LasgFTd5V+zIKpX
V3Uls3iC++d6DPBrSzw2SJcAUekFySKK3qwpSwQt+MVII67UNeZUyhQXf5ErVyQE
fBxTaxT/wpmhJdfFaxOp+h+Vu6h2YVkkiTdRSrpss5mnANAZDMWmiBBgCds4bovr
QqAbCC2jI6SZbnov2M4f/UbVxII3Z4wLiOLRakh8eO7MUDqy7lSI6vHiytF3Io4=
=14zW
-----END PGP SIGNATURE-----

--nextPart1967592.NxLJckCU26--

