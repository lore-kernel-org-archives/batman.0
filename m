Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 22:09:49 +0800
Message-ID: <14348321.cgLZMolIXZ@voltaire>
In-Reply-To: <1434646404-19291-5-git-send-email-sven@narfation.org>
References: <1434646404-19291-1-git-send-email-sven@narfation.org>
 <1434646404-19291-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1748623.1K3xenOGOM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Add missing include for
	clear_/set_bit in NC
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


--nextPart1748623.1K3xenOGOM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 18, 2015 18:53:23 Sven Eckelmann wrote:
> 586df9e2537b ("batman-adv: Make NC capability changes atomic") started to
> use clear_bit and set_bit but did not add the include for these functions.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/network-coding.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision c0d0029.

Thanks,
Marek

--nextPart1748623.1K3xenOGOM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVhCKtAAoJEFNVTo/uthzAaKMH/3nzTFpPwQL7y4NeMvLb2RwD
H95HfnJ6fRtWatK7/pCBOFg4N6EeyLe8BU7Q21ajB6KifDdF+ip/c3ZXehFxbnqd
7VXApYdACFgte+1zlm1KuPtYjb/+zYwVcRdp3n0rHpzuJdIX7/4EEKG7+0tXh1cC
q7xH3te7piudRYASk6iZ940Zyh/XZW21/MQ5aR/aZuivDb8H0+BAE0AAq9XARe/A
oor8IR6pdINwcuwKNo483H4Oepw6nL7xg2EGW59k2HBQDxHCTUvOd2NCpbxQ0k4n
Swwv3vxgw1YYRzyYsv3F4psX+vNtdbB9toJoCdRThRugm8cCo3SgM+PFvi1yLHw=
=rLF2
-----END PGP SIGNATURE-----

--nextPart1748623.1K3xenOGOM--

