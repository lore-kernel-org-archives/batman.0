Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 24 Nov 2011 14:32:41 +0100
Message-ID: <1912197.PaK4SIUBy6@sven-laptop.home.narfation.org>
In-Reply-To: <201111242118.47604.lindner_marek@yahoo.de>
References: <1322131238-11036-1-git-send-email-sven@narfation.org>
	<201111242101.21710.lindner_marek@yahoo.de>
	<201111242118.47604.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart27546203.YEUKMYLtc1";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Move build compat stuff to
	Makefile
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart27546203.YEUKMYLtc1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-15"

On Thursday 24 November 2011 21:18:47 Marek Lindner wrote:
> On Thursday, November 24, 2011 21:01:21 Marek Lindner wrote:
> > > I looked at the new patches from ordex and thought about using the
> > > Makefile from the kernel as the Makefile.kbuild in the standalone
> > > distribution. The Makefile is only the user friendly compatibility
> > > layer over the kbuild stuff.
> > 
> > I thought the main idea behind this separation was to have one Makefile
> > for the kernel folks and one for the out-of-tree users ? Are they going
> > to accept a single Makefile which contains more than what is needed for
> > in-kernel development ?
> 
> sorry, I misread your intentions - then I discovered the patch at the end.
> Let me try this on OpenWrt.

OpenWRT would need some tweaks to get it working (I didn't test it... just 
assuming some things). So copying the Makefile.kbuild to Makefile must be 
removed and PWD= has to be set to the source folder when making the 
build/install/clean calls.

Kind regards,
	Sven
--nextPart27546203.YEUKMYLtc1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOzkd5AAoJEF2HCgfBJntGhn8QANJBB1tTylKUWT+zoCbRH32d
2kNjHDb7taaZUySRVEw6ceT2PisG9btvhCy0FORC3ZvS7YeQKM7RLMuM4/XM+x1k
CVIgRB58rVvBr3zNfbF7wnjRNGEiRhqnshae617O/pj6Jt7D3h9gCmk1rODHu1Dk
UdURI58TkfAn8DkCwSuVF0+5/znWq/aLo8qdt+F1h0/SyOOpV8+42SBfM0odsHlc
r3+qo/6K3BbKfkp4kmdmhHe8KCl62WNJ88myBiIkcDOqdJIMgMEkxpkTbpKYtea9
75jUevtvCAFv+hDKjISeUwbWUtQU0UTHr3n5wEyFEMvb3s7aOtPPwSW79l5fMbuq
MUBydvjwRnwnwgRkM8WBXI2JMW1RHP/vRcWOMUDWKOfk5Kf+dGr11tGbNTRtdVAm
BCbJN6eptrH1OnDQFgkE3roFec8Oe4UDnTtecJMa7amcS9uIXOqgfSWvL9J3UQq8
RWCr4Tbh5MlxasU5c1VnqFlEVx08LD5nOb28wgn+s4OADoFhFF9W0tb6eaAOa7CL
mJXNFbGuiaNHFMpj8gdWdaBxNanQOIaT+hZp8mIZLZhL4ij8AJ5kWYMMQoEYSz0L
9cvM+fcV3g+ny8nnRtaPW3sMvqBtxmcFqcIKnVybxZxpayLb8Qj/wyyF+RYfxlpT
bMNUsCSE2Nx527iKFr8x
=JLDI
-----END PGP SIGNATURE-----

--nextPart27546203.YEUKMYLtc1--

