Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 09 May 2018 03:20:05 +0800
Message-ID: <2938343.Lhb7MQrGW1@lafayette>
In-Reply-To: <4312006.8fiAyFea1e@sven-edge>
References: <20180505153020.29636-1-linus.luessing@c0d3.blue>
 <4312006.8fiAyFea1e@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1928985.gIRYyoW2AK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix TT sync flags for
 intermediate TT responses
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

--nextPart1928985.gIRYyoW2AK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 6, 2018 4:23:37 AM HKT Sven Eckelmann wrote:
> > * batadv_tt_tvlv_generate() - fill the tvlv buff with the tt entries from
> > the *  specified tt hash
> > * @bat_priv: the bat priv with all the soft interface information
> > @@ -2934,6 +2969,7 @@ static void batadv_tt_tvlv_generate(struct
> > batadv_priv *bat_priv, struct batadv_tvlv_tt_change *tt_change;
> > struct hlist_head *head;
> > u16 tt_tot, tt_num_entries = 0;
> > +       int flags;
> > u32 i;
> > 
> > tt_tot = batadv_tt_entries(tt_len);
> > @@ -2951,8 +2987,12 @@ static void batadv_tt_tvlv_generate(struct
> > batadv_priv *bat_priv, if ((valid_cb) && (!valid_cb(tt_common_entry,
> > cb_data)))
> > continue;
> > 
> > +                       flags = batadv_tt_get_flags(tt_common_entry,
> > cb_data); +                       if (flags < 0)
> > +                               continue;
> 
> The second argument of batadv_tt_get_flags is a little bit tricky here. The
> kernel-doc says that cb_data is "data passed to the filter function as
> argument" and is of type "void *". But you are now using it here as if would
> always be of type "struct batadv_orig_node *". This doesn't make problem 
> for now because only two functions are using this argument - luckily they
> are either set it to NULL or to "batadv_orig_node *".
> 
> I would propose to make it clear that this argument must be
> "struct batadv_orig_node *" and not an arbitrary argument which is only used
> by the valid_cb callback.

I second that concern. An alternative suggestion: Modify 
batadv_tt_local_valid() / batadv_tt_global_valid() to return the flags as 
those functions already distinguish between the local and global case. 
Moreover, you save the extra batadv_tt_global_orig_entry_find() call which 
already happens in  batadv_tt_global_valid().

Cheers,
Marek

--nextPart1928985.gIRYyoW2AK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlrx+GUACgkQU1VOj+62
HMBD6AgAqhwJfmqKhktqIwMRR0iRf+lfJ9fubic+LezaITuz3Uxw96ZCp+ATY32H
X18+UNCpfKvZUoXebmUD6fAQimTIbSl71yss8W1T96cehqIG+JxaccyTR91G8/x7
/gk5kuN4r883/KNePneKEJscCQxbK7BAJt4jGGqDtJP0aLkUshxp7T5WqMIxJM3K
+j9fb+a0w8dk+3bZmL+zS86LiYUCfs1gxV97/4YAELRBYxrg1JI0JuVrqNgX+wlM
EkIP+MtjG8agb5uGFv8d6hYPdFlBz7jnKcIxZpoRxxz/rQReKrrvg1xr0L2BRnDz
wScy8BaPEGVQhp8gvWUEjeFMqaSixw==
=ad2w
-----END PGP SIGNATURE-----

--nextPart1928985.gIRYyoW2AK--



