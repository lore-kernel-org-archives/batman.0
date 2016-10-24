Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 24 Oct 2016 11:56:35 +0200
Message-ID: <2154828.J4DYXdbl73@prime>
In-Reply-To: <1468782245-12985-1-git-send-email-sven@narfation.org>
References: <1468782245-12985-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1829671.o0LugPh1kP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: use consume_skb for
	non-dropped packets
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

--nextPart1829671.o0LugPh1kP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 17, 2016 9:04:00 PM CEST Sven Eckelmann wrote:
> kfree_skb assumes that an skb is dropped after an failure and notes that.
> consume_skb should be used in non-failure situations. Such information is
> important for dropmonitor netlink which tells how many packets were dropped
> and where this drop happened.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied the whole series in 59426a7..69fd4c0

Thanks,
     Simon
--nextPart1829671.o0LugPh1kP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYDdrTAAoJEKEr45hCkp6hX4MP/j2pLrRjbzPWgtYlYB/uvx53
qPoPAOcedMcWdoDx/0B+HRmUOdNsdWJa9qrSc8K6oMu/OJW+LXM6bI7i1hhGj7Hz
94dvv0s/M03Wcpx6j6YpUJCWpmPOGlNuRJBlGgZZj7eT3P6LtFAO4nA8Z8WK16p/
repIBr32e+z56plOXoEj1DZ2O2n3a0YeDXOdKkN1xEAbKHLYJNSkZTYYuoKcQuNl
o2JRmdAFrSY2bSQE2VrM5mKcYmoyp3hJPLWpuzmDXMKvSu8S0NjjvNx9V1flzeOM
/cbkxEdrcUu1erqsXk+Ut2P4/8UqHXh7riIbheu9KEwIow2LYCylQwLeQFyE8G1H
pQufsoMOsVhWFVQkscjpmXbm/29f+PgMiboSi21hK3TapSQiXCw+a7YjzbJOwa7W
zlT/8s5J049bBjVDKo4BIwlgFSVDwauTOzbV4ZFQ+84th5LH9Mnc3qeyVt86s2bt
wG2wi0SN1Jp7J1D+6tAao0fWdFF/AOK3s370Ob4PXO/C06Dd8OmgEmFC1YiC1Ej3
R/K05RfOMrizh7TJtM8Gy5LhEB2F9fZRf+TWbjwgcCLznPc0Dud+JeFQ7S4S2hm8
I4DfwZ1VCPNiLTyu0NYDgC0nPdrb6RLnfjwWXyjoj5f73wqPmz/xHwYrCdJegE2G
rnck8BW5u3RleR08viBl
=nx9B
-----END PGP SIGNATURE-----

--nextPart1829671.o0LugPh1kP--

