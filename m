Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 May 2016 16:14:19 +0800
Message-ID: <10233014.rTsHfh6rtW@voltaire>
In-Reply-To: <1462812114-16577-1-git-send-email-sven@open-mesh.com>
References: <6307812.WAqRcEYAvX@bentobox>
 <1462812114-16577-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6022952.nccMc1rg2y";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 1/4] batctl: Split list of objects in
	Makefile into separate lines
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart6022952.nccMc1rg2y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 09, 2016 18:41:51 Sven Eckelmann wrote:
> From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> The line of objects which are required to compile batctl gets longer and
> becomes harder to read. Instead save each object on its own line to make it
> easier to edit and easier to solve conflicts when multiple patches modify
> the list of objects.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> Forwarded: https://patchwork.open-mesh.org/patch/16078/
> ---
>  Makefile | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Applied in revision 876c536.

Thanks,
Marek

--nextPart6022952.nccMc1rg2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMunbAAoJEFNVTo/uthzAxr8H/3XVFw26U7ls8HQXtyY4ESoO
03VtlUhfRGiX4uufHKilH8BMvLltYa1GGKInWaeieugnWZiAcLqxSO/Udk2g0B2c
TbPIoiKvC/r3W5zs2xuK20XdLoDri/9JLX9XhtuqS+tOfafXN4D8cx0+KlPs3aOQ
kxslAZEVQwaH2E5xnTlLzHg9mgfSWmbLGxlPMU5k97NPmAv0Q76lXTVgIKoT1D5d
nYpM3C/rysw26BV2HJnxtMpSxBYttYUjnkskuMi9Akn+jLCz9b2lcZcAf6B1DKxu
xjeiYLTinjM0dL72IKyuVSupFL+D4jbNMZzL6/ijkBdeBvTQjmELFDNZ0KAEuqo=
=zNfi
-----END PGP SIGNATURE-----

--nextPart6022952.nccMc1rg2y--

