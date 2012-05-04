Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 May 2012 09:43:14 +0200
Message-ID: <1398273.h5rYArleKn@bentobox>
In-Reply-To: <201205041534.18504.lindner_marek@yahoo.de>
References: <1335690403-25228-1-git-send-email-sven@narfation.org>
	<201205041534.18504.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2354384.yhZfv1Ya2j";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Free local translation
	table on error in tt_init
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart2354384.yhZfv1Ya2j
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 04, 2012 03:34:18 PM Marek Lindner wrote:
> On Sunday, April 29, 2012 17:06:42 Sven Eckelmann wrote:
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > 
> >  translation-table.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/translation-table.c b/translation-table.c
> > index 88c62f1..c3b7773 100644
> > --- a/translation-table.c
> > +++ b/translation-table.c
> > @@ -1776,8 +1776,10 @@ int tt_init(struct bat_priv *bat_priv)
> > 
> >  	if (!tt_local_init(bat_priv))
> >  	
> >  		return 0;
> > 
> > -	if (!tt_global_init(bat_priv))
> > +	if (!tt_global_init(bat_priv)) {
> > +		tt_local_table_free(bat_priv);
> > 
> >  		return 0;
> > 
> > +	}
> > 
> >  	tt_start_timer(bat_priv);
> 
> Is this really necessary ? If tt_init() fails mesh_free() is called to free
> all tt buffers / lists / hashes. This is how the other *_init() function
> calls do it as well.

Ok, forgot about that. It is just became "normal" for me to assume that the 
local function is cleaning their stuff and does not "leak" in error 
situations.

Kind regards,
	Sven
--nextPart2354384.yhZfv1Ya2j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPo4iSAAoJEF2HCgfBJntGWc0P/iMXS7GhRxbkBohW2QHFtYTA
rar/8tmC4QjLcDyL9AYFAW1MVd3pmyOsF0CmMcWoKb9RD6hDOl67RRBvkV+hQrDj
rjnM5aAcMwBB52Q5Ykvu6NC6cT1Uwi9Pi/tlZ4M8fJaGdj28/4sYIkWxc6Q4FDzu
0ydTXXehZXUbmGnDQSF642xBUPRvG7Dm2Ba311wPDuCTVVtln9hNNjiw+wNfDJrg
IX3ugi6FAzPPlV9KVWXX4dxhCNTJTlWXG8nXrk/JkPqVIFXEN9V9i7uzkXxVfkG/
KTDqhVDz+WHG2eKzs7G+k9us2lD0YUN2cP8HwE4Vh7f5U+aalNG9LClGn43tFD/4
xY7LRg56q5C+ZN7qHHtVsBuvmJD5U4hx4aHIykwvfZMB2Gl6nyn2CLG0CodBHDvt
tmh2VgC4E2Clm7Wex28uXBYmPvZDLQCCegtvUsKIRFSL2O9QQTIjb9AdtzQUQAJh
PEuRZ5yRv4tjNbQbBTVZ/699/0pTiO0LkAWAvcHLdDv9cagnSf8vmjOXxfiUN6Lb
a/yV3IGdeD5AJUogTJE8MRcBUz0eJaPK8gmRFtWO6iaRtgYml0dyIcJtLj8dwTnb
1f1IEdzn3Q4Hjr9Mu3YUguHY7mS0CzgAeNfelmizjXQVEexOGz+jMAUE/IucFTxS
mzO31M3r8Xh3gTtGp10I
=Z4Dk
-----END PGP SIGNATURE-----

--nextPart2354384.yhZfv1Ya2j--

