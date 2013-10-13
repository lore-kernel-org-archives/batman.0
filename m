Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 13 Oct 2013 17:44:27 +0800
Message-ID: <1816584.FKOJ6PKUro@diderot>
In-Reply-To: <1381625420-4062-2-git-send-email-antonio@meshcoding.com>
References: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
 <1381625420-4062-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1421925.Iri64iL2rv";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: don't switch byte
	order too often if not needed
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1421925.Iri64iL2rv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 13 October 2013 02:50:17 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> If possible, operations like ntohs/ntohl should not be
> performed too often. Use a variable to locally store the
> converted value and then use it.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  routing.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

I don't quite see why this patch is part of this series.

Cheers,
Marek

--nextPart1421925.Iri64iL2rv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSWmt/AAoJEFNVTo/uthzAvdcIAJYCIxq36McORbwLM9mi1H5z
BtgYB9gxlcmldIdSuHF5IJOkTWpIpa4/qgOcubOdM4h+8m0Nf/aXN2Ispt2yjCUf
njYi+TvpaRBKJdXon4v8uasTLdmL3F6sgZmR6wx/T0dlWHUC3j5fQcl0Sub/AeqN
yXUbRPpkqaEpjKg68OAM22NYP+IIemJ/uTBuiT+hKeVvGcRD4owDlUdJn4WkpmKK
L4kBuqSZPJIx7GeOQFtX09v/xVIwG1CiGAiRiuqt12QJWmrf368r0Emkl3Wd17/w
O4DojMZuIXEScRUHvZxUQzombGb3F44QvFRkX7czCCQxHWDQTEAr9YELEqKahLg=
=uds/
-----END PGP SIGNATURE-----

--nextPart1421925.Iri64iL2rv--

