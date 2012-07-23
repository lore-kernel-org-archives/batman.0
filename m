Return-Path: <ordex@autistici.org>
Date: Mon, 23 Jul 2012 19:28:28 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120723172828.GF3610@ritirata.org>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
 <CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
 <20120702143604.GD2917@ritirata.org>
 <CAHD-aq+vsMugkr8CWQaw-bOYzLbxBL6V7zP=cfURNMacyBL+oQ@mail.gmail.com>
 <20120721213856.GB3610@ritirata.org>
 <CAHD-aqKiFkq_HXBHMERhbv2uS-8ZcxsfVGv_H6asZf3L2Ruq8A@mail.gmail.com>
 <CAHD-aqK7Wt0YMf1Sr1WrUGOi++D2DEpu-ieNyh0DZQ_6ntBRrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
Content-Disposition: inline
In-Reply-To: <CAHD-aqK7Wt0YMf1Sr1WrUGOi++D2DEpu-ieNyh0DZQ_6ntBRrA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman majareta? I can batctl ping but not ping
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


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2012 at 08:20:21AM -0300, Guido Iribarren wrote:
> On Sun, Jul 22, 2012 at 7:57 AM, Guido Iribarren
> <guidoiribarren@buenosaireslibre.org> wrote:
>=20
> >
> > This time it solved itself after some brief time (a minute) but the
> > symptoms were the same.
> > So I could catch some logs,
> > http://pastebin.com/MEENj94i
> >
> > sadly, i wasn't fast enough to get a live log from the node involved
> > in the inconsistency as you suggested, so the report might be pretty
> > useless.
>=20
> from this particular node i ran previous report (colmena-casa) that
> was rebooted recently, L3 ping to all of the network had the same
> issue, (no replies for a minute or so) so i had the chance to
> "recreate" the situation several times.
> Turns out, a "batctl ll tt ; batctl l" on the nodes mentioned in the
> inconsistencies gave no output at all, so the previous pastebin report
> is in fact complete :P
> Looks like the inconsistency is being resolved locally between
> neighbours, without the need to contact the far end of the network
> (which is coherent with what's described in the wiki)

Exactly! If the neighbour has the needed information, the node can directly=
 get
answered without bothering the real destination ;)

>=20
> In any case, AFAIR previous ocurrences of the bug didn't resolve by
> themselves (in a reasonable amount of time) so what I'm looking at now
> might be perfectly normal behaviour? (tt tables take some time to
> propagate?)

Well, the log you posted is perfectly correct. You missed some OGMs, theref=
ore
the node is asking for an update that he missed.

it would be interesting to run batctl ll tt; batctl l all the time on the n=
ode
that usually experiences the "problem". The log should be not so big, unles=
s the
bug happens.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlANibwACgkQpGgxIkP9cweK0QCeP0E1U/og5EDNz5UmiCsTr9bR
Su0An1qj+r57zk+gttoOEqneYVHLWOiV
=fWDK
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--
