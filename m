Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Dec 2011 15:08:18 +0100
Message-ID: <1369817.AM08eCr9Ym@sven-laptop.home.narfation.org>
In-Reply-To: <4EDE1CDA.1020401@agblab.com>
References: <4EDDE473.5020008@agblab.com> <4EDE1914.1030601@agblab.com>
	<4EDE1CDA.1020401@agblab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6071117.kE9GqYc9Pd";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] TT inconsistency problem (again)
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


--nextPart6071117.kE9GqYc9Pd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday 06 December 2011 14:47:06 Marko Panger - AGB Lab wrote:
> I have to add that I had to modify the 'translation-table.c' file in
> order to build the version I'm using. I was facing unresolved symbols
> problems when loading the module due to the crc table. Thus, I added the
> crc table at the beginning of the file. However as sometimes the ping
> work I assumed this is not the root of the problem. Other than this no
> modifications were made to the sources.

It looks like a problem of the wlan hardware/driver (just by scrolling over 
the log). The pinged node only receives broadcast messages but no unicast 
messages ("ICMP" is unicast in this situation and OGM broadcast). This is a 
first guess. So the node cannot request the changed table (thats why the 
inconsistency problem doesn't go away) and ping packets don't get replied.

Kind regards,
	Sven
--nextPart6071117.kE9GqYc9Pd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO3iHSAAoJEF2HCgfBJntGOmUP/A1uLzvkD3TJVzx0GN4O326i
YzYJEVYDdFviH+L+bBBKtrBZ2Ozkif8CU7E6ej4vVEhzGMuBw2QBBibT5rV56San
PMHXwWlSnP+V9bIMxdhtINWo9ERdkFBuwIWaYwZlbmZaWBmXLNaSm1vs7qEsG5L4
nsT/6+QEFkJCaw/t635kE8j+y5A4eT/81vxUl+KMczMmoKFku3D0fCPqifN7Yydj
qg7UQwONlzFIUCbUdS6lHpUUd0FFAHWbvfDwm/ky34BfoCDF3B7edBZ7mmVMziVm
raml3vq1H6R4Jmqh4qUOy0pAkuRV8h2WMkuht0qIrZ3y3E0esrGf3AmGNxHHQWN/
WbGYnF5EKFuAVH0dds5ZDf+TUdqy3tWI2T3cuXRvh6gjtaQT8o5ITqGy9JJJGv/G
H7k8S0YdhRLSIHBd8M9gw4Ro0tjQrrqm2SldQWS+vzIbIPh32P0AKeUJF9lxoeW7
AjduvPPSWdxQvhqgq6VLV/jmfZowYsadF/kTSWu0D8ZDtYn2ACRzf4kbRiBWVdhY
qUAVj8180gzRsJqFy94kdA+VY8QDXd/NCSK61auGI2bgK6NWXaCw3B9OdWoam+4B
2+0zvgQkooNpOPBsxHLz+ZfbPLOj8w/x5c4Z1/M489zd5bDpiIWUX9Rwx5Th4w7A
JLShu6oWf97fZSkFZwhK
=9n/F
-----END PGP SIGNATURE-----

--nextPart6071117.kE9GqYc9Pd--

