Return-Path: <ordex@autistici.org>
Date: Sat, 16 Mar 2013 12:15:12 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130316111512.GL8563@ritirata.org>
References: <1363430978-24202-1-git-send-email-ordex@autistici.org>
 <201303161908.43771.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
In-Reply-To: <201303161908.43771.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat RCU code for
 kernel < 2.6.37
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


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2013 at 07:08:43PM +0800, Marek Lindner wrote:
> On Saturday, March 16, 2013 18:49:38 Antonio Quartulli wrote:
> > @@ -236,6 +242,7 @@ static int __batadv_interface_set_mac_addr(x, y)
> >         ASSERT_RTNL();\
> >         dev->master;\
> >  })
> > +
> >  #define hlist_entry_safe(ptr, type, member) \
> >         (ptr) ? hlist_entry(ptr, type, member) : NULL
>=20
> Why the extra line here ?

because at the beginning I put the new defines there, then I removed the de=
fines
but I left the blank line...will send v2

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRRFRAAAoJEADl0hg6qKeOkaYP/0Tp+4CRU8kcjOTBWcwlSKdU
bJMTGR4RhQIsWb3aMoeL0vErXx/WvP9S59qFwj8v6kl6HsDPWAia/7hYu67saEMk
SY9VKQXiRXchle0p4s6FA97mbGZRoLdZ0HXXMOHdQJm+56visNtW/g0Jvjlm9QoP
xnBTYSahsHMSpFRYdXFJqNHjbqH9+1rYUOi9ZfQ4aaoSaZBvsqZHk2mBcyXQkQxX
2c4PUfRivGXDHR056exDHBZoQqc0bKITzNIVex9i+bpY9bGnos9k7Wf2HA/Z5dTv
4hc1gNJgI45gvT5LNsrUDoncQMzcAwRnKVjlQqF8eMqAFZsWcpih6OqhztRV4TVh
3bCMLNXMxlHWqRlDR5jau8FR0+HRpb0n97Lvayg5M7D4gZ84Vk727uMFXzb/HEok
NmlRmJ5EPCVzQMeCFXblRBThSqgV3+SPCq32Fug89ug1kQobZK/Pt67GeMma4KG4
iwRb/ss5pZuT85sqKNauokt8XxqKIilq7T8SMjCybOq3zplgArAVEAMllxCQOUH8
Hk0ku718R9thdtVBonixu89L665ufEAu64HN3gaBzeTdEp0i4QcMYbJVKOJjCASn
rpDYqQzeeen4tUCunDtzRSeJy0B1jLpTLsJEXcvyM6rV0sJj1BahUm8JKShgGufg
hBUOFzoks14A8Rqw4saV
=lCHp
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
