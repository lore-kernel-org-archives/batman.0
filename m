Return-Path: <a@unstable.cc>
Date: Thu, 21 Apr 2016 18:22:52 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160421102252.GB23886@prodigo>
References: <1457711046-4603-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <1457711046-4603-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix reference counting
 of vlan object for tt_local_entry
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


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 04:44:05PM +0100, Sven Eckelmann wrote:
> The batadv_tt_local_entry was specific to a batadv_softif_vlan and held an
> implicit reference to it. But this reference was never stored in form of a
> pointer in the tt_local_entry itself. Instead batadv_tt_local_remove,
> batadv_tt_local_table_free and batadv_tt_local_purge_pending_clients depe=
nd
> on a consistent state of bat_priv->softif_vlan_list and that
> batadv_softif_vlan_get always returns the batadv_softif_vlan object which
> it has a reference for. But batadv_softif_vlan_get cannot guarantee that
> because it is working only with rcu_read_lock on this list. It can
> therefore happen that an vid is in this list twice or that
> batadv_softif_vlan_get cannot find the batadv_softif_vlan for an vid due =
to
> some other list operations taking place at the same time.
>=20
> Instead add a batadv_softif_vlan pointer directly in batadv_tt_local_entry
> which will be used for the reference counter decremented on release of
> batadv_tt_local_entry.
>=20
> Fixes: 9729d2085c0f ("batman-adv: fix TT VLAN inconsistency on VLAN re-ad=
d")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Thanks a lot Sven ! This change, on top of fixing the ref issue, also simpl=
ified
the code quite a lot!

Acked-by: Antonio Quartulli <a@unstable.cc>

--=20
Antonio Quartulli

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXGKn8AAoJEJ4aZjxxc6bKSJAQAIpwG6/e/8ErYgpwQTA6sKjT
pGdstbtoVFoODlE7j4yfac+nXploiVYLfLfAU94aaDqwG295La/RkI0dSAuwSoCQ
Z4Z17JkdTbGsYioFifygHfltgW1kOFncidMikwv1BIo73gPtnZvqcDWlWIx7PWzf
Wwwy50w7zIuQEU4bJvviYg0fHsm1uHHQhHIRB1v33IWFyEurqm4akbG5GwDphQcA
NroLXD/LTphgUt01etvWVTrixlzHzvS5eXdL6AaNTtdTI/jUO4NEnJNUIilRllI3
NAIJlLs67hVI5qBccEvLLSrJZpM58IA8WDSql5jSk3nPIFYi4Jqvum+wbSdAFk2+
C9sbaED9OG+rgivdcz/xJVzB2MSq21e7VA17pcjN6lYn3b6sQ+eK5bQxy/qtzv17
6BFE25rdFd+wogtebtsygG+25+nkNm8+KEbYsjquUWeGoySxy2o3S+4NAiwfz6VB
vv0243ZEPwzi+zvtLflDGp200VJOzRpZV93sJjRTCV/k+Bxu/Vq5cCqc/3nY8pq5
bpzPqqLac8zM2XSsBEH7p5VraD0YhjjBjjvrp2lS+wf2TOsjfrwDXTMvrr83XwM8
fzYr4AyRvGG7OgIgtcPIDq096c14sbFCE6hZfPjqTO0BWaa8Mv6+ccyvjMICuc3Y
tiO2T+UjECrf9MvN6Gro
=WtdO
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
