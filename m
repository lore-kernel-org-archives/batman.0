Return-Path: <sven.eckelmann@gmx.de>
Date: Tue, 29 Dec 2009 16:43:28 +0100
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20091229154328.GA17851@WGT634U>
References: <20091227172356.GA11615@pandem0nium>
	<20091228151008.GA15872@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20091228151008.GA15872@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 no pgp] batman-adv: receive
	packets	directly using skbs
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 28, 2009 at 04:10:08PM +0100, Simon Wunderlich wrote:
> This patch removes the (ugly and racy) packet receiving thread and the
> kernel socket usage. Instead, packets are received directly by registering
> the ethernet type and handling skbs instead of self-allocated buffers.
>=20
> Some consequences and comments:
>  * we don't copy the payload data when forwarding/sending/receiving data
>    anymore. This should boost performance.
>  * packets from/to different interfaces can be (theoretically) processed
>    simultaneously. Only the big originator hash lock might be in the way.
>  * this might introduce new race conditions.
>  * aggregation and vis code still use packet buffers and are not (yet)
>    converted.
>=20
> This is the second version of this patch to be released, i would consider
> it experimental and would hereby like to as for reviews before committing
> it. Some things you might want to test:
>=20
>  * performace differences (are there any?)
>  * do all components still work? (vis, batctl ping, ...)
>  * do high load situations or multiple interfaces cause problems
>  * any memory leaks i might have overlooked?
>=20
> I did some tests on my 9 node qemu environment and could confirm that
> usual sending/receiving, forwarding, vis, batctl ping etc works. However
> i can not talk about the performance from this setup.
>=20
> Things changed from the first version are:
>  * always keep the skb->data at the batman header within the packet
>    handling functions
>  * use skb_copy() before modifying the data, if needed
>  * more fragmentation friendly header handling
>  * use skb_headlen() instead of asking skb->len
>  * fix some small bugs (use kfree(skb) -> kfree_skb(skb))
>=20
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

This patch looks better to me, but your tests yesterday showed that there i=
s a
possible deadlock due to the usage of spinlocks with disabled and enabled i=
rqs.
I know that you started to convert all spin_lock to spin_lock_irqsave, but =
this
may include locks which aren't affected by the wo-irqs/w-irqs situation.

I try to summarize where each lock is used so we can decide if it is ok to
revert some of them to spin_lock again. This should also resolve a request I
got from Andrew some time ago.

 - vis_hash_lock
   - vis_set_mode()
   - is_vis_server()
   - receive_client_update_packet()
   - send_vis_packets()
   - vis_init()
   - vis_quit()

   -> receive function is called with disable irq -> so we must
      use spin_lock_irqsave

 - hna_global_hash_lock
   - hna_local_add
   - hna_global_add_orig
   - hna_global_fill_buffer_text
   - hna_global_del_orig
   - transtable_search

   -> add functions are used when we update routes after we received a bat
      packet. So this must disable irqs too

 - hna_local_hash_lock
   - hna_local_add
   - hna_local_fill_buffer
   - hna_local_fill_buffer_text
   - hna_local_purge
   - hna_global_add_orig
   - generate_vis_packet

   -> add functions are used when we update routes after we received a bat
      packet. So this must disable irqs too

 - forw_bcast_list_lock
   - _add_bcast_packet_to_list
   - send_outstanding_bcast_packet
   - purge_outstanding_packets

   -> Was already changed to irqsave in
      "batman-adv: Use forw_bcast_list_lock always in disabled interrupt co=
ntext"

 - forw_bat_list_lock
   - new_aggregated_packet
   - add_bat_packet_to_list
   - send_outstanding_bat_packet
   - purge_outstanding_packets

   -> for example add_bat_packet_to_list is called by schedule_forward_pack=
et
      which is called by receive_bat_packet - called by
	  receive_aggr_bat_packet - called by recv_bat_packet (called with disabled
	  irqs). So we must use irqsave

 - orig_hash_lock
   - bat_device_write
   - hardif_add_interface
   - originator_init
   - originator_free
   - purge_orig
   - proc_originators_read
   - slide_own_bcast_window
   - recv_bat_packet
   - recv_my_icmp_packet
   - recv_icmp_ttl_exceeded
   - recv_icmp_packet
   - recv_unicast_packet
   - recv_bcast_packet
   - interface_tx
   - generate_vis_packet
   - broadcast_vis_packet
   - unicast_vis_packet

   -> for example all recv_ functions are called with disabled irqs. So we
      must use irqsave

So it is complete correct to use irqsave everywhere (as you have commited it
now).

Best regards,
	Sven

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBCgAGBQJLOiObAAoJEF2HCgfBJntGLTIP/1vEWHK8Go8Eiv8ZM3CEEaNu
r2mMR8OY5cSYE7XCWcK1dEePugDIJauBCj+WabWe1Zj8p3tRmPLyBsF5nzUEXVC9
h5XY6VyOuxuH/FJJFFBtszl7l7xQiIbHd4ef9HOarnNHBwwUhJDN3PlDnJBYcJxr
5aHaGD3/XuTn9T5leTK5ITaf5Wi1D2j+T4FT0OL+eoboHvPKV3cBIOf1YSmxPaI3
/vj2+wfieYIg28oHzuZ8ijYSA0z3Yfead3DIKvnJFtNBRTRhT07+f9ZJvKFlEo09
pNey9ddoYnN0pVx6US9ePgrF/1xAOoiu6wImpkvsqxo0Lu0C7+EB7WOCkeIyX3+p
G39EflEHddL2u7MVl5xAHjuZUW5kicLTIj/Bf0RKz//suOXWgBpTNExlo6YF9aSr
Zg+c9hSbZTEjhtP19BHd/hxKlbe7bcNvFWPHQbzUFxhnnafQ6b47a5b4Bph003T9
YADHKnD1Bgby4VjodIW8UrUERs3MP92edzumgWRyyo7R8kMqF9epX0BGuJGUBPfy
Bze/Y+FmXP4UWX4zL9Wn2Iu0tXoOp9cqyKCHNBo6gZP3w2Zi6ypZh9IkGOZDT5HJ
pQ0Rkq5CRIurPfdJlxzQchGNEfI3bfqt8f6VmO9RnlG2q2seNCuwqRJtgRkNvjd2
vZYizSHmvAT84qRJ4kkE
=j7hO
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
