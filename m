Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 03 Jan 2012 00:10:02 +0100
Message-ID: <3014476.qt0n1BBs4R@sven-laptop.home.narfation.org>
In-Reply-To: <1542912.6mqKHTfaCm@ostrea>
References: <201112252236.22377.clemens-john@gmx.de>
	<2075196.LxuFnsEOfE@sven-laptop.home.narfation.org>
	<1542912.6mqKHTfaCm@ostrea>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2864821.LszklMNjB1";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] HowTo Test Bla2
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


--nextPart2864821.LszklMNjB1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[...]
> I enabled blaII on one node, and after that all nodes connected to the vpn
> went unreachable. Most of them use 2011.0.0, some others 2011.4.0, running
> an ad-hoc iface as bat-adv-iface and bat0, tap0 and ath0(master, for
> clients) as a bridge. Do the blaII-packets "kill" all the other nodes? I
> thought the blaII-packets would have no effect on the other nodes because
> of the compat- layer.

You should use the same version everywhere. The compat layer is only to get a 
version running on an older kernel... not for incompatibilities between the 
different features/versions of batman-adv.

Marek already suggested that the packet format version should be increased to 
clearly state that these versions are not compatible. But it could also be 
that you triggered a bug in the new bla implementation... still I don't 
understand why you are doing this. Which node should detect the ARP packets? 
Maybe you can explain it again to better understand your network architecture.

Thanks,
	Sven
--nextPart2864821.LszklMNjB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJPAjlKAAoJEF2HCgfBJntGEjYP/RLBUIHSsIeKk23KmfGjWCJR
4XfVz2t81pQeUbgEE0BwmSedOOMyuo5kcmMDpfUrCECKlr1MAGy9F6DPzLLKhMDH
4yNbuQXfzpycUCPyNjUMRkvJTDoFYafudQD23FfE5614zUirq5VoD3vn3JmVushe
7DeQBWIJTtz3jfg3uU9ORXIAMswAiEnh2iWP8+Zdv9SJdARkiYCxOMtI/UMAZKX8
0DAwr8o4MLvvBauCyipPtJj/xevlK5NlscrhbdwQjKVp2JSCzulO6H+igur1rcIX
CpX2PTiPnszkRXlXf1xcAWvalWrHwDN82E5GkIFhvn7j1jHQAVHVDYXL0jL6+IWw
FOQm+T0WAGY02WuscVVgEzC1pM/QlChxnrbWNOlNOsYi/pagWNv/a574SiyGLGW4
25ZzoeXqwC76/j61TPxeFngD5M67xUpraW3t3BKvRTPEUdS+bksX9gEZtWhlgTsq
chrYeX9lEkMajeYMtr+sqFTDtYqoLQ5xj55ilHFAMDCwHCL5lJLrtk3qQyEPJ6Qi
jngdXe4/0G7jDtVwBE17DS/cWHcod8H1dAgrT4xZ1lRYVPErHIqEHhrnqFI3i7Di
eK4EV20Qjm1w0iOL4oKloxc0IgHqUohYGMNJ2TSlHpCCwaSC9JnYq5ErYTK3lqO7
3F/GP7KzSA3rEBB9z1vP
=l/VM
-----END PGP SIGNATURE-----

--nextPart2864821.LszklMNjB1--

