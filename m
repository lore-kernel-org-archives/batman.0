Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 14 Oct 2016 15:33:40 +0200
Message-ID: <5907468.ynQUs4eAc4@prime>
In-Reply-To: <20160923140013.11941-1-sven@narfation.org>
References: <20160923140013.11941-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8390591.DlJV02Henk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: vis: Fix direct neighbors
	detection with netlink query
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

--nextPart8390591.DlJV02Henk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, September 23, 2016 4:00:13 PM CEST Sven Eckelmann wrote:
> Only entries in the originator table with the destination address equal to
> the originator address should be handled by alfred as actual neighbors.
> 
> Fixes: bca55a86fecd ("alfred: vis: Add support for netlink")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision a3fb7d0

Thanks!
     Simon
--nextPart8390591.DlJV02Henk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYAN60AAoJEKEr45hCkp6hGHsP/RGrp59hfaGqk/d4RT1vTM+O
rLRMVEXVH/TD8zrR8LzPNqBg/BrOhXmHf7Cg+IXlcSnGzV7c+9rCuWley6YtI1yB
PA1AVBWVYrsBS9v5Yhye0i16mhX+Oyu6jeqygEcc2zfyI0pQM6rO/macXDvgn+2v
uMoJlv8qPczvLiZ9Gdb7JkrHbbCoItxE0qm31rOw4Cj/V1snLXVJIeRH2sApuT9M
gnM2TN5k3jpPHCJpBoes2rGh0PzO+fsppoSfCgUC7A8suYdQ4X1C5o86nG3JWkyq
jqMlQb8qaPRq27JqpM1a0Wrdx5JDP5W85FVCpqlqYREBsBVyvUMVtbB/vaeSwJ3M
RSfWPN2qmd+6pORfaabKmiblrrC9qumq51l/5VYd+ERKqq+NNcm1h/BEPUe2MD9G
NVD36Jzq1qL9ilza6djAUFTZYFS5rZopLPy2jEc/xlKYME7UR2JQwQ0UFBoDR/nw
8Ulh/SnAusjYr5eG2Y+ngt1zVSc9R6p3JXe5iSyja4fDu0iqJghM6ip0DAG4eePx
g0MEP7m61V7ZTOa/ezz/VFCKVC7pTIqKnU9yy0SZVoDyGmn0zMu4lEC73LGcHTjp
p1eJ9lEC8+ZMde86F0hctQ85fvDOguqXnchmodrBGLB/6PQUQEE6qjazwDdkF0YX
Guh4rg18tXRbnZ9v9mPR
=qYjb
-----END PGP SIGNATURE-----

--nextPart8390591.DlJV02Henk--

