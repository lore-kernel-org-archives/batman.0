Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:30:44 +0200
Message-ID: <2411339.8Jrj2ahkEz@bentobox>
In-Reply-To: <1473928860-30519-1-git-send-email-apape@phoenixcontact.com>
References: <1473928860-30519-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1553468.GzlZJJp77s";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batctl: optchar variable uses wrong type
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andreas Pape <APape@phoenixcontact.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1553468.GzlZJJp77s
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 15. September 2016 10:41:00 CEST Andreas Pape wrote:
> The variable "optchar" used char instead of int leading to a non
> working batctl tp command as the while loop parsing the tp
> arguments with the getopt command is only left via the "default"
> case leaving the tp subcommand unusable. Using type char also
> lead to a compiler warning.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> ---
>  tp_meter.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied in e397137aa9f4417ec21b4ba3db59b4f4e55b72fd [1]. The commit messages
was slightly modified to (hopefully) make it more readable.

Kind regards,
	Sven

[1] https://git.open-mesh.org/batctl.git/commit/e397137aa9f4417ec21b4ba3db59b4f4e55b72fd

--nextPart1553468.GzlZJJp77s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhX0AAoJEF2HCgfBJntGq7YP/3R4P/B4dLfvnGBuj3HPFQld
oL6N80sdzfFMUdqSaoSuuCrOEOb8WaJUxrl+3cffT8z5rW4pOcfeGofg2yN0aDHK
ciuDKVI5GQk5TDfq09hnJaS/dRFd4GdVv87WrHV6ih54dMUBxXgjJgjXDZ0y6gkR
k/VDrlR3EjdtqOSqHcFVabf0flZksYL0ake8xWXmTU/I4J8njohUCDvgpoBUi4m5
1gBspxoTikBD/z/gAClMjj/vhYnJZ3W3KcVKsYWDaL3OJozz+ha1FUR0yHefCnZl
DR/rUgt+4IGDPGIvD3FhbMqFpnEfCdjmQ35qUirnaGL28ossNqbIQldFdBYXVxwp
osMewOYmDgFE109gLpLPEKzbPz/1cdooYWds2vNiuRU+Zby/p2DWrgyEdwZ/Mgbw
9nCZttZxKaqufheskRzdAcRYOQdGJAS/uqCu1ZLdX7pemq0sNFQj6NpY0dXTs3mx
wITzs0VPX9JnmPDXv9+CBvpsNmHj6IkPY6a1AfEStb2fLNA1FHNYl/WzpVpTgcP8
C3rUdOt/wPwwwCez+MWQbZ7A0UNU2fuYCH5WgozO8QdW6DZCWfNQd78xzYSMglfQ
QEAN4KAXrG8x99GcaHYJBM9nMMqf0+S6BHRh1B0vEq6dE8KfluCJCiD8m3dETO8e
oMaup3b4e5FSYO54XAtT
=PaYy
-----END PGP SIGNATURE-----

--nextPart1553468.GzlZJJp77s--

