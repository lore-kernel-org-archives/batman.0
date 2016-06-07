Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jun 2016 10:06:50 +0800
Message-ID: <1531539.0zSyJ4QR3t@voltaire>
In-Reply-To: <1734620.RxNen75AvH@sven-edge>
References: <20160521133555.13403-1-a@unstable.cc>
 <1734620.RxNen75AvH@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart366335703.eV5ieI1PFU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: B.A.T.M.A.N. V -
	implement hard-iface init function
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart366335703.eV5ieI1PFU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, May 21, 2016 16:30:53 Sven Eckelmann wrote:
> On Saturday 21 May 2016 21:35:55 Antonio Quartulli wrote:
> > Some fields in the hard-interface data structure are specific to the
> > B.A.T.M.A.N. V protocol and have to be initialized only when such
> > protocol is compiled in.
> > Instead of having a #ifdef block in the middle of the hard-interface.c
> > code it is better to have an algorithm private function that hides the
> > precompiler logic in its own header file (like other functions).
> >
> > Fixes: ffd2f27908e5 ("batman-adv: Only init ELP tweaking options when
> > BATMAN_V is enabled") Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > ---
> 
> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 713586f.

Thanks,
Marek

--nextPart366335703.eV5ieI1PFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXViw6AAoJEFNVTo/uthzA3u0H/3tnvcmnBLA1B5YR1UTnNW0b
Bld4dBWKomT6U/cJH6YLx30wT+Rh3bQxpDLA4h/BThMrN2bEAZHTqDkcpQi30sCT
xzrKoNmwrXUnr9Aj/sP7Is5MJJs+kKMFsjMHMPffks4rj8bmNSAWvjdtOon257ww
AzI2N8cftGt9EkSptrsQ5g9DUjC8sN/4LLf/mTf+Vsg9oa+gT12YunARaT2bG+ZW
vmgEm9ikGM3j2r2R0dmDMADM9UAhYJJQWLrztyuFumWEc9cBAmeGXJ+lVb5JqhTX
OWe7nf1zszy7BH0CFsAg8WFC+HCVROpU1Vyl7IjYOjKnk0l+9C8YV0q4eK6hf5c=
=Ecze
-----END PGP SIGNATURE-----

--nextPart366335703.eV5ieI1PFU--

