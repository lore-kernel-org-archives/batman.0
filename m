Return-Path: <ordex@autistici.org>
Date: Sun, 5 Aug 2012 09:58:17 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120805075817.GG12879@ritirata.org>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
 <CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
 <20120702143604.GD2917@ritirata.org>
 <CAHD-aq+vsMugkr8CWQaw-bOYzLbxBL6V7zP=cfURNMacyBL+oQ@mail.gmail.com>
 <20120721213856.GB3610@ritirata.org>
 <CAHD-aqKiFkq_HXBHMERhbv2uS-8ZcxsfVGv_H6asZf3L2Ruq8A@mail.gmail.com>
 <CAHD-aqK7Wt0YMf1Sr1WrUGOi++D2DEpu-ieNyh0DZQ_6ntBRrA@mail.gmail.com>
 <20120723172828.GF3610@ritirata.org>
 <CAHD-aq+Bw6MtzS_2YZDoQaTS6Rsrwr+8xCE4O+pWGc97ED4Jig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <CAHD-aq+Bw6MtzS_2YZDoQaTS6Rsrwr+8xCE4O+pWGc97ED4Jig@mail.gmail.com>
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


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 05, 2012 at 02:34:15AM -0300, Gui Iribarren wrote:
> On Mon, Jul 23, 2012 at 2:28 PM, Antonio Quartulli <ordex@autistici.org> =
wrote:
> > On Sun, Jul 22, 2012 at 08:20:21AM -0300, Guido Iribarren wrote:
> >> On Sun, Jul 22, 2012 at 7:57 AM, Guido Iribarren
> >> <guidoiribarren@buenosaireslibre.org> wrote:
> >>
> >> >
> >> > This time it solved itself after some brief time (a minute) but the
> >> > symptoms were the same.
> >> > So I could catch some logs,
> >> > http://pastebin.com/MEENj94i
> >> >
> >> > sadly, i wasn't fast enough to get a live log from the node involved
> >> > in the inconsistency as you suggested, so the report might be pretty
> >> > useless.
> >>
> >> from this particular node i ran previous report (colmena-casa) that
> >> was rebooted recently, L3 ping to all of the network had the same
> >> issue, (no replies for a minute or so) so i had the chance to
> >> "recreate" the situation several times.
> >> Turns out, a "batctl ll tt ; batctl l" on the nodes mentioned in the
> >> inconsistencies gave no output at all, so the previous pastebin report
> >> is in fact complete :P
> >> Looks like the inconsistency is being resolved locally between
> >> neighbours, without the need to contact the far end of the network
> >> (which is coherent with what's described in the wiki)
> >
> > Exactly! If the neighbour has the needed information, the node can dire=
ctly get
> > answered without bothering the real destination ;)
> >
> >>
> >> In any case, AFAIR previous ocurrences of the bug didn't resolve by
> >> themselves (in a reasonable amount of time) so what I'm looking at now
> >> might be perfectly normal behaviour? (tt tables take some time to
> >> propagate?)
> >
> > Well, the log you posted is perfectly correct. You missed some OGMs, th=
erefore
> > the node is asking for an update that he missed.
> >
> > it would be interesting to run batctl ll tt; batctl l all the time on t=
he node
> > that usually experiences the "problem". The log should be not so big, u=
nless the
> > bug happens.
>=20
> I admit i haven't left this running as instructed, but on the other
> hand, so far I haven't come across the original bug again, and a few
> days ago I asked Nico Echaniz which confirmed that he's not suffering
> it as previously.
> he does bump from time to time with [a few moments | a few minutes] of
> "nodes majaretas" (at first sight) but it resolves by itself
> quickly[*], which indicates normal behaviour, of missing OGMs and
> consequently a delay in TT table updating, as you explained.
>=20
> [*] "quickly" means under 15 minutes , at most. Previously, problem
> would never resolve by itself, being L3-unreachable for hours or days
> until manual reboot was done.
>=20
> In conclusion, so far so good, i think we can close this as fixed for
> lack of evidence stating the contrary, heh.
> I hope gioacchino managed to recompile ninux images and is having the
> same stableness as we do :)
>=20
> Gui

Hello Guido and thank you for reporting back your results :) However, even =
if
the "behaviour" is good (table gets recovered and everything starts working
again) it is a bit strange that it takes 15 minutes to do so.

If you accidentally see the bug, it would be interesting to get the log of =
the
"non-working" node and see why it is taking so long.

Thank you very much!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAeJ5kACgkQpGgxIkP9cwfEDgCfbFaEXEFFwaDq8AfFnpPDLbYs
w0EAn1DnaRC2IS55RTkRT3/zsnu3b0ka
=nbjg
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
