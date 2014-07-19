Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 19 Jul 2014 18:02:47 +0800
Message-ID: <1438357.7uXdXc9RPK@diderot>
In-Reply-To: <1405391898-5258-2-git-send-email-linus.luessing@web.de>
References: <1405391898-5258-1-git-send-email-linus.luessing@web.de>
 <1405391898-5258-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6240022.a2FUCiCd83";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 2/2] batman-adv: Add debugfs table for
	mcast flags
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


--nextPart6240022.a2FUCiCd83
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 15 July 2014 04:38:18 Linus L=FCssing wrote:
> +#ifdef CONFIG_BATMAN_ADV_MCAST
> +/**
> + * batadv_mcast_flags_open - Prepare file handler for reads from mca=
st_flags

No upper case please.


> +=09=09rcu_read_lock();
> +=09=09hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
> +=09=09=09if (!(orig_node->capa_initialized &
> +=09=09=09      BATADV_ORIG_CAPA_HAS_MCAST))
> +=09=09=09=09continue;

Why not printing '-' in this case as well ?

Cheers,
Marek

--nextPart6240022.a2FUCiCd83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTykJHAAoJEFNVTo/uthzAzPQH/1ndGXYxfXmQ6qQozfaTSyjm
z/osE28b8zHI489ErC0ZNa3Vs3H3pv1Vmh8JfMYHC7m67w1sxF9E8J1qHdxG4KU9
QqmVOVZbjl2qL/Zp2H/VWmN6TuCUm5byys9uTRswTNRbeVsrZ86ZfWWsoruZGpuY
we78XlMmRDwIOMslmb8iJJNGQAOyH7PhU9p/x8zX2Zl41LN9l6bXCyPMHz3pOUO8
zt/pWEKqkLeJuWr1R5lb8Wq5rx7D5wSHAbH0534+9mbYeWuAg8f/X1S5VxhP0F79
xgNjZ/KS9YzdmkZQGO+8UVtAmlncPW6pRs0NFcJNhIVLSy6cO0IFs/4vi40gf6s=
=b35i
-----END PGP SIGNATURE-----

--nextPart6240022.a2FUCiCd83--

