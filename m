Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 25 Aug 2015 17:31:58 +0200
Message-ID: <2860695.DF0VuzRtbN@prime>
In-Reply-To: <55DC3C65.3010903@meshcoding.com>
References: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
 <1440170118-10876-5-git-send-email-sw@simonwunderlich.de>
 <55DC3C65.3010903@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6491341.ebltyFmduR";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 4/4] batman-adv: detect local
	excess vlans in TT request
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net


--nextPart6491341.ebltyFmduR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 25 August 2015 11:59:01 Antonio Quartulli wrote:
> On 21/08/15 17:15, Simon Wunderlich wrote:
> > If the local representation of the global TT table of one originator has
> > more VLAN entries than the respective TT update, there is some
> > inconsistency present. By detecting and reporting this inconsistency,
> > the global table gets updated and the excess VLAN will get removed in
> > the process.
> > 
> > Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
> > Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> > ---
> > 
> >  net/batman-adv/translation-table.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/net/batman-adv/translation-table.c
> > b/net/batman-adv/translation-table.c index dced2da..1adb72e 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -2392,6 +2392,7 @@ static bool batadv_tt_global_check_crc(struct
> > batadv_orig_node *orig_node,> 
> >  	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
> >  	struct batadv_orig_node_vlan *vlan;
> >  	uint32_t crc;
> > 
> > +	bool found;
> > 
> >  	int i;
> >  	
> >  	/* check if each received CRC matches the locally stored one */
> > 
> > @@ -2418,6 +2419,26 @@ static bool batadv_tt_global_check_crc(struct
> > batadv_orig_node *orig_node,> 
> >  			return false;
> >  	
> >  	}
> > 
> > +	/* check if any excess VLANs exist locally for the originator
> > +	 * which are not mentioned in the TVLV from the originator.
> > +	 */
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
> > +		found = false;
> > +
> > +		for (i = 0; i < num_vlan; i++) {
> > +			tt_vlan_tmp = tt_vlan + i;
> > +			if (ntohs(tt_vlan_tmp->vid) == vlan->vid) {
> > +				found = true;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (!found)
> > +			return false;
> > +	}
> > +	rcu_read_unlock();
> > +
> 
> NAK.
> 
> we already do this check slightly above in this function with the
> following code:
> 
> 2426                 vlan = batadv_orig_node_vlan_get(orig_node,
> 2427
> ntohs(tt_vlan_tmp->vid));
> 2428                 if (!vlan)
> 2429                         return false;
> 
> batadv_orig_node_vlan_get() returns NULL if we don't know this VLAN for
> that Originator, therefore the CRC check fails here.

That's right, however it only sweeps through the VLANs announced within the 
TT-TVLV. However, my addition tries to check if there are any excess VLAN 
locally which are NOT in that TT-TVLV. I think this patch doesn't take care of 
that, or am I missing something?

For example, think of having VLAN 6 locally with a couple of global entries at 
the originator, but the TT-TVLV only announces VLANs 3,4,5. Then the fact that 
we also have VLAN 6 is not detected, and these (probably wrong) entries are 
never cleaned up.

Thanks!
    Simon
--nextPart6491341.ebltyFmduR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXcim4ACgkQrzg/fFk7axY+XQCfflps2sMw9Sdc30mbNUEfopxr
BqQAoOAmCDzBOSpWVNW6pP8iWPsFxU3T
=Xseo
-----END PGP SIGNATURE-----

--nextPart6491341.ebltyFmduR--

