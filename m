Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 31 Mar 2016 16:58:46 +0800
Message-ID: <18244218.8GUmH6Cn0R@voltaire>
In-Reply-To: <1457190564-11419-3-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <1457190564-11419-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6107871.rf9Thnu2Kc";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/9] batman-adv: Increase hard_iface
	refcnt for ptype
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

--nextPart6107871.rf9Thnu2Kc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 16:09:18 Sven Eckelmann wrote:
> The hard_iface is referenced in the packet_type for batman-adv. Increase
> the refcounter of the hard_interface for it to have an explicit reference
> for it in case this functionality gets refactorted and the currently
> used implicit reference for it will be removed.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/hard-interface.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision feffc04.

Thanks,
Marek

--nextPart6107871.rf9Thnu2Kc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW/ObGAAoJEFNVTo/uthzAS2IH/3BzfHp+U+Ij+HRDpduJjvBr
UTzGg+mezPWCIVZVpy4pKwnXUXzOStJ1IxVnJq5snkuu7S2nKYXqzpCOBqXdAnA3
1XqM+QaNutwsZE80We0k9IQxm5Li9ztrggh5mJTFlu72xofXc88lDjkMu3rL1vxS
vQxywcDu9c9wep2VN2+J5hyQlVBfxwcq13atsRflyrimN/lYRfAeJR+lbVYxtAMq
JR/JCReAdrZeznTbyw6ZH8R32QmrGkBEUDwYvu+NACDXQCl4L1dvogzfhmkOvQsq
mJZW55X/kL5cbxwgyTthgIHmKhhZBwC+xJq/b9uXIcr7F0ErS7c7HiEG1HOOyME=
=a7XR
-----END PGP SIGNATURE-----

--nextPart6107871.rf9Thnu2Kc--

