Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 May 2016 16:54:56 +0200
Message-ID: <2079546.oo0Mk8DjMd@bentobox>
In-Reply-To: <1462190269.1971.52.camel@biplane.com.au>
References: <1462190269.1971.52.camel@biplane.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4315833.RQY8NmSykv";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] mesh losing internal Ilayer3 connectivity
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

--nextPart4315833.RQY8NmSykv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 02 May 2016 21:57:49 Karl Auer wrote:
> My apologies up front for a newbie question in this apparently very
> technical list. If there is a more appropriate list or forum please
> direct me to it.
> 
> I'm running batman-adv (Chaos Calmer, r47065) on OpenWRT on the GL
> -AR150 platform.

Are you using v2016.1 or some older version of batman-adv? If you use 
something like v2014.4.

What kind of layer 3 are you using? IPv4/IPv6/...?  What is you current 
configuration (for example are you have enabled DAT, BLA, ...). Did you check 
what exactly goes over the air and what the device (the adhoc one) 
receives/sends? What is what the data sent/received over the batman-adv 
devices?

Did you hardcode the mac address of the batman-adv device or are you let it 
change to a random value on each device creation? Is the device part of a 
bridge or is the IP configured directly on the batman-adv device?

Are you sure that the conntrack for the masquerade over the mesh isn't broken? 
Why are you masquerade over the mesh anyway?

Kind regards,
	Sven
--nextPart4315833.RQY8NmSykv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXJ2pAAAoJEF2HCgfBJntGmEAP/ien+ZlERlsMUnAjwSr28d6J
QA31lS+JUsK4sNihezqd0+4bu0ByEPJ+PmiqJEKxPJ0tSuIuy8x8gyULjEfqQkh7
lPLBaeVSiUhBZ9tVLSSv9hZjikhKkyETMUOS2RipHN4q94p3bx2aLPdgxOaJOnRu
ZruNTjBpa1xfNMAqi0O2Ds4ztMzvpWG0xTvR3w2rGbqbAXMRynHvq4PTX++eg+HU
UPb77Ut2uvcOiLCAZW9BhLKspZvg6IUiNvoU3unUlBOy0fClTdseQk75uL7wkAZU
e39mR07efFLpv8sUAMTwm0s/uOQMmTIhr0aC+BdmmDYtQOZ2emledRAhRAjOGQGO
s1dGCxGa0O1fo3iZlMdx6Ou8Q7BYChXIDJgEZMsgJYhUCjmlgx0pLpoeSZ/y13QV
zgWAYGzqznTgfowboqXUIWbbfNl1mD3zOSMS5NWoyMl6Uc+UqKnq6w0IwMDo4OYx
1yI8QTn/j5oiNbYxvJ3v+R1QN2JYlU4j2kp+hj3l4DnZhgFOtlqbWf05f0G04/qJ
5TYLW+DU3oSPn+xwemPw+ufet6dVdG00JDRcvSvDL9+oTnGynDnbjkZ8HL/uF6Mr
wl73GZ0MifPgadfeCYufexdzbXK+sZ+vC2LVh3mTaJnGu+HkOeFvloItsH/mJ2hC
HRoSaNU84eHeLCbjKbtg
=7pJJ
-----END PGP SIGNATURE-----

--nextPart4315833.RQY8NmSykv--

