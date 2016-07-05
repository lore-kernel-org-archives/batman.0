Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 16:01:30 +0800
Message-ID: <2334867.VH019pQTRZ@voltaire>
In-Reply-To: <1467628499-23243-1-git-send-email-sven@narfation.org>
References: <1467628499-23243-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3946917.yiRT5IqR79";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: Switch netlink uapi
	header copyright to ISC
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

--nextPart3946917.yiRT5IqR79
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, July 04, 2016 12:34:59 Sven Eckelmann wrote:
> The batman_adv.h netlink header is used by userspace programs to use the
> genl interface of batman-adv. These programs may not use the GPL-2 license.
> The header should therefore state clearly that it can be used freely and
> the license of the program which uses this header is not affected.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Acked-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
> It was acked in https://patchwork.open-mesh.org/patch/16471/
> 
>  include/uapi/linux/batman_adv.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied in revision c94437f.

Thanks,
Marek

--nextPart3946917.yiRT5IqR79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe2laAAoJEFNVTo/uthzAMa4H/2HLdqp7UccH3L+4EN96nExW
SYm84R6GLoBtG2Ly+9JWJLFkF22mcPoWoBIlk7/u1n4KVmmrLOPW3Aj6iCWCIdBR
cjGaxgOEmqOCxwQBSpefuObu75aVJmRQIdT3gYjAP8IWI360Jte/Wgmest/S4buF
QjerKGSwa0W6OqB9bNtbUlrC3xpo2br35VCNK8C+oRq4nPM358eUZeWVbR9sNk1L
XRMGYn8N7xbHbTtDTeDZq7ugom7Piq1BifCQYJJLuWGiriOI9e0YxQdO8w88EiGV
rEsQqQtAG5CaEPxTmL1cNBbM89ylLCv0/g9sztYpQN57aPYYmyI+wbDGKuUYcns=
=ncy1
-----END PGP SIGNATURE-----

--nextPart3946917.yiRT5IqR79--

