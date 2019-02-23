Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 23 Feb 2019 15:16:14 +0100
Message-ID: <6715358.6tb0aJhElB@sven-edge>
In-Reply-To: <20190223140906.28979-1-sven@narfation.org>
References: <20190223140906.28979-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2698641.cCrWaGWegk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH maint] Re: batman-adv: Reduce claim hash
 refcnt only for removed entry
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

--nextPart2698641.cCrWaGWegk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, 23 February 2019 15:09:04 CET Sven Eckelmann wrote:
> The batadv_hash_remove is a function which searches the hashtable for an
> entry using a needle, a hashtable bucket selection function and a compare
> function. It will lock the bucket list and delete an entry when the compare
> function matches it with the needle. It returns the pointer to the
> hlist_node which matches or NULL when no entry matches the needle.
[...]

I had a minor problem with my git setup and thus the [PATCH maint] subject was 
not correctly generated. Sorry about that.

The issue in redmine can be found at https://www.open-mesh.org/issues/372.

Kind regards,
	Sven

--nextPart2698641.cCrWaGWegk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxxVa4ACgkQXYcKB8Em
e0a/rxAAl5qsiKCC9SPNbkGM7bFVHIXFjD9SidVT3VCgDOmWxVmWCL1URvF1EnJy
T8nfEc0D3mvaOhiXZom+DfS128yoQhmDWVX96L8OMr39ezZnnIdqkXkOKy7H9Sz0
6r8X+i/yXBtdsz5hDef4P/1708LKCKuTCpWnHmKP/ubO9ovMZhTgUAb/qBkEA1M4
EWA0SlMN1z3nXzneNPAe6JLiY2MpD4bIODmMtKC1nH08Ly7cuRjDVsnEMRa0iUpT
pazTFTjQYl6Q2Cv3lYNm/D/HFxpe3P0jZQH9UjxFCCS1t7crLhavqvNsdk97bzMW
+xuaExcC/rFdij0YgqvD9McKiwquZpxbwcar1ID4pDznpyF3YSviz/XTg1JYGn7a
6rbowP2m1APjgV23LHYUyMkuDtjhMlU+xOZ0faUpdQqTsvbhs5++53Zrj7Rch1J2
+NrwVgi2PADI/+RJAJyqzMEkVRhKGevANFIJvMqsIw9QfzuaYYoeEYgjPfIcYzWN
+Fo01TNY72uLidWe5HwKCkKCWKb1/dqxcxLI1BIZS4EbiMvM2jk0XIty0afJ6emc
0WxrxnCwgx13p4sMbiuJf4hdxjZaXnXlelxmZoZlz8094eJH1B/z3tdSyOB7eIg2
N2fysk0iLPLUOOaB2pIz+Q5cLCnxjwd3akyoXODlNKIgIr8Jbf8=
=Ky3N
-----END PGP SIGNATURE-----

--nextPart2698641.cCrWaGWegk--



