Return-Path: <ordex@autistici.org>
Date: Tue, 2 Oct 2012 11:42:21 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121002094221.GA30831@ritirata.org>
References: <50697D78.3040005@eigenlab.org>
 <CAHD-aqLcyaxH7QvFy5Yb80AjWWrBkF5ei=2F=j3YqpTZ6+BbVQ@mail.gmail.com>
 <5069D0FD.4090805@eigenlab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <5069D0FD.4090805@eigenlab.org>
Subject: Re: [B.A.T.M.A.N.] reboot sometimes doesn't work well
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


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2012 at 07:21:01PM +0200, Gioacchino Mazzurco wrote:
> reboot is called by a script called through ssh
>=20
> > does it reboot succesfully,
> no it doesn't
>=20
> > or simply hangs in there, requiring a
> > manual power cycle?
> It hangs there but I lost connectivity the device became unreachable
> from ipv4 and also ipv6, also link local ipv6 is gone :|

well, what about removing the batman-adv module _before_ rebooting? In this=
 way
we can somehow move the problem.

(remember to do not connect via the mesh when you do this :-P)

ciao

>=20
>=20
> On 10/01/12 15:39, Gui Iribarren wrote:
> > On Mon, Oct 1, 2012 at 8:24 AM, Gioacchino Mazzurco <gio@eigenlab.org> =
wrote:
> >> Hi all!
> >>
> >> Some times ago' in ninux Pisa we was experiencing kernel powering off
> >> the machine caused by batman-adv, with ordex help we debugged what was
> >> happening and the issue was solved bat that was possible because it was
> >> happening on x86 computers ( with screen )
> >>
> >> Now it SEEMS the same is happening but on mips ( Ubiquity M devices )
> >> but here i don't know how to make sure the problem is this, the sympto=
ms
> >> is exactly the same, someone have idea how to save the powering off
> >> kernel output on some file so after detach/attach cable we can find wh=
at
> >> happened ?
> >=20
> > Your best option is getting a serial cable; you *might* try in
> > /etc/config/system to enable persistent syslog output, and make it
> > write to the flash , but no guarantees you'll catch the kernel panic
> > that way. Serial console definitely would.
> >=20
> > Does this happen every time?
> >> "on powering off"
> > you mean when you issue a "reboot" command through ssh, or what?
> > does it reboot succesfully, or simply hangs in there, requiring a
> > manual power cycle?
> >=20
> > We haven't come across anything similar, using this hardware:
> > tl-mr3020, tl-mr3220, tl-mr3420, tl-wr842nd, ubnt bullet2 , ubnt bullet=
 m2

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlBqtv0ACgkQpGgxIkP9cwcXjgCfRsKOMbYmzDxftH1TAyFziyXH
RFoAniwr3/dHatDBktM7sYPwRHz8cBio
=RlOM
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
