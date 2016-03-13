Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Mar 2016 10:12:07 +0100
Message-ID: <9919433.c4WuAskJuF@sven-edge>
In-Reply-To: <56DD8E53.3010904@universe-factory.net>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-5-git-send-email-andrew@lunn.ch>
 <56DD8E53.3010904@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1985499.PkFqFSu3i4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: debugfs: Add netns
	support
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

--nextPart1985499.PkFqFSu3i4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 07 March 2016 15:21:07 Matthias Schiffer wrote:
[...]
> By the way, the netns support is another good reason to switch from the
> debugfs interfaces to a netlink-based interface (as the netlink interface
> wouldn't need userspace applications like batctl to be aware of the
> namespaces). I guess I should finally finish the patches I started writing
> for that...

So what is your suggestion here? Should the namespace support for namespaces 
be rejected and you send in your netlink implementation patches? Or should 
this patch be merged and be removed (together with the rest of the debugfs 
stuff) when your netlink support is integrated?

Kind regards,
	Sven
--nextPart1985499.PkFqFSu3i4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5S7nAAoJEF2HCgfBJntGs4wQAI7aPB1IYFPVoSPEvQExukwq
4DdIo6zSgbTyZK8SP6bBM81jzDOIjg9+QVLGYF60TfeC/iPnSjZKLSGaZ9TO+M/0
YjGW4/Bw1mQ1rbf1IGsq214v/PcvmyGtFGJ6uIpypoRXMLnaU3kpGv06A9iiodiz
9sZAdtNgtiY/8UbfxjFiFW5+5fUgRWdzp25o+1ZRSVDK/yWfwW3Se5mNfYP4H05Z
R7Yumo8qvlw7MI3A7Af8dEpPilphnYQidVhHFtRbGNExCC+ecafi20X04h9/wAFl
DheWo8cJR6VOYWAKPv4Ksn1in1tLNB3RUcnOmrPPNQ/si0Y3VE1j4AXUxBABmB/m
6DU6PAR6904x1WvxH0Q2Xw+ItbiYt8WieNttKP6nrkscN12ibVAt3m7s5wcvlseB
erF7viho2ApT3VChoDAqi7byRVOXtgVpDsYNV5JxmO0oJ+a9Q6U0NL+BfHRLkrsZ
5nw6DcqNFtWoKBN+wOuWenQs7oaPiTK9GMu2MHxA33GCLsSuNaL7aQowfhs/dBZq
9LixvpI2iVfNcFoP0XtwzWYqQTc68AcVxjBDzbsUVdlsEgFAa86zLHOIwQu8izhH
nis0BxdK36izYzz76DJlqqXekzF6MG6CEjsrpUF2nFdfMwF430ib4gpkGReTav4D
tO8l9iTtAoI2uiD3Jw30
=1ZyQ
-----END PGP SIGNATURE-----

--nextPart1985499.PkFqFSu3i4--

