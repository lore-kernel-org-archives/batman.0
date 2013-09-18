Return-Path: <antonio@meshcoding.com>
Date: Wed, 18 Sep 2013 12:08:48 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130918100848.GH3053@neomailbox.net>
References: <CADtP98UYNT7KOg9a1Pc+bozarwxfpNh8E+BG14xbvGX5EQsFVA@mail.gmail.com>
 <20130918061901.GF3053@neomailbox.net>
 <CADtP98XqeKBw=T8__wbOprKUVkreAZGhPyrYuCcerYJj5zLuKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <CADtP98XqeKBw=T8__wbOprKUVkreAZGhPyrYuCcerYJj5zLuKQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Where can i see, sequence number, eq,
 rq for an originator?
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


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2013 at 10:16:51AM +0200, Eugenio Carocci wrote:
> Thanks you for the reply, just one last question. Is there some paper
> online that explain, how the protocol
> avoid routing loop, may with some examples? :)

The document explaining something closer to what you want can be found on t=
he
wiki: http://www.open-mesh.org/projects/batman-adv/wiki/OGM

However, the current implementation of the protocol is the result of a sort=
 of
"evolution" and for this reason what you read in the document may not refle=
ct
the current implementation 100% (but we always try to keep the two in sync).

Here[1] you also have an explanation of the former protocol, and some of the
things written there are still valid, but I'd use it only to get the flavour
of what is going on (not as a real reference).


Regards,


p.s. don't top-post please

--=20
Antonio Quartulli

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSOXuwAAoJEADl0hg6qKeOOP4P/R+wk1+2pFP3LaaZyYt0sr3E
9KRH4tu3TT6m7q8Mw1TXngYynPCc5eJJeE9W1Me2C/66mRjTtQmH8wxfXyK2Yg7b
iwem/Ff4PNLCtoBKpuYonitc43/OWjqRO++f7ll2W3IdXQcPn/tso6UgO0/8G2D4
wdNvnr4iooDbAJXsmPo0MNWrm7pBo39Md6JMjird8jxAvJ5rKvTlluYD5LBbgB55
QGDIwxFwQaC5q7yUajxtKXXgge9U0i/b88aB1fkoeLE0fBtxFSPwWb6xIW1cDLQf
Tlh9/JWmgXUlHlhpNs1aHq9VMnllh2HKlW8txoogbmRs8G1PxOlobl05I3r2pq6U
APx+OYILWemtGICm5knI7BNGoJQiQkS+JtZX0es8BEvXXGdIUYnb/qQeG/93uZeb
6foePFNogTIdUiq6e23va9Z6BJfKNK3bfg1RAA4zkMatP+U/lkMVL3FiT2xIfuMe
4ZNBxxbpVMAO27HdAxjDDzPLtQcupFc+oKqU2UyzpDYSVfXFcandHFGoUVhfbcSs
/inie8tJ23FeG6EMEbbwyC+66/H7SnUJdlXjzdSJsF1sFMN53RoNJi3mg9FL0VZw
MdV6QbuAGqwJsc342PCaI2JfNsmVVyWZmBv9gkUtt1JpPLWebH7Ajfgun1MsniFV
696we6UWEv3CReYuRVK+
=uibL
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
