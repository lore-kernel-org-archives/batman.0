Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 08 May 2016 21:50:23 +0800
Message-ID: <2303299.t1A4VFrA0t@voltaire>
In-Reply-To: <1462464426-13014-2-git-send-email-linus.luessing@c0d3.blue>
References: <1462464426-13014-1-git-send-email-linus.luessing@c0d3.blue>
 <1462464426-13014-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3854024.9DF3NFemPr";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 1/4] batman-adv: Always flood IGMP/MLD
	reports
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart3854024.9DF3NFemPr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, May 05, 2016 17:07:02 Linus L=FCssing wrote:
> --- /dev/null
> +++ b/compat-sources/Makefile
> @@ -0,0 +1,3 @@
> +batman-adv-y +=3D ../../compat-sources/net/core/skbuff.o
> +batman-adv-y +=3D ../../compat-sources/net/ipv4/igmp.o
> +batman-adv-y +=3D ../../compat-sources/net/ipv6/mcast_snoop.o

Please only compile the multicast compat code when multicast is compile=
d into=20
the module.

Cheers,
Marek

--nextPart3854024.9DF3NFemPr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXL0QfAAoJEFNVTo/uthzAx7QIAJtZoI1KNqEdlHV3pYtjnIgr
41JUaga/sk6+usc6DGfIkjGqAcn+Yr/ixxWmsPuDkygCQxghZ8p79FRTJLI52osc
yhET68Hz19//CLaPi0mXHY9pyx0tNjzXmkmxPh9bNBlgrhJZV518bTTrW4ejqbeg
85Bst5dggOeqiJt+v2g0cQA5Lwo1uDdSNJH4IGZuhBszIsNj+8SuODGdPQmXSYTg
kB9fhIZbLMhnF2Ov5LVILxgQkPtDP3EqPH+8loMGwrx/xQjDgpmxSzhEDHmFW7Uw
5KTx53QPFfQiFYJEuuL/LKEJyBEYKN/xrmFZnueCBL6rsfy41Ks8o6SaNYcs4Oo=
=iU7U
-----END PGP SIGNATURE-----

--nextPart3854024.9DF3NFemPr--

