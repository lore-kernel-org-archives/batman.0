Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Oct 2011 14:31:55 +0100
Message-ID: <1850275.SO2QzbpOTm@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9926235.zVBpP68GlS";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] Weird TTL for ICMP packets
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


--nextPart9926235.zVBpP68GlS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

just looked through some ICMP code in icmp_socket.c and found a little bit 
weird TTL:

218         if (icmp_packet->version != COMPAT_VERSION) {                                                                                      
219                 icmp_packet->msg_type = PARAMETER_PROBLEM;                                                                                 
220                 icmp_packet->ttl = COMPAT_VERSION;                                                                                         
221                 bat_socket_add_packet(socket_client, icmp_packet, 
packet_len);
222                 goto free_skb;                                                                                                             
223         }

It was introduced by dba95eb270ff9674326865a20d25921c69c04d6c. My guess is 
that TTL should be used.

Kind regards,
	Sven
--nextPart9926235.zVBpP68GlS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOrVHLAAoJEF2HCgfBJntGH3cQANd8K/7xzASoL0zeRK//uMuy
t66SY86OAnQ0WRnvnRIdFux2K99HYZLJfE8jWgjKHtIP4KKxGT20Q1e3bH3PfuqD
qi4VzavhXmscIC8Ec6a8trf0usTmdXB8NKAY7ey+wUnVSAdmJ5zTm87aWTWIQ3tU
dTu7VyuVGSbVtO8b9QOCnqyyIEtiSHiFjjWgWm2xV45GU8V4/CFxkTvpOmYFGqu8
rTTNLb+/xg78JddoME2Sa8h82M+1CmybntA1YA4yo6ogb/pPcr6xKAMx0+xaaQzK
vgAUMoeiltaeSDp5qPU4O5DIIXe0vkaS+4WknOM4DoQxK2aEbo8q4RBAd3K/tGIo
fUH+VdEcmcW3H1lMGk0x4T51B3XVeStuzbxwWyyUMKe2pzz7l3qBvzKB8TGFTAog
9Jz4ueopnS5z+hKX9eHdU1Ojs3F4Bb1b+r07uJmIho4HkYWFjso1yxdZKKkXKeYs
BxrJO6zLP8t3Tsp1iQnPYGG0D4aMBlOyP1+0x+Fz+uSbfSb89XYb1pyZpDgU6OPO
KNpc6NuRwsgGzR3vw9hCfNlKhOuAzFPVPObTjzUpXXlQLoHa47ouedoJfgRZI1Ys
CO9RmWd5u/W3a4VMLuqlzH5Q+8l/x7ufk8HjUIcOL4c/L8XQyKTzfMEdqyOD2Wkf
bgC5N9J58/ULOzudG1ds
=Y5qk
-----END PGP SIGNATURE-----

--nextPart9926235.zVBpP68GlS--

