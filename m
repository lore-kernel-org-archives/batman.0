Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 15 Aug 2013 15:45:49 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130815134549.GA1982@pandem0nium>
References: <1376382240-30664-1-git-send-email-linus.luessing@web.de>
 <1376382240-30664-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <1376382240-30664-4-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv8 3/5] batman-adv: Modified forwarding
 behaviour for multicast packets
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


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

I'm currently playing a little with this patchset ...

On Tue, Aug 13, 2013 at 10:23:58AM +0200, Linus L=C3=BCssing wrote:
> [...]
> +	count =3D atomic_read(&tt_global_entry->orig_list_count);
> [...]
> +	atomic_inc(&tt_global->orig_list_count);
> [...]
> +		atomic_set(&tt_global_entry->orig_list_count, 0);
> [...]
> @@ -830,12 +833,14 @@ struct batadv_tt_local_entry {
>   * struct batadv_tt_global_entry - translation table global entry data
>   * @common: general translation table data
>   * @orig_list: list of orig nodes announcing this non-mesh client
> + * @orig_list_count: number of items in the orig_list
>   * @list_lock: lock protecting orig_list
>   * @roam_at: time at which TT_GLOBAL_ROAM was set
>   */
>  struct batadv_tt_global_entry {
>  	struct batadv_tt_common_entry common;
>  	struct hlist_head orig_list;
> +	atomic_t orig_list_count;
>  	spinlock_t list_lock;	/* protects orig_list */
>  	unsigned long roam_at;

You never decrease this orig_list_count, do you? But actually you should
when a node leaves the group. What I've tried is:

Node 1 pings a multicast address
 -> no group member, nothing is sent
Node 2 is added to the group
 -> multicast is now sent as unicast
Node 3 is added to the group
 -> multicast is now sent as broadcast
Node 2 is removed from the group
 -> multicast is still sent as broadcast (should be unicast!)
Node 3 is removed from the group
 -> nothing is sent (as to be expected).

Could you please check the removal case?

Thanks,
	Simon

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIM240ACgkQrzg/fFk7axYRswCgsJ7OgFp+e48XoUUJw/lEsKB3
1LgAn0pXVxGlDdVjo0nobANBO5317Rex
=2d1T
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
