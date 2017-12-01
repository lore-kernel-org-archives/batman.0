Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 01 Dec 2017 12:06:56 +0100
Message-ID: <5326121.NFvn6z0nS9@prime>
In-Reply-To: <20171201104756.4476-1-sven@narfation.org>
References: <20171201104756.4476-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2984230.eyjkFBZSvx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: setup_timer() ->
 timer_setup()
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

--nextPart2984230.eyjkFBZSvx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 1, 2017 11:47:55 AM CET Sven Eckelmann wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> This converts all remaining cases of the old setup_timer() API into using
> timer_setup(), where the callback argument is the structure already
> holding the struct timer_list. These should have no behavioral changes,
> since they just change which pointer is passed into the callback with
> the same available pointers after conversion.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> [sven@narfation.org: removed spatch and examples, added compat code]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Picked this series up into 295ef829 and 258e419d

Thank you!
     Simon
--nextPart2984230.eyjkFBZSvx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlohN9AACgkQoSvjmEKS
nqEqJBAAw+R/0ST1XFe9G9EeWqT7pwtjduJGu5pRH8aVaXE0IU8fCwllthpLPBPV
Aafxy2vyqTejFMxM9lr8f4NvIGook96S5kj4S7TuO3lQygR3PpiUBnePBjOZLdN6
LUKvd+Xi6QtLJuQ9WZ66gfLQsrVvPUYgYeooyf+RhHlqHxIenPnS5vl+KvRKy6OO
lX+/95ovNm1SW/zEfbB+baxcQTMlsY/PFavv3UXO6TCC+oCAbnY+k4nfVWgVEwdK
DjgZfMO/JgxoEWhVWYBc39r6bHpXp8ETHn3eHZRH+/QuEKq/aENZGL+hoFhEkrRx
iqJWrmAdhLnf+bTteUtHVz5yu/pmD/2+GaU89ndXOALcVfrACJmMX6UoM1aDM0wg
xruXCUHj9vVOqTAFt/9/IDuTX3bFjsxEfPqp+saIUs6p5bMdwd1/ovHr2fvpk9Wl
OoAtuTweshemt96/qjvd+/gGDPI150VEw8sYQh1xdp45/ielezI6iK6dvwpnCYhj
S7LMRZYFqUfoWWm+L9hYZ/6vHDsJhBESsYfKqbOVMOWOguaTl+FdslQkFWvQnFzA
gYaD+kLrfDKHxA0sTgvRvrvXA6LXwq5D69DEdL02zSfjoiov6KPx6MUTmAMkZeYs
dX3fHH+uInbfmg19BGArpNzBm4jciz8QbFOQmw8KqzEswcr2/ZU=
=Oc8D
-----END PGP SIGNATURE-----

--nextPart2984230.eyjkFBZSvx--

