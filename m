Return-Path: <antonio@meshcoding.com>
Message-ID: <5583D6B5.7050706@meshcoding.com>
Date: Fri, 19 Jun 2015 10:45:41 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434698334-9399-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434698334-9399-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6tU0ii4LCxpog9Mu4RotUtI6IuGbLWbbV"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: protect
 tt_local_entry from concurrent delete events
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6tU0ii4LCxpog9Mu4RotUtI6IuGbLWbbV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19/06/15 09:18, Marek Lindner wrote:
> The tt_local_entry deletion performed in batadv_tt_local_remove() was n=
either
> protecting against simultaneous deletes nor checking whether the elemen=
t was
> still part of the list before calling hlist_del_rcu().
>=20
> Replacing the hlist_del_rcu() call with batadv_hash_remove() provides a=
dequate
> protection via hash spinlocks as well as an is-element-still-in-hash ch=
eck to
> avoid 'blind' hash removal.
>=20
> Fixes: 2443ba3 ("batman-adv: roaming handling mechanism redesign")
>=20
> Reported-by: alfonsname@web.de
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--6tU0ii4LCxpog9Mu4RotUtI6IuGbLWbbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVg9a1AAoJEOb/4TMchkvf/fkP/jtCslUNS+9EhmOMApeD86Qf
aIL1iQHzEQ3AoGer/luM6ouiHu8IVf8dDbzQ4midN1YyHwRNWPprY9ZuNcKtDVTA
MlX+HRQG2SMCmuAWArGcncO3BOzsusFgWM7rKW/94GcWfCmqOH8ru+zrkQqDcm8L
qQqLo4f75MeEwfe19CLukb2U2dh5CCTtC/4vTzVNveDunixk4cngjpI4Srh1aBPB
GuqMhyyDQTMBN6NJjUHNkWHZL1DvgAMxKeAO+p4fPq1jsHJG7mZJhxoE3ZaHV+kC
vvbgBItryuoBAYAYmYEOfQWwZeqdf/bsVDtz4d2evkcXxDp1pFmij1RKYhUOv1lO
YapFA7q//ylRzsxR1QUs89CHFdwX3Kddwe7Ar/DZghBDGsNsrOnhMnSjvzy0TiHx
s79Fw4SxyK1hmRqtZJrzJfD7AtAHtk0NlG1W8lTKSlTfv1b/Uxp7OUTyugwB5IBE
ExtSWFVgxNryXmjIj048EEVBv0Px10fqyXwUzzCcZ5jqF6xiSfNLQp2/ZOD4Mljy
NNZg43pbM5gXvc81zkFU3GGFHyByWj5tUhIM+w1W1UtJZWAxQtmE/EDDGN5/PZt6
aocmE6U9lP8CXaELW+eJ+GeHzLgEHWVQ5qYUnBIZvgEVwIW+IxOIVW4HSjZdwjwB
teFBMZqGq9gzpTl5Jd9x
=Im53
-----END PGP SIGNATURE-----

--6tU0ii4LCxpog9Mu4RotUtI6IuGbLWbbV--
