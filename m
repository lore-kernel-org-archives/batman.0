Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Jan 2018 21:52:34 +0100
Message-ID: <2357913.Ue9Sgfg8BR@sven-edge>
In-Reply-To: <6d1b250c047fb4cd3aac72d9e921ed33428fdaf5.1516648598.git.mschiffer@universe-factory.net>
References: <6d1b250c047fb4cd3aac72d9e921ed33428fdaf5.1516648598.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10250524.VYWkRvIPmb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix packet checksum in
 receive path
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
Cc: Matthias Schiffer <mschiffer@universe-factory.net>, Maximilian Wilhelm <max@sdn.clinic>, Felix Kaechele <felix@kaechele.ca>, Mephisto <mephisto@mephis.to>

--nextPart10250524.VYWkRvIPmb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 22. Januar 2018 20:24:50 CET Matthias Schiffer wrote:
> skb_postpull_rcsum() is necessary after eth_type_trans() to adjust the
> skb checksum, otherwise log spam of the form "bat0: hw csum failure" will
> result when packets with CHECKSUM_COMPLETE are received (at least in some
> setups, e.g. when stacking batman-adv on top of VXLAN).

Would be nice to have a better explanation here.

The comment previously assumed that skb_pull_rcsum would be enough. But the 
problem here is that the skb_pull_rcsum only pulls the batman-adv headers. The 
actual pull of the ethernet header (with skb_pull_inline) happens inside 
eth_type_trans. Or did I miss anything?

[...]
> I don't know what the exact circumstances are that trigger the log spam,
> but it seems this was broken forever (I could also reproduce the issue with
> our compat-14 legacy branch)... so please ask David to queue this up for
> stable :)

Yes, this is broken since earliest commits. The most relevant commit in 
batman-adv is:

Fixes: fe28a94c01e1 ("batman-adv: receive packets directly using skbs")

But I would propose to use following in the kernel tree:

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")

The 4.15 release will be soon(tm) and Simon is currently on vacation. So we 
will most likely postpone the submission to David until Simon found a way out 
of the snow and after 4.15 is released...

But it would be nice when some people could test the patch [1] (together with 
vxlan?) on batman-adv or batman-adv-legacy. And please provide a 
"Tested-by: Full Name <email@example.org>" [2] reply when it works.

Thanks,
	Sven

[1] https://patchwork.open-mesh.org/patch/17250/
[2] https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
--nextPart10250524.VYWkRvIPmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlpmTxIACgkQXYcKB8Em
e0b5aw//Ra6Mdw1QcZjwerGT+uMTav8uJPfIbQ/XLdZECug/dBnJ2ZYIESqASaC0
IQeWYOXtDWQzWD4puWgLzhxORYLt9rJpNHqtOqxIBwcVbCcyxy66eYrheHY9Pf5l
Vb0nHZcVBPjzDvJ7/HkZlPglyN2B20O4J/90KWnPN7JTCmUY1A3fpvZo/9q3VZ2R
jsjgsn3u/XERPfVE+KZLzo+weXppoV7tH98zbB3Wx3D509pxlXL6686SXF8fikEm
XehTRxliwEsMbS3Q0FdYCoOn7UxJBFvDdqbU99IxxEYHmFR1dwxt/52X/u6vQrbi
b5qgBczsjYr45WpKuxMAwqGgSKJVNVhCFFCRxRrlzYS/WnQAsMDNAT12vzoFWBYj
D/EbAB0GeE4ZlY5aNIT0l6ArtfUzO0xizjT1p88m4qDz3muJzNLuzLqVgzOF/HCs
U7aILoZR+I4sXCdVQYXH2f3FPM2v+kHZwYNJApNi/d2escLbMVbBibJQB2kYSB2p
WtdVxdKQKXHRiarFf4Bp8P9L8aeIycLjaHz+ShIQ7dAz6xJBwxFq3reBly3kgS8d
xjhWbD9l575dE527lSUP5Dv8NiZUyv9QNppbBr2xeZZAS0n+NDDa5wyZadUWwu29
3QSzmz4DzfiXYC5OI2mpTJUzVHEvYWJqcJ1QIGOBT/xdfzRge98=
=PguP
-----END PGP SIGNATURE-----

--nextPart10250524.VYWkRvIPmb--

