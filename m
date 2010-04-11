Return-Path: <linus.luessing@web.de>
Date: Sun, 11 Apr 2010 02:42:20 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100411004220.GA12727@Linus-Debian>
References: <20100405024603.GA11965@pandem0nium>
	<201004051321.45958.sven.eckelmann@gmx.de>
	<20100405144035.GA13768@pandem0nium>
	<20100405150605.GA15893@pandem0nium>
	<20100407081123.GA2378@pandem0nium>
	<20100410235608.GA12381@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20100410235608.GA12381@Linus-Debian>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Limit queue lengths for
 batman and broadcast	packets
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

And, hmm, yeah, seems to be the dev_queue_xmit() in
send_skb_packet() that needs those 80ms on congestion.
(though I'm still not sure if those 80ms lags are the cause of
the soft-lockups anyway)

Cheers, Linus

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLwRrsAAoJEBKw7u43QNpfHFEQAIKwKjGoVvXfXQKIV0+cqh1t
hNwgAlXodNizhmNaJKFHx68KdVl5nJEgOVnh1xoIFfdc3qUjYFcJouaDIs1UiowE
nJarWoxOpb9n2Syt4KS25YAaCyq5MiPTn2WCPc5GuNUyM5qGzHAVZ3LZddz0dXPk
p4C4m4t3SttPN2uueWz575sgB3wEAfAN6mWedNkV2OkitiNY2xe5Naa0yISUxvZT
Vw1LRBdDRE7JJKiAY01oA9k8KJi7v96HuhlEvoHcsvtjxpgro8OnmOdz+tiuop4l
7ntjyv3bfUTyNzzLmEIH+x/o0n3XOOym5pM3u9GnXgHkum+VL3fVk3QeUqvLOZJj
rcu1uKuGmwQrQc/sduz0tPv6lZpMc0ssSbzj4iZ/3Nzu8bgDNKhnP7N88FjgroNh
X+1vB1SLK0Vw2AaH5GqqDSw1o3loqdDnm0FVKhfiDQlFG6ujDSUwB44dR9hCE6oc
k7f+D18S8usALBWXVUpF6TxhHQ7JCEJYv8o2WVu9itHiOYS4Bq81YcBmW6pPo+Vb
ZDSJnTwyv+ArL65xJ8EdoFnnYjt+rk+B8+Eyqnsmex6/R9Tng74iB43Q4Gc9qbX1
OWwHq40ZVZAx4p98Wxdt84F/Rw3iEhAVDOn1Wg8GuPwht0tTUi10cbwglnE03wLN
GpMyOSVYTciFUgEY9U3x
=aXwY
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
