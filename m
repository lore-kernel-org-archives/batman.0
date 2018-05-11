Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 May 2018 08:06:27 +0200
Message-ID: <9364270.jsCkp9vufn@sven-edge>
In-Reply-To: <CAA_JP8VLAE7pFH+1ztUp+ZUhJGFFeLR_cWHz=tduRFHPAYv=3g@mail.gmail.com>
References: <CAA_JP8VLAE7pFH+1ztUp+ZUhJGFFeLR_cWHz=tduRFHPAYv=3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1986611.qak7bmgOzQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] sanity check please
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

--nextPart1986611.qak7bmgOzQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 10. Mai 2018 01:43:56 CEST dan wrote:
[...]
> I'm running iperf3 with VM1 the server and VM3 the client
> 
> VM1
> iperf3 -s
> VM3
> iperf3 -c 192.168.5.1 -b 10000M -t 60 -P 1
> 
> output is 1.75Gbits
> 
> -P 99
> 
> output is 831Mbps
> 
> 
> -P 99 *BUT* hitting the 'native' LAN address of 192.168.1.1 (each VM
> has an ens18 on this network)
> 
> 4.8Gbps
> 
> -P 99 from VM2
> 
> ~1.67Gbps
[...]

Please make sure that you are *not* using fragmented packets and that you have 
the flow dissector support enabled for batman-adv unicast packets [1]. And 
check your RPS/XPS settings.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/cover/17240/
--nextPart1986611.qak7bmgOzQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr1MuMACgkQXYcKB8Em
e0Yrgg//WAdnNNkLhmFViobn2p2RI2WaOU3HTQgPPZuc9R2RKRXGONEymIOWvabQ
f25eQ29pa5s1mi/84duBfIMbsUE2sJipXaMheMTtHExumHjSaDGDhtJvwrn0595a
ID3OYVFWt6fD6/LjuoTLoNmdWLxriPEHemC4ZF6AtAVB+wmtVtu2o/jHYS393UVX
50yUjw6UClHb0d3Vmk9uBjXT5zSzgak3pntT3xfpyuL321TqolBjCyAdL2sBbUIY
WHKUZ22CeH5VV+dj6qY0TXjbxD7izS+6KZr0WBu4koI5oPKMZJrzkVcUuafLGLlN
3e6/Nv5rCFbQ9cQXIRiSlPnrHdis5BuZ1fgw/1klmZWwLWti4Ykd4t4nJmblP9OF
N+vXeUKObEc9n5ZIvgQ1mAeb8hgu2d1PtlSQAtH2knLOXhoViCEtlZ/Z1EED7Ui/
hkD/KczWfFcZRBgP2wNjIbUQKDdHF7Yl57oZ0cdVAJmd3u4/r7mVawsN2z1wQR+E
tyRutHkuiXkOdOm5AX5L2PlM/5vUkgNT2FnAxob/tOHEk1ofzcdIkjFj1ulRLFdr
XrK3lOUrcpyA/Az7f3JPYzkrO8/Cm6aNtMZOEs2XbndRyjVKtShHxe7V6G9sp93v
zEARF3DJieNADrMNH67WWZWdWPoiKSP1OP7FbLYvIqliNdMK7hM=
=FSP2
-----END PGP SIGNATURE-----

--nextPart1986611.qak7bmgOzQ--



