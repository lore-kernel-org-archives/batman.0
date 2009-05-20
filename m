From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 20 May 2009 13:33:50 +0200
Message-Id: <1242819232-614-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Possible page faults at route.c
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

In the handling of netlink sockets is are two small and (probably
always) non fatal glitches. Only together they could lead to page
faults. It is quite unlikely that it happens, but you cannot say
that it is impossible.

Best regards,
	Sven
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAEBCgAGBQJKE+oyAAoJEF2HCgfBJntGsv4P/ih/7xcrweNox8Kv8+OhoWBV
sZ8DcgRI3REqFtZMCNte/P/6ZGSx1hE95NytTo2R767PJF1ZjKX4B45NGf52rtAp
y+5++SGZ6vRPXPDhEF/1yg4i0ce29pgwZJVYj0qXZk5uLyJz2j4RtkPDGuCm4MCd
V7B1V+tVTLOGKLGnJAMEi49F61dRsYNt5tobQKwNxGt6tZVC7CCD7Ze2jA3c2b8r
dGixm+4vQGrV0EEmUS4JoJloOlz9tUI8+ld65urwj5Ep8IpSYBfrjQRbd9oaVtQe
6vRXnuAdZz9nam9MZRm4IqGa5DfNBkd0vXQryy85sxPSuIFti0FtiQI3bGYX8QnV
7ShajIU4JRo4k6jqZX6H+Z65DBahUFrbrfGqip7eOSLUANwtHy4S/0MD4Aw4FU2X
FF6AfsrdiBdT68eVBsxJdXInrAu5UwXBtIwNQm90l8JzT3TOo5pnDGiA7z0fVRGb
IJbTQKqkpZNvf0esyF7PhcEnjwefsP9gdXzuTcqlAday/mX3m73TmMismlM22Id+
eSLLU03Qi+fM3HfmMCk7OlMYXPw47qI+vMX8NGNqh/3MSqXZv8z9BXts89DXjMxs
jDOFX/qZCx0Z5c31DjCH7sxi3/R8rQTSE/AUMLVUrttuGwS/WzE4m/8W/Yu13gMi
ERz3CKiMqSEDin8EyL6a
=ECeu
-----END PGP SIGNATURE-----
