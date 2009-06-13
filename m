Date: Sat, 13 Jun 2009 20:36:48 +0200
From: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@web.de>
Message-ID: <20090613183648.GA4943@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] bat0 looses IPv6 capabilities when inserting
	tinc-interface	(BATMAN-Adv)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm having a tinc-tunnel with the interface named 3micc
over the internet here which is in "switch-mode" (so every
tunneled package has a complete ethernet-frame which makes
batman-adv able to use this interface for OGMs).

When I'm doing the steps in the following order, then everything
works fine:
1) sudo modprobe batman-adv
2) sudo ifconfig bat0 up
3) su -c "echo 3micc > /proc/net/batman-adv/interfaces"

But when I'm switching the steps 2) and 3), so first adding the
interface and then putting bat0 up, then bat0 suddenly looses its
IPv6 link-local addresse. /proc/sys/net/ipv6/conf/bat0 vanished
(but ipv4/conf/bat0 is still there). When I'm trying to add an
IPv6-address manually with "sudo ip -6 addr add
fe80::2ff:e3ff:fe85:b9ca/64 dev bat0" then I get the response
"RTNETLINK answers: No buffer space available". But dmesg shows
no errors. This problem is reproducable, I've been doing a sudo
modprobe -r batman-adv a couple of times and repeating the steps
stated above.

I'm running batman-adv-modules-2.6.26-2-486 version
0.1-7+2.6.26-15 on Debian unstable with the same kernel-version.

Cheers, Linus

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBAgAGBQJKM/HAAAoJEBKw7u43QNpfg9cP/2PTvLLci4jRZX8E91Zy4BHh
Z3irY8mnxlDI0fiWzCG1cTFdhja2V9Xz7ptSGpOf3xc9kkaiS9laDo72mwN4TaLL
F/DFaLCsL2KDKlPeAQ+UfY5oGfZCGtezGr7YokUgI+wN2rSnFr1l30C62Z6o0Zai
S7HHVu00OwEtBXp06LbSxZATH1QTm7al9C55uNalZy6DVRtH6Ipr9HpHT8O63pXH
ZnVsq+KH2dtBIgm04ypWpmJdfguGbeg9ZE1c0sARAm+mlNkI5mXdjegd2HBLFJRB
omE0u851Ce0QgDfNjSt1paf71G2nOPWrxctvRpeYtnPS/aSzzSyPA5400qDlgruF
zdMzvc6ybzcVzPRhuCi3jg1eoa2Hx8J+PMYCL9ACAU1N4HX8uBiJOzh/nfanXGvZ
U6AO6KgVWMKoxtgwA0NgAxlPyLcpfw6h3tLAxVRPJZZzDtUCFMCO3S8EVs8TtRH7
Z31QM8sb/HXhSZFSDkODZJ+vMFcPKb8/naz3AMR+I9LULJrr+TMLSeYht+Cgia7g
9cVN/rx4or/UqdknGGqkDn5Rw4NzozIyONs7advjchiEReZx3YD8SnUJOyHxVVTX
+YCtnLjWqo7m9oaM5O8xu+TXcRmhwCz/8O4zdxJYP/2cgnZDfe6vx10AmtUSWTuU
ql6wdAmaCj+yS3a2QNpg
=mTQL
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
