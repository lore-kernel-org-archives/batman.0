Return-Path: <antonio@meshcoding.com>
Message-ID: <55883B64.1050201@meshcoding.com>
Date: Mon, 22 Jun 2015 18:44:20 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434904223-10227-1-git-send-email-mareklindner@neomailbox.ch>
 <1434904223-10227-2-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434904223-10227-2-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TQgq1nuUJFpbMIX1Jw7BL5RmxQ3e8JuXX"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: prevent potential hlist
 double deletion
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
--TQgq1nuUJFpbMIX1Jw7BL5RmxQ3e8JuXX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/06/15 18:30, Marek Lindner wrote:
> The hlist_del_rcu() call in batadv_tt_global_size_mod() does not check
> if the element still is part of the list prior to deletion. The atomic
> list counter should prevent the worst but converting to
> hlist_del_init_rcu() ensures the element can't be deleted more than
> once.
>=20
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

However, as discussed offline after Sven's suggestion in ticket #217,
the entire if-loop still needs to be protected with the vlan_list_lock
and not just its body.

Cheers,

> ---
>  net/batman-adv/translation-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> index ca0bcac..e29c9e1 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -315,7 +315,7 @@ static void batadv_tt_global_size_mod(struct batadv=
_orig_node *orig_node,
> =20
>  	if (atomic_add_return(v, &vlan->tt.num_entries) =3D=3D 0) {
>  		spin_lock_bh(&orig_node->vlan_list_lock);
> -		hlist_del_rcu(&vlan->list);
> +		hlist_del_init_rcu(&vlan->list);
>  		spin_unlock_bh(&orig_node->vlan_list_lock);
>  		batadv_orig_node_vlan_free_ref(vlan);
>  	}
>=20

--=20
Antonio Quartulli


--TQgq1nuUJFpbMIX1Jw7BL5RmxQ3e8JuXX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViDtqAAoJEOb/4TMchkvffhUP/jSyGwK4vo0nnR1cRpZUKiNN
OFONdIUhm5WtMzLbp0fokcm7Ym7JAJq7W+pW5DOrjqxKNkTpx9U1m0+rB2v411Rc
+31HAJtsvrBLmrVewQKLVC2I8KjnEGNKtJ6+GiiFb06dw5JiNeaw62+BA7SZ7RYe
OaFTtqOeILFFGcX91Xh6VtciDBtoWuC5PUKdpK1CxLzcqn7zSVg+MNKaHNJjp+ZE
PUaizTEEjKMHRuWrmho7b/coWgOnfP6n1Z5j+/EsKu7XOi2LXHffIjVuZvPtVQJ8
lW4LBU5g7hGN0SOryIxAZA1WyUHOZrwqvAyudqNudNW28RS6w9aZ19ZVFEJ7GkVq
M3f59oewB5CaXC0lLYzCvbpYWCaoGs71zSN6RMkifpqsOzejdmxfaWG71Bjf809J
4FogF1WsASSCQ3rJQWxd55tDVzczryXLk30Ul+OyAJ/Gr3DUDtbc1R55L4kn7BxW
FBjNh8bKltNPO318buPcxZ3yFjvzU6CXyTLJaFk+0L7NDLXr1vUSSeJGJGFq96Ev
ajvJlzRNEtiUoSWLFh8AWZjgVig4ib97Pvs0nfrLQzWEnlQ2k1+hK4HqWmsRlJlJ
p33PLC0cHGFKNxthR0QDWIqinoPW0GWu5lX+VnUarYZuGlTfyC4OkaMQGO6qAas8
r+AG2o97tnpp8dRUR1ms
=eYAu
-----END PGP SIGNATURE-----

--TQgq1nuUJFpbMIX1Jw7BL5RmxQ3e8JuXX--
