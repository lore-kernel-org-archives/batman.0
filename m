Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 17:48:16 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11186557.WFDRSgSa2n";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005221748.17663.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 00/26] Staging: batman-adv for 2.6.35
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart11186557.WFDRSgSa2n
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

here are the patches which fixes different bugs backported for 2.6.35

Marek Lindner (1):
      Staging: batman-adv: fix rogue packets on shutdown

Sven Eckelmann (3):
      Staging: batman-adv: Call unregister_netdev on failures to get rtnl lock
      Staging: batman-adv: Don't call free_netdev twice
      Staging: batman-adv: Don't allocate icmp packet with GFP_KERNEL

thanks,
	Sven

--nextPart11186557.WFDRSgSa2n
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9/zAAAoJEF2HCgfBJntGPeIP/jTN7rgP88iZFuE25UH/UBSE
fC5HMLmjkV9wQXeRq+k2YcpFr9mKWbtfzkT6JtlpQ7VTz9JrftbwDX5/soBuLPGf
WopFK49iRG+uLoW3x5rCOSTIubocp9SX6X82TAyEngPkZfHlexZpLX4D4lkqWOEC
X4Kdj3Im22YO8MDHmmkw0WCF3rzKbqJ/0S1VrqIndMhCKoYDJGjdqT2G6jigWh1N
6benj/9UYr5sHD90lBGio3iqNYAaWuWhM0d3bcabCbMvJwG5m7hDrgIjcbfPs5jl
71jhkAEtJ+dC/q8FsxYsFmjL5pNewixXUjvTqUhoN29970XX3VQokKrmr3KX2xyl
igDtb7xJH9NvietjaZF412+OiZUSkUool6FYLZAzi/wEjHIU7W54ORbWEuydUmDh
zhDgCD/jwq9D6S2r9ht011mvQ2Yr66zFlHR3PFcGCBVQYdqiunV98e67qpze0AbE
FqZu1q+a/mR5LmaQ+q9cv2fyrqnxEKVUuzSbD0IbA1LFh2adaFy7Gz6RnucHtHXZ
Fk59cGQ2PYfhuaod9lVeSY75UFauuXryOGaIiDqfnxapdfopHu/P06EzMRAmVSz2
9crN/xnj/7D/rtdFrRuesaOOXfr6t24KfD1kBagKTnxgyNgIpR8XRR4tW3beZvW+
74WmGgsixEp3TNCz+rNU
=Vvy5
-----END PGP SIGNATURE-----

--nextPart11186557.WFDRSgSa2n--
