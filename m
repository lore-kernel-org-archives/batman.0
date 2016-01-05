Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 05 Jan 2016 10:18:13 +0100
Message-ID: <2497876.2g5VJPj16H@bentobox>
In-Reply-To: <20160105050208.GX2823@otheros>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
 <20160105050208.GX2823@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8965929.rL0FbF2Cez";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 01/30] batman-adv: Fix list removal of
	batadv_hardif_neigh_node
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

--nextPart8965929.rL0FbF2Cez
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 05 January 2016 06:02:08 Linus L=FCssing wrote:
> The whole patchset looks pretty good to me.
>=20
> Checked all patches for bugs but couldn't find any - could only
> find minor style issues.

Thanks for the review. I've already started to fix the stuff you found.=
 I will=20
submit the new patchset (v4) later.

> Did not check:
>=20
> * Whether "Fixes:" tags match
> * How kref compares to atomic_t under the hood, whether it is
>   currently basically the same or whether a switch fixes some bugs

kref is basically a wrapper around atomic_t. So it should not fix any b=
ugs.

> PS: Just to clarify, patch 10 is only a style patch, right?

Yes, it is more a style patch to make everything more consistent.

Kind regards,
=09Sven
--nextPart8965929.rL0FbF2Cez
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWi4pVAAoJEF2HCgfBJntGeJUP/2wEvKEvBwWi0zozTOmfmhGn
TaV33ZdsOYvGl7KyDc0pqXjuu1UFYnCKr3xzK/OH9bBDxnCGc1LvkLfujiAct9Op
RrMbGGBc9KU/Wu4AYuqQF4dUKcJGpyruj+IzMMw6235P4hgAQkAwvVY/Z8kBKSP5
hesdlKhb9Bg7zpOo116oAMF8nBph0oJJZ7mP2hVhSwoBsBYkaM8md+OrOYxrxYbx
+pI2MyshxGWzHvI3yAkuf9Pq6wx5iCpZ2fuq/R/jPyNEBej35aMr0Ow7fPZCu7YV
NYBseDKpNjl466QpFoBdH+EWiigYeBevYK2OXcr8kSmhYJ6dHLWd/7qdj0Vvf0p6
Bed+HJsPgSPBA+FJOfjumolcc6FTfQRosr294SvJZq4Po8XyTkoZxd8JaSndWQpt
2stLgC3in3BvgXfMhguNna/EhMu0yuvqQsQfgYJOo+Nkf0XTGlQp/C8ENgU2kRs6
oVJjsdtjZ+b7+QZK2LAkVhNlLRu00zkfcNSw0xyGBltm8a5qs3wHDtVmVS1JZ7AH
V2dSpQEG0YltLlDmn1KwDRm2cpMDCl509ru9zBWiWuB8bPK4e8heu2/k8VOes2uS
JbfyB8KgZ+5KJz+QazO8NO3dy5oZ+7MuXgRQHfNgtL3zm4LRJbkik2Clbqi0iP07
M8YodQ9FOynj4KWqqC5z
=oPzd
-----END PGP SIGNATURE-----

--nextPart8965929.rL0FbF2Cez--

