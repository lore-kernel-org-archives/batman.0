Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Oct 2016 09:09:44 +0100
Message-ID: <2258656.3t3hhMR4e6@sven-edge>
In-Reply-To: <20161031072217.GK7448@otheros>
References: <20161005234308.29871-1-linus.luessing@c0d3.blue>
 <1546440.hnPT5BvDlZ@sven-edge> <20161031072217.GK7448@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1596603.nXs95vjkKM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 1/2] batman-adv: fix race conditions
	on interface removal
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1596603.nXs95vjkKM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 31. Oktober 2016 08:22:17 CET Linus L=FCssing wrote:
[...]
> Hm, ah. I think I had that first, but then noticed it doesn't
> work. For the fake-approach to work, I need to be able to
> distinguish a stealing from batadv_forw_packet_steal() and
> batadv_forw_packet_list_steal().
>=20
> Note, that the former has the extra hlist_add_head(bm_list) to a
> stack hlist_head while the latter hasn't.
>=20
>=20
> The three, potential cases to distinguish in
> batadv_forw_packet_queue() are:
>=20
> OK-case 1):=20
> - Not stolen yet, we may requeue
>   (hlist_unhashed(bm_list))
>=20
> OK-case 2):
> - stolen by purging thread, batadv_forw_packet_list_steal(),
>   we may not requeue
>   (!hlist_unhashed(bm_list) && !hlist_fake(bm_list))

>=20
> ERROR-case:
> - someone called batadv_forw_packet_steal() and

Wait a second. batadv_forw_packet_steal will do following:

> +	hlist_add_head(&forw_packet->bm_list, &head);

So forw_packet->bm_list's next will point to NULL.
The pprev will point to head's first.
head's first will point to forw_packet (but this can be ignored).

> +	hlist_add_fake(&forw_packet->bm_list);

forw_packet->bm_list's pprev will now point to its own next.

So it is !hlist_unhashed && hlist_fake(bm_list).

So it is the same as:

    INIT_HLIST_NODE(&forw_packet->bm_list);
    hlist_add_fake(&forw_packet->bm_list);

I still don't get why the hlist_add_head with a pseudo head
is necessary.


>   then batadv_forw_packet_queue() was called afterwards
>   (!hlist_unhashed(bm_list) && hlist_fake(bm_list))

[...]

> Only doing the hlist_add_fake(bm_list) without the previous
> hlist_add_head() in batadv_forw_packet_steal() would lead to
> "hlist_fake(bm_list)" becoming true, like we'd want it to
> and need to detect the ERROR-case, right.
>=20
> Unfortunately, a plain hlist_add_fake(bm_list) then sets
> bm_list->pprev =3D bm_list->next =3D NULL. Which results in:
>=20
>   hlist_unhashed(bm_list) (=3D OK-case 1), not what we want)

No, this is not what happens. bm_list->pprev is set by
hlist_add_fake to &bm_list->next and not to bm_list->next.

> Does that clarify why the previous hlist_add_head() in
> batadv_forw_packet_steal() is done?

No.

Kind regards,
	Sven
--nextPart1596603.nXs95vjkKM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYFvxIAAoJEF2HCgfBJntGVuUP/20ee29HEv+VsmrLUEU0gFZ4
gQ5bSbtbXyZujeNB8Uf1DQEq0hj/oUgl8w6TTo/ueVR5QIqAALZxFp0sOExG8cFW
f6bw8Qf6tnxwNEjZU0whh8Dt41kB+VMbqvYacYvjJBDTkbN7FcCZDlVT9PNXMnn/
OOGI7YgjG3fodrcm+ded84u8F28LK8K6eyVkAnaYN78fP/T64IweQsuLL8t2osKZ
BnvJmXzJwdmN479VcMtcKtkCYS4Vps5fD4Z1prn/JEWn0WluD2hnFDVfw0MrF8C2
Py0eHkNjUfTuKT5iPkvgv+lLdNNiTBDxsnuOyqIYCnlHTlBNTfISuxChwmLm7BZB
TBT0L85qI6XUeCYr3wCw/tX4w//HEI//SDpOjfhi90X3n/3oUpX0wHXwG75yRiFF
mPOn/jBlBO22ll7bjqDw/PvnDZC48qb3DcaEap1qVYN/KDAAdeMp3xquCe5Q0FkJ
CByQDvZ2Fg0QGtBYPuCpe75YFLWEwf1+nOoPBFqaK3yIlVOC87v07bCFi55EhSUM
FK3h/DSR3M6376CyaSmJurVYFV2KKhLfMKR6N/iX7poliC5u4K7itYAgollYQmJp
BEDd4u+hTQ/fwLibicSLK6fPzoCG5RUk6Bj5i5Y3StzFatD18RAoXnz+fJHvLPIV
VN0HelMpxnrNZ3YVk9zL
=fsVU
-----END PGP SIGNATURE-----

--nextPart1596603.nXs95vjkKM--

