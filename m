Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Jan 2016 16:18:22 +0100
Message-ID: <6579684.ngYt9xsEyU@prime>
In-Reply-To: <569F9AF1.5080403@unstable.cc>
References: <1453296735-8319-1-git-send-email-sw@simonwunderlich.de>
 <569F9AF1.5080403@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4963730.FubmsaYKB4";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: move and restructure
	batadv_v_ogm_forward
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4963730.FubmsaYKB4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 20 January 2016 22:34:25 Antonio Quartulli wrote:
> On 20/01/16 21:32, Simon Wunderlich wrote:
> >  static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
> >  
> >  				 const struct batadv_ogm2_packet *ogm_received,
> > 
> > -				 u32 throughput,
> > +				 struct batadv_neigh_node *neigh_node,
> > 
> >  				 struct batadv_hard_iface *if_incoming,
> >  				 struct batadv_hard_iface *if_outgoing)
> >  
> >  {
> > 
> > +	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
> > +	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
> > +	struct batadv_neigh_node *router = NULL;
> > 
> >  	struct batadv_ogm2_packet *ogm_forward;
> >  	unsigned char *skb_buff;
> >  	struct sk_buff *skb;
> >  	size_t packet_len;
> >  	u16 tvlv_len;
> > 
> > +	/* only forward for specific interfaces, not for the default one. */
> > +	if (if_outgoing != BATADV_IF_DEFAULT)
> > +		goto out;
> > +
> 
> personally I'd prefer the forward function to do what it says: forward
> the OGM. The checks whether or not we should do this should stay in
> ogm_process_per_outif().
> 

Hm, yeah we discussed to keep these changes in route_update, but actually 
those checks decide whether we forward or not (i.e. directly involving 
forwarding). Therefore I thought they would fit better in the forward function 
and also move the corresponding description [1] in the OGMv2 wiki page from 
route update to forward. We don't have a matching "general" description in the 
OGMv2 wiki page which corresponds to ogm_process_per_outif() after all.

Any other opinions?

[1] From the OGMv2 wiki page: If the OGMv2 has been received by the (now) 
selected router, the OGM is forwarded on the considered outgoing interface 
(except for the default interface). However, the OGMv2 is not forwarded if 
another OGMv2 has been forwarded with the same sequence number.
> > +	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
> > +	if (!orig_ifinfo)
> > +		goto out;
> > +	/* acquire possibly updated router */
> > +	router = batadv_orig_router_get(orig_node, if_outgoing);
> > +
> > +	/* strict rule: forward packets coming from the best next hop only */
> > +	if (neigh_node != router)
> > +		goto out;
> > +
> 
> this is changing the behaviour.
> here now we get a router which potentially was elected during the
> previous update_route() call while processing this very OGM. We are
> still discussing if we want to do this or not, but this patch should be
> just a style change, while this is not.

No, this is already in the code which is merged into master - we already 
acquire the updated router (see bat_v_ogm.c:547, function 
batadv_v_ogm_route_update()).

Cheers,
    Simon
--nextPart4963730.FubmsaYKB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlafpT4ACgkQrzg/fFk7axb1UwCg5nA6Uq0GWvi/lyWUSHwZxYsN
vqoAnRGc3przG6QfxLYKDlFSQOQ0ADHc
=iJta
-----END PGP SIGNATURE-----

--nextPart4963730.FubmsaYKB4--

