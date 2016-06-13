Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 13 Jun 2016 12:40:03 +0800
Message-ID: <3140277.CrrlecRSbG@voltaire>
In-Reply-To: <1463758208-31645-1-git-send-email-sven@narfation.org>
References: <1463758208-31645-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5622820.ds0Hveps5Z";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Fix format string for raw
	tp_meter output
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

--nextPart5622820.ds0Hveps5Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 20, 2016 17:30:08 Sven Eckelmann wrote:
> The tp_meter output for raw bytes is not casting the values to float.
> It must therefore use PRIu64 to print the results.
> 
> Reported-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  tp_meter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision 53081ce.

Thanks,
Marek

--nextPart5622820.ds0Hveps5Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXXjkjAAoJEFNVTo/uthzAf3MIAIQkDFH5JIGsfT/zMc3QB7Gh
gjditZDOHWSDtzk7/lPOZ73yXH/0Kf4AMx9kuVgLvKd+Csy4IxnF6JaBkNUy/FIG
GEoEOKu9U8DLO9x8e8/ZTd9KNrJ/KwJx5s5WTqgdneN4URtuwBnhXJ/ehug6UN44
aCenour9dYsSAEujxGyHw0KtV5/AXC/zE2GizWPUY3m1Saq2M3ALrOsKY1hkeNxp
wExjSk/3kQmIZAi6zTc5YAeiJ9t6n9oHim3HIUQ4A7EHv+pxD5Bcny/2EdLjo7td
ueasnavvrMIdWrNscJTNWAnGpcPi1vn7FGjH463vvdGBaxVEPazPhvk3fhxVrUk=
=KRVY
-----END PGP SIGNATURE-----

--nextPart5622820.ds0Hveps5Z--

