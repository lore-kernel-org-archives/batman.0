Return-Path: <antonio@meshcoding.com>
Date: Thu, 3 Oct 2013 10:22:21 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131003082221.GC1939@neomailbox.net>
References: <20131001202648.GT11097@lunn.ch>
 <20131002130548.GA24077@pandem0nium>
 <20131002160106.GA1939@neomailbox.net>
 <524D0A04.4090702@hundeboll.net> <20131003081124.GA20056@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20131003081124.GA20056@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] Alfred batadv-vis json conformance
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Janne Paatero <janne.paatero@ruag.com>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2013 at 10:11:24AM +0200, Andrew Lunn wrote:
> > May I suggest that the cjson output includes an entry to tell the
> > version of the batman-algorithm?
> >=20
> > Users might want to do different map overlays (or whatever)
> > depending on the available metric(s).
> =20
> Hi Martin
>=20
> I did think about that, but i'm not sure how. The cjson format is the
> simple bit. I can add an outer layer with more key:value
> pairs. Something like this:
>=20
> batadv-vis -f cjson
> {
>   "algorithm" : 4,
>   "source_version" : "2013.4.0-g6b13699",
>   "vis" : [
>     { "primary" : "fe:f0:00:00:04:01",
>       "neighbors" : [
>          { "router" : "fe:f0:00:00:04:01",
>            "neighbor" : "fe:f0:00:00:05:01",
>            "metric" : "1.000" },
>          { "router" : "fe:f0:00:00:04:01",
>            "neighbor" : "fe:f0:00:00:03:01",
>            "metric" : "1.008" }
>       ],
>       "clients" : [
>          "00:00:43:05:00:04",
>          "fe:f1:00:00:04:01"
>       ]
>     },
> ...
>   ]
> }
>=20
> But how do we determine the algorithm version? For the moment it can
> simply be hard coded. But for version 5? Will the over-alfred format
> change? Will we have a "struct vis_v2" and VIS_PACKETVERSION_2 for
> algorithm 5?

Good question. Maybe we don't really need to export the algorithm version?

In the end this information can be retrieved on the _same_ node where alfre=
d (&
vis) is running by reading the "routing_algo" (sysfs-)file. And we can assu=
me that the
entire network is running the same algorithm (otherwise neither alfred nor =
vis
would work as all the nodes must share the same routing algorithm).

What about the source version? How did you get it from the module?

Cheers,

--=20
Antonio Quartulli

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSTSk9AAoJEADl0hg6qKeOGBgP/ie3gVa44ml/xqAqRffW/tOJ
AO/8xV0xHswpyuvs6ESUHZlxhIvKFT0peEOvqSCIV5chCQsZhCjIrQ7ltehMst9r
CiJxBQNUipO5kioBFL2Q5vwtUHnKajTj90/rJhSInbWVDj7FJHTM3ccT3wTntSr7
5q9AnOdkaoEYOryFp48pG5to7r5aWyvi6TEirQwwofdIVterCXvOKErw6vIsYko3
FVcHp0hdBtLGWkM1b+72p95LFrVy/byfk5EwxSqHqrh1xQNIAe/gW6RgjQ31BeVK
UgxQ1ROErteJarkSv59eKq6dzWLaAffriu1QdTMPSzohqASL9Z/o8scZScssAxQn
B4cefVuTQFvepZGaVJqAlXUeyBwr0pdXvfQau0pJF7NN+9e0uvdXlgSDOSb11awp
uEQOS1dr33r8UY3PlwaYwlmd4NBk5YLntRUlT1fsU48UWmT0OspSVgA5JDB4RBkD
vfGPqnuZ4pUPToHUcY8js5wA+Z6Ah7BzjHaaL9k0jbLOMbL+dXLSBbwANr2Yg4Ks
7ifE02vzpuu2HgZM18qCcqmTIZsF2dU1Z+Ojj+vpKGC+GwG8JS73eBhxv/5Qk/KA
5ORGadOBPJ5JcEzhA5S0UwYixA4VFLHjv4z2k5o7Uq8m9KNWhMHXQko2y4sY330d
e+euWJV2TFa/UWtb4DjR
=8tvM
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
