Return-Path: <gwirth79@gmail.com>
Message-ID: <4B172691.8010707@gmail.com>
Date: Wed, 02 Dec 2009 18:46:41 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
References: <20091203002407.GA10048@Linus-Debian>
In-Reply-To: <20091203002407.GA10048@Linus-Debian>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] Updating orig_str for debug
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

On 12/02/2009 04:24 PM, Linus L=FCssing wrote:
> In commit 1488 the orig_str has been removed from
> purge_orig_neighbours(). Apparently, this breaks compilation when
> enabling debug-flags, as bat_dbg() is expecting this variable as a
> parameter. Actually, this variable has never been initialised also
> before commit 1488 (which was probably the reason for mistakenly
> removing it).
> This tiny patch adds the orig_str again, but initialises it now as
> well.
>
> Signed-off-by: Linus L=FCssing<linus.luessing@web.de>
> ---
>
> Index: originator.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- originator.c        (revision 1489)
> +++ originator.c        (working copy)
> @@ -163,7 +163,7 @@
>                                   struct neigh_node **best_neigh_node)
>   {
>          struct list_head *list_pos, *list_pos_tmp;
> -       char neigh_str[ETH_STR_LEN];
> +       char neigh_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
>          struct neigh_node *neigh_node;
>          bool neigh_purged =3D false;
>
> @@ -179,6 +179,7 @@
>                                  ((PURGE_TIMEOUT * HZ) / 1000)))) {
>
>                          addr_to_string(neigh_str, neigh_node->addr);
> +                       addr_to_string(orig_str, orig_node->orig);
>                          bat_dbg(DBG_BATMAN, "Neighbour timeout: originat=
or %s, neighbour: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->=
last_valid / HZ));
>
>                          neigh_purged =3D true;
>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Shouldn't the "addr_to_string(orig_str, orig_node->orig);" be moved out=20
side the loop to near the top of the function? There is only one=20
originator node and there is no reason to iterate over it. One time=20
should suffice.

Gus
