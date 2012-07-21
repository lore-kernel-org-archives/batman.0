Return-Path: <ordex@autistici.org>
Date: Sat, 21 Jul 2012 23:38:57 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120721213856.GB3610@ritirata.org>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
 <CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
 <20120702143604.GD2917@ritirata.org>
 <CAHD-aq+vsMugkr8CWQaw-bOYzLbxBL6V7zP=cfURNMacyBL+oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <CAHD-aq+vsMugkr8CWQaw-bOYzLbxBL6V7zP=cfURNMacyBL+oQ@mail.gmail.com>
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


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guido,

On Fri, Jul 20, 2012 at 05:25:46PM -0300, Guido Iribarren wrote:
> Resurrecting thread...
>=20
> On Mon, Jul 2, 2012 at 11:36 AM, Antonio Quartulli <ordex@autistici.org> =
wrote:
> > Hello!
> >
> > Has debug support been compiled in batman-adv? IF yes, it would be inte=
resting
> > so see the output of the tt log (batctl ll tt; batctl l)
> Ah, I should have re-read this before :(
>=20
>=20
> > Recently we fixed a bug that which fix has not been released yet. If we=
 are sure
> > that this is the cause, you could eventually try an upgrade to a more r=
ecente
> > dev-version. But let's see the log first (if possible)
> > --
> > Antonio Quartulli
>=20
> Last week I came across this bug again, with the latest firm which
> includes the fixes mentioned, pushed by Marek.
> We were kinda in a hurry so i didn't have much time to check it
> thoroughly, so there's a *slim* chance it was just a coincidence, such
> as very poor signal giving erratic results.
> But if I recall correctly Nico Echaniz did stump on this too, using
> the latest firm.

How did you solve it then? Rebooting?

> So, although i can't confirm it 100%, it seems so far the fixes didn't he=
lp :(
>=20
> We'll keep an eye on it and try a "batctl l"

Yes, please. Remember to set the TT log level (batctl ll tt) before launchi=
ng
batctl l.
Actually it would be very interesting to see the log of the involved nodes
during the "wrong behaviour period".

However, please keep an eye on the log anyway and report if you get any
message matching "*inconsistency*" (but report the whole part of the log, n=
ot
only this message). When you see those messages, please be sure that no cli=
ents
is connecting at that time (if so, it could be the normal procedure). If yo=
u get
this message, you should also see which node is involved in the inconsisten=
cy
(it is reported in the message too) and please report the tt log from that =
node
too.

Thank you very much!


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEUEARECAAYFAlALIXAACgkQpGgxIkP9cwe+8ACYjR4Lg6R4KMKBy9v9uR4mYJtq
AACcCgohK7zuQP/jkkPpJRivNOnAA8I=
=0Rjm
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
