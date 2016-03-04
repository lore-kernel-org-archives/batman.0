Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Mar 2016 17:00:57 +0100
Message-ID: <1639130.GsDHf0QkkJ@sven-edge>
In-Reply-To: <2378940.op5bKN67gL@sven-edge>
References: <20160304152132.GV15541@lunn.ch> <2378940.op5bKN67gL@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4687163.BDNOFOPjrk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Use of ref_get_unless_zero() ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart4687163.BDNOFOPjrk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 04 March 2016 16:50:43 Sven Eckelmann wrote:
> On Friday 04 March 2016 16:21:32 Andrew Lunn wrote:
> > Hi
> > 
> > I'm sometimes getting a crash after removing a hard interface when the
> > batadv_send_outstanding_bat_org_packet() is called in a work queue.
> > It calls
> > 
> > static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
> > 
> >                                         int packet_len, unsigned long
> > 
> > send_time, bool direct_link,
> > 
> >                                         struct batadv_hard_iface
> > 
> > *if_incoming, struct batadv_hard_iface *if_outgoing, int own_packet)
> > {
> > 
> >         struct batadv_priv *bat_priv =
> >         netdev_priv(if_incoming->soft_iface);
> > 
> > struct batadv_forw_packet *forw_packet_aggr;
> > 
> >         unsigned char *skb_buff;
> >         unsigned int skb_size;
> >         
> >         if (!kref_get_unless_zero(&if_incoming->refcount))
> >         
> >                 return;
> >         
> >         if (!kref_get_unless_zero(&if_outgoing->refcount))
> >         
> >                 goto out_free_incoming;
> > 
> > Given that we have:
> > 
> > static inline void batadv_hardif_put(struct batadv_hard_iface *hard_iface)
> > {
> > 
> >         kref_put(&hard_iface->refcount, batadv_hardif_release);
> > 
> > }
> > 
> > does using kref_get_unless_zero() make sense? If it is zero, hasn't it
> > been freed by the kref_put that set it to zero?

Maybe it would be easier to understand when this would be replaced with 
kref_get and the if_outgoing loop in batadv_iv_ogm_schedule would be replaced 
with:

	rcu_read_lock();
	list_for_each_entry_rcu(tmp_hard_iface, &batadv_hardif_list, list) {
		if (tmp_hard_iface->soft_iface != hard_iface->soft_iface)
			continue;

		/* make sure only still valid interfaces are used in queue */
		if (!kref_get_unless_zero(&tmp_hard_iface->refcount))
			continue;
		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
					*ogm_buff_len, hard_iface,
					tmp_hard_iface, 1, send_time);
		batadv_hardif_put(tmp_hard_iface);
	}
	rcu_read_unlock();

Sorry for being in noisy-mail mode. I will stop sending mails for today.

Kind regards,
	Sven
--nextPart4687163.BDNOFOPjrk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW2bE5AAoJEF2HCgfBJntGpGwQAMAA3snrEBjt/N2yrl9KQvED
88bwLZqbBwj3ruEoBCrNxLqhpQpYI3FuoNUOPwro5rgUYG8ALdmqTQPdHnmCrz0U
SSPogeWy7XucfpULWBtsc10+5NCTU9ZSbm4ZYSCmg80iKclTNJHZbGaepLLYwaoP
/Zv1nohwrCiTmN6VIp90ocyDz/0qIMAirDzsSF6z4+Dgj9NNF/zCuUV8LtlS8zYU
tMX8BneTgMpZXiwFPw8QT2ZGHLMNLEbWQeYB7X2nmrPCSqh6SEZCGLYawqdpKCJg
Df5wBRqYOT/iXx8bbYewCNCVRXmGlh1SOd+DPufJ0yw914NZIVn0uW65VB+gCsZT
JbaDHlOk5CLVItFGg/9feZCtUs0aYMVA1aFyzALXe7Yjr4O02+lKF+h4/lyrLwyK
W4XZoNF6gF5DPxAjGR607DZDY0VGpEuAHSyDqyQxKLglXg/esBWcngEmdlt7V+ke
rB8vPCgNCKbCVjavxgs6uX/4g3+e0y3e3cH/FIm+MbGk418kNAPzaqCDTsheEma8
odqQ92Zv2glUIMJAofL5iOWtbc1jV63YpGKVxbUy7TcGPSmd3HgmPaXOD7OL5kMN
WwuW3IJ8PgVCSlCFarmIAY+xlbSxm1lescZSC7Mb8kSK8Ho84DLqZnPaHqN04i4s
vb1FqaxTeMlRV/+WS8yt
=WRMS
-----END PGP SIGNATURE-----

--nextPart4687163.BDNOFOPjrk--

