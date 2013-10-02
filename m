Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 2 Oct 2013 15:05:48 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20131002130548.GA24077@pandem0nium>
References: <20131001202648.GT11097@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20131001202648.GT11097@lunn.ch>
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


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Andrew,

On Tue, Oct 01, 2013 at 10:26:48PM +0200, Andrew Lunn wrote:
> Hi Folks
>=20
> I will soon need to parse the output of batadv-vis -f json.  However,
> its not really, json, it does not pass json validation tools. Hence i
> doubt i can use the standard parsing libraries.

Yes, it is only JSON line-wise, but not the whole output. This output format
however is the same as we have/had in the batctl JSON output which comes
=66rom the kernel (I think that was your contribution in the first place?).

Therefore I'd like to leave this old format as it is to allow communities
to seamlessly switch from batctl json vis to alfred-vis.

>=20
> There has been discussion similar to this recently, about alfred -r,
> and a proposal to change the output to make it json conforming. I
> would like to raise the discussion of modifying the vis output from
> batadv-vis.

Regarding the other discussions, I'm still waiting for new patches from
Nils. ;)

I don't want to "parse" any transferred data in alfred, but we can do this
for tools like alfred-vis ... And yes, the default json output is
currently not JSON-compatible for binary data...
>=20
> I have a simulation system of four nodes, fully interconnected, with
> one double link, but is rather sort of translation table entries. The
> current vis output is:
>=20
> { "primary" : "02:00:00:00:12:01" }
> { "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:10:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:13:01", "labe=
l" : "1.004" }
> { "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:11:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:12:01", "gateway" : "8e:4c:88:c4:76:c5", "label=
" : "TT" }
> { "primary" : "02:00:00:30:10:01" }
> { "secondary" : "02:00:00:00:10:01", "of" : "02:00:00:30:10:01" }
> { "router" : "02:00:00:30:10:01", "neighbor" : "02:00:00:30:13:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:12:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:13:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:11:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:30:10:01", "gateway" : "f6:00:48:13:d3:1e", "label=
" : "TT" }
> { "primary" : "02:00:00:00:11:01" }
> { "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:10:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:12:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:13:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:11:01", "gateway" : "ee:be:f3:0f:26:66", "label=
" : "TT" }
> { "primary" : "02:00:00:00:13:01" }
> { "secondary" : "02:00:00:30:13:01", "of" : "02:00:00:00:13:01" }
> { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:10:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:12:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:30:13:01", "neighbor" : "02:00:00:30:10:01", "labe=
l" : "1.016" }
> { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:11:01", "labe=
l" : "1.000" }
> { "router" : "02:00:00:00:13:01", "gateway" : "8e:4c:77:b3:65:b4", "label=
" : "TT" }
>=20
> My first suggestion for a conforming output would be: =20
>=20
> [
>   { "primary" : "02:00:00:00:12:01",=20
>     "neighbors" : [
>         { "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:10:01=
", "label" : "1.000" },
>         { "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:13:01=
", "label" : "1.004" },
>         { "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:11:01=
", "label" : "1.000" }
>     ],
>     "TT" : [
>       { "router" : "02:00:00:00:12:01", "gateway" : "8e:4c:88:c4:76:c5" }
>     ]
>   },
>   { "primary" : "02:00:00:30:10:01",
>     "secondary" : [
>        "02:00:00:00:10:01"
>     ],
>     "neighbors" : [
>       { "router" : "02:00:00:30:10:01", "neighbor" : "02:00:00:30:13:01",=
 "label" : "1.000" },
>       { "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:12:01",=
 "label" : "1.000" },
>       { "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:13:01",=
 "label" : "1.000" },
>       { "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:11:01",=
 "label" : "1.000" }
>     ],
>     "TT" : [
>       { "router" : "02:00:00:30:10:01", "gateway" : "f6:00:48:13:d3:1e" }
>     ]
>   },
>   { "primary" : "02:00:00:00:11:01",
>     "neighbors" : [
>       { "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:10:01",=
 "label" : "1.000" },
>       { "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:12:01",=
 "label" : "1.000" },
>       { "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:13:01",=
 "label" : "1.000" }
>     ],
>     "TT" : [
>       { "router" : "02:00:00:00:11:01", "gateway" : "ee:be:f3:0f:26:66" }
>     ]
>   },
>   { "primary" : "02:00:00:00:13:01",
>     "secondary" : [=20
>       "02:00:00:30:13:01"
>     ],
>     "neighbors" : [
>        { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:10:01"=
, "label" : "1.000" },
>        { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:12:01"=
, "label" : "1.000" },
>        { "router" : "02:00:00:30:13:01", "neighbor" : "02:00:00:30:10:01"=
, "label" : "1.016" },
>        { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:11:01"=
, "label" : "1.000" }
>     ],
>     "TT" : [
>        { "router" : "02:00:00:00:13:01", "gateway" : "8e:4c:77:b3:65:b4" }
>     ]
>   }
> ]
>=20
> I'm also wondering if label and gateway could have more meaningful
> names? TQ and host? Also, is TT the best?

Hm, that is a good question. We also have the batman v with new metrics
coming up, I'm not sure how to handle these (maybe Antonio has some
idea?). It is not the TQ-value in the label after all, but some kind of
ETX-converted value (255/TQ if i remember correctly).

Maybe we can change the names to:
 * for neighbors: router->nexthop
 * TT: "gateway" -> "client", "router" -> "node", maybe also change TT to c=
lients?
>=20
> I would like suggestions and comments from others with more experience
> with json. Is the basic structure O.K. Are there better names to use?
>=20
> There is also the issue of can we change the format of the current
> output. Is it considered an ABI? Should I add a third format string
> which can be passed with -f to produce true json, and leave the old
> format as is, for backward compatibility?

As explained above, I'd like to keep the old format, so a third format
string should be used. It would be nice (if possible) to consider BATMAN V
at this point too to avoid adding many more formats in the future, but
generally I'm okay with adding new formats.

Thanks,
	Simon

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJMGiwACgkQrzg/fFk7axZCAwCgs3Nr7E7/FrPUzAGlbneihkxA
YvwAoLkwe5uIxYzhMJQabQ1VSM/7J8jq
=1r9f
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
