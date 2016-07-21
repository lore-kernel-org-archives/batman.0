Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jul 2016 23:59:30 +0200
Message-ID: <3501664.k16G2TetvL@sven-edge>
In-Reply-To: <1469137112-24094-2-git-send-email-linus.luessing@c0d3.blue>
References: <1469137112-24094-1-git-send-email-linus.luessing@c0d3.blue>
 <1469137112-24094-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1763163.b9YGpZNZ2b";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use own timer for
	multicast TT and TVLV updates
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

--nextPart1763163.b9YGpZNZ2b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 21. Juli 2016 23:38:32 CEST Linus L=FCssing wrote:
> -       struct hlist_head mla_list;
> +       struct hlist_head mla_list; /* protected by mcast.work */

Protected by a workqueue item? How?

Kind regards,
	Sven
--nextPart1763163.b9YGpZNZ2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXkUXCAAoJEF2HCgfBJntGCc0P/1ubaw1/RG795/Lwn03BXtOH
TukxN9a3C0R24nBOlb8xa4ScP78ghZ46l5ON8pT1VtdngGktscr7lbG5PujYvkiL
w7G9nABx8hriQLpX5ymEsRU3KPrMqxCnSgncbgaeBjg3Nj7o89c58vJneEN84saz
6YY2RQEWU5WOGCFKnmwdrqhc1l/UmQVzDxRZlbB02wOvg3qXll/EpaiX092J1ZHN
oRax/v215YbDYSZnHjzRQ0P27tNGJYCG+zxU5WGC0zaaRiFejxyG14fzECHVBQZX
J1KA2R0eq0YzpCY81EFb1EufLC2K4Z8jsJmpJa0WARHiuvFrzt+skOmd1X/nuWfS
/VKOSy6hA0+Mfk0eYjAK0w+3gcV6ddrgk5qY/MbWgXpsSp1rmiMUebwjOviXIGMF
VtttLSAmN/wWNtWvWuw7Y8+NtWhbBk2SECtOdF8pgbYnRy7kt9FQu/Aqk44zOfkm
dQjdHoKO7xDZm/u375z+KEJFCrmM6M3lN41dzmYhTeX7KKKMvgAui0j9ekGPIOel
2elzDoXqIng41nVswoSKZNitPX1cxAAPo1LxuT0d+G0lqP4c5O9jxOMBy+bUQgkJ
DTwtDGUcJmx1XiJ8aWIB3SvVf98kkg6r5AHK5cePeNnwxieQ4F9qikUO+AaR0hD2
NwufQusc+KPhJrVMxk+s
=Icbf
-----END PGP SIGNATURE-----

--nextPart1763163.b9YGpZNZ2b--

