Return-Path: <ordex@autistici.org>
Date: Sat, 30 Mar 2013 14:16:02 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130330131602.GC4024@ritirata.org>
References: <trinity-97d57b03-203f-4915-9bec-fcae5d01e618-1363490537768@3capp-webde-bs08>
 <1363495498-17830-1-git-send-email-linus.luessing@web.de>
 <1363495498-17830-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <1363495498-17830-2-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix general protection
 fault in batadv_tt_global_del_orig()
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


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2013 at 05:44:58AM +0100, Linus L=C3=BCssing wrote:
> On shutdown a race condition where we access a just freed global TT hash
> might occure. batadv_orig_node_free_rcu() callbacks might have been
> scheduled (especially during the shutdown procedure) and unfortunately
> batadv_tt_global_table_free() does not wait for them to finish first
> before freeing the global TT hash.
>=20
> This potentially results in a general protection fault in
> batadv_tt_global_del_orig(), called via a batadv_orig_node_free_rcu()
> callback, which tries to access the just freed global TT hash.
>=20
> This patch tries to fix this by waiting for any just scheduled
> batadv_orig_node_free_rcu() to finish via an extra rcu_barrier() call
> before freeing the global TT hash. And by moving the TT freeing call to
> the end of the batman cleanup routines.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Acked-by: Antonio Quartulli <ordex@autistici.org>

@Marek: when you will merge this commit, can you please reword "tries to fi=
x" in
"fixes" ? :)
Actually this patch is fixing the problem :)

However, as I discussed with Linus on IRC, this is only a temporary fix, wh=
ich
aims to remove the problem, but still we will need a redesign of the TT cle=
an up
routine in order to cleanly get rid of this race condition.

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRVuWSAAoJEADl0hg6qKeOticQALxqy631dTtokT2jMeBoirMv
WcUYO+qulNQ6qRAFmBLfDycZQB1X5n17YRdsBAI3/tXDFgUHgWY0/FU8A99AZOyw
B+MSpVuW7dA5UjaAkdDIBCoV4nSj8h19kRDiLZWWLoVjqLk0XvlmSyWjiUg/H97F
UGDEjGbRgd1k0EZrmGOK7FQB/HxKGyMI4fO5aH4/GIiuHgPwxk58ftCPPooXKlxo
m/s1rf9cERgbAXxNLLodnBXJjACsNGSh8xaLF2EER+eF3hwaYoOsEUsPbWS6UoKP
63l3CCnmPFB1z74Pk30RosulDtm/tyOEy8DTYzy9W8jAjHyGdVZKZ33SjwGE5yeR
D437ApvIkKRzrKl/9YUIUr7yEjf/x8GKq89VButGmoC8jDeHs/U41WEZ7lACEDNh
6pRAAe8frMy0Q7PARkFyhMR64wHnzfRH15YctEtPOM0cFI3Uui5wa0Y8G0l7Xtn4
60syXxOTrXb5/DKY+vN9/DExqxh447NF9G1gDQuG2xQnAl6olnD6yJtNNsFcybXS
+l2vR9bRZnKWtxdU6y2nIQLXC6rW1Q3sQChd42MRX510MiZE0Dp2kpfqsXc1kdfM
V3JFDc3PT4WvKmztrGY8IUKkEorlSDjd+mJgXcJL27M4PSZFLozkst+ALv9aZiXx
6I9lX3VFBk956NLHSlwC
=rzSN
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
