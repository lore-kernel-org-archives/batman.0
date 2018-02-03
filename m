Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 03 Feb 2018 09:40:53 +0100
Message-ID: <2600801.iuZaCSQALx@sven-edge>
In-Reply-To: <2157409.R7zQT89qM7@bentobox>
References: <0272f809d25b41fcab4ec5c4b66014f5e341d424.1516792897.git.mschiffer@universe-factory.net>
 <2157409.R7zQT89qM7@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2284266.5RCCdCvgJg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: always assume 2-byte packet
 alignment
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
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>

--nextPart2284266.5RCCdCvgJg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 24. Januar 2018 14:40:03 CET Sven Eckelmann wrote:
[...]
> I know your intentions and I understand the problem. But there is the chance 
> that David Miller will reject this patch - like he did it some years ago 
> with a similar (not the same) patch:
> 
>     "I'm not applying this, please try work to implement this more
>     acceptably first." [1]
> 
> But maybe he has now some other opinion because the unaligned problem is 
> caused by the encapsulation in VXLAN or maybe he has a better idea. At 
> least VXLAN encap stuff should affect a lot more net code than batman-adv.
[...]

Looks like we have to assume that David has nothing against the patch and we 
should get the patch integrated.

Affected are any kind of access to the 32 bit values:

* &batadv_ogm_packet->seqno
* &batadv_ogm2_packet->seqno
* &batadv_ogm2_packet->throughput
* &batadv_elp_packet->seqno
* &batadv_elp_packet->elp_interval
* &batadv_icmp_tp_packet->seqno
* &batadv_icmp_tp_packet->timestamp
* &batadv_tvlv_gateway_data->bandwidth_down
* &batadv_tvlv_gateway_data->bandwidth_up
* &batadv_tvlv_tt_vlan_data->crc

I personally would love to hear that there is a better way to fix this 
problem. But either this or something like the (out of tree) hacks from 
OpenWrt [1] seem to be required to work around this problem.

Kind regards,
	Sven

[1] https://github.com/openwrt/openwrt/blob/master/target/linux/ar71xx/patches-4.9/910-unaligned_access_hacks.patch
--nextPart2284266.5RCCdCvgJg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlp1dZUACgkQXYcKB8Em
e0bs8A//YyHrZKnEtqEi3pM61lsIyg0cnwzKSXXYVA/KnQGQBzznjeFYMpUUrhkR
s00OyMNXuo+aai4ejpm2MARwL/jYBy9kweSGhJQh74/iUeJe8Xh7U5V9xh0pDxWr
NVB+c9pK1S9jxE3dK5BS3ms0cV9vPN1bQ6DulrpfZaighEXFxIRyOEmfTPdb9EhJ
fb0luG3v0w96YnHzAZ5O8Efwxr/Jx+/tov1fA6CG9zZUJQEaWIMqXKIE8p9FP6MY
8UpPKPg+ySbD6p9TzJc/0IzQkhw0oTcEyvocPqnQRjwCocpnKOLeLs2ttahDwm3s
TOuajppcGYQNXGzd6Sj3YhVK1tBqaH6yc+qRyfrYWWn+8LZ6+Y93iCS1f5y9NVa8
Kn0cY5UvwlYlr9p9mvpukOnpPqTOqKrA+NBwxp9BLVe9v8NAMmwmLbvvH/dt5t8A
jXICA0TZI+X+jtGJVDxaE6+zfg5eBzyp0zj4vZMYiygMXteAcNqgFmgrjENzVlpV
AjHz7ulJZ7W+zSkQ2Sgztr/NBgCLCw+rgVYnXewVeTCo5dguLiAP+PQirAqwoD8S
3alOhjf5XMfQLh3bhs3a2Yr1vedk/KQsRvLvD9HUK+U5IFbwFAdK9tn2udp3N6Vv
+pSzeh2CZ2fjIHYpVa1iHEyTThERgWGL44IM1hoHR/A+xLCWBos=
=jb+m
-----END PGP SIGNATURE-----

--nextPart2284266.5RCCdCvgJg--

