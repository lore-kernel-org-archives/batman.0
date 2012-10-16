Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 16 Oct 2012 15:05:50 +0200
Message-ID: <4628598.0JAcKPgsKO@bentobox>
In-Reply-To: <14969_1350392034_ZZi171PvmcSCs.00_507D5688.1010203@uni-bielefeld.de>
References: <14969_1350392034_ZZi171PvmcSCs.00_507D5688.1010203@uni-bielefeld.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1821452.DhukCXtuGL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove footer from
	originators list
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Moritz Warning <moritz.warning@uni-bielefeld.de>


--nextPart1821452.DhukCXtuGL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 16 October 2012 14:43:52 Moritz Warning wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This patch would make the output consistent with the "batctl tg" output
> by sending no output if there is no entry to be displayed.
> 
> The intention is to make it easier to parse the output using console
> facilities. Of course you could use grep -v "^No" to filter out this line,
> but that would be ugly and somewhat harsh for low performance machines such
> as routers and big tables (I haven't done benchmarks in this regard).
> This also helps the intention of the -H patch
> (https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-October/008143.html
> ).
> 
> Relevant ticket: http://www.open-mesh.org/issues/165
> 
> Signed-off-by: Moritz Warning <moritzwarning at web.de>


$ git am -3 ~/\[B.A.T.M.A.N.\]\ \[PATCH\]\ batman-adv_Remove\ footer\ from\ 
originators\ list.mbox 
Applying: batman-adv: Remove footer from originators list
fatal: patch fragment without header at line 5: @@ -467,9 +467,6 @@ next:
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001 batman-adv: Remove footer from originators list
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
$ patch -p1 -i ~/\[B.A.T.M.A.N.\]\ \[PATCH\]\ batman-adv_Remove\ footer\ from\ 
originators\ list.mbox 
patching file originator.c
Reversed (or previously applied) patch detected!  Assume -R? [n] n
Apply anyway? [n] y
Hunk #1 FAILED at 467.
1 out of 1 hunk FAILED -- saving rejects to file originator.c.rej

Please read

http://www.open-mesh.org/projects/open-mesh/wiki/Contribute#Submitting-patches

Also make your patch more clean by also removing the batman_count variable... 
And don't write things like "This patch would....". Relevant documentation can 
also be found in Documentation/SubmittingPatches

Kind regards,
	Sven
--nextPart1821452.DhukCXtuGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQfVuuAAoJEF2HCgfBJntGAtMQALeU0F8yhVGGJPRne1yp1Fqu
ApQdU+7/t048cqnb+OMiKTHgUqjJpjgPHaPf5xEuuvxVW/FjUqW9sH3wLY7aditG
1YASobvc5FzlzkH778c9jLlQ7AuvlRM7/Xzb2LYMAZQgf9HOkqrp2RFqaPMTpm+t
oeprIWBwTq90ySIKhdKlUa9KcoUKXLRzpwwM/1Wpf9d60rhuDpkwulLSksqYfp9h
DNapdiY5t+GDbvs7Wfzg5CemK+OWtOQYcY9PoXjMGiyMDQ3w9a0ex7E2Vi6lBJgt
1105w54eDD6s1M4VjVjhfl4uZDxsAshH189TL8pF+370xrI1w95JNbzWA+EwP+zk
3AB+q8KaSvDr0CE0dxiguFlntFPCl5ZuoVNVr2uP2qm9CVxG/9NPvQOReXicUKMA
hRKap5Q0s+QfRzi9LGT+Mk6D2Ze4GpcJcZ96sWcjTtoHyZTfWt2av6VbBBLntZOx
dMGkiB7lNGNFN/jwnNI+4s2JiomveSRYcjoOSaTjTN7NvzCtg/GivARWO9tP+9br
RiVb1vWBWoXH1wEEt+mOnAWp7K9OBmkWeGLMEdrA5WumP3JUbTcj/jxOSkSQWfyl
l+wX0eo+Pwt9N/8iCx19I1znNrsmdmp4hce7tf36iclYtN0oM6VLzj41OMbHZ4LZ
o+4GkbXdqLhV9taRj7PP
=l/qM
-----END PGP SIGNATURE-----

--nextPart1821452.DhukCXtuGL--

