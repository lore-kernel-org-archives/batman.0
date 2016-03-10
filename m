Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 10 Mar 2016 15:36:15 +0100
Message-ID: <2988991.6YFQEkLkck@prime>
In-Reply-To: <OFBA326B67.8120621F-ONC1257F6C.00248B79-C1257F6C.002777B2@phoenixcontact.com>
References: <1456492666-29672-1-git-send-email-apape@phoenixcontact.com>
 <20160302213601.GI7704@prodigo.lan>
 <OFBA326B67.8120621F-ONC1257F6C.00248B79-C1257F6C.002777B2@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2778484.jn6WS42W2a";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: [PATCHv2 1/7] batman-adv: prevent
	multiple ARP replies sent by gateways if dat enabled
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

--nextPart2778484.jn6WS42W2a
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Andreas,

On Friday 04 March 2016 08:11:05 Andreas Pape wrote:
> Hi Antonio,
> 
> > > +bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv,
> > > +               u8 *addr, unsigned short vid)
> > > +{
> > > +   struct batadv_bla_claim search_claim;
> > > +   struct batadv_bla_claim *claim = NULL;
> > > +   struct batadv_hard_iface *primary_if = NULL;
> > > +   bool ret = true;
> > > +
> > > +   if (!atomic_read(&bat_priv->bridge_loop_avoidance))
> > > +      return ret;
> > > +
> > > +   primary_if = batadv_primary_if_get_selected(bat_priv);
> > > +   if (!primary_if)
> > > +      goto out;
> > 
> > do you really need this goto here ? I think you can just return ret.
> > 
> > This way you can avoid the blind initialization of claim and
> > primary_if and you
> > can also remove the 'out' label at all.
> 
> I tried to "copy" the coding style of other functions. But in this case
> you are right that this is senseless here.
> 
> > > +
> > > +   /* First look if the mac address is claimed */
> > > +   ether_addr_copy(search_claim.addr, addr);
> > > +   search_claim.vid = vid;
> > > +
> > > +   claim = batadv_claim_hash_find(bat_priv, &search_claim);
> > > +
> > > +   /* If there is a claim and we are not owner of the claim,
> > > +    * return false;
> > 
> > no need for the ';' here :)
> > 
> > > +    */
> > > +   if (claim) {
> > > +      if (!batadv_compare_eth(claim->backbone_gw->orig,
> > > +               primary_if->net_dev->dev_addr))
> > > +         ret = false;
> > > +   } else {
> > > +      /* If there is no claim, claim the device */
> > > +      batadv_dbg(BATADV_DBG_BLA, bat_priv,
> > > +            "Handle claim locally for currently not claimed mac
> 
> %pM.\n",
> 
> > > +            search_claim.addr);
> > > +
> > > +      batadv_handle_claim(bat_priv, primary_if,
> > > +                primary_if->net_dev->dev_addr, addr, vid);
> > > +   }
> > > +
> > 
> > ...
> > 
> > > @@ -1000,6 +1001,20 @@ bool batadv_dat_snoop_outgoing_arp_request
> > 
> > (struct batadv_priv *bat_priv,
> > 
> > >           goto out;
> > >        
> > >        }
> > > 
> > > +      /* If BLA is enabled, only send ARP replies if we have claimed
> > > +       * the destination for the ARP request or if no one else of
> > > +       * the backbone gws belonging to our backbone has claimed the
> > > +       * destination.
> > > +       */
> > > +      if (!batadv_bla_handle_local_claim(bat_priv,
> > > +                     dat_entry->mac_addr, vid)) {
> > 
> > I like the approach you take to fix this issue, however I don't
> 
> understand why
> 
> > you want to "manually" claim a client.
> 
> This was meant to be something like a safety measure. DAT and BLA tables
> are not
> synchronized and can timeout separately, right? What, if a client address
> is still
> available in DAT but the client is not claimed anymore. In this case I
> think that
> claiming the client might be a good idea. I misused DAT here to make sure
> that the
> claim table is up to date. In my test setup running DAT and BLA on a
> number of
> backbone gateways I still have problems with looping packets (although
> having all
> of my patches applied). The problems have become significantly less often
> but
> from time to time there are still some occurring.
> In all of these cases clients from the mesh have been
> unclaimed somehow or they have been considered as having roamed to the
> backbone
> (for an unknown reason the workaround in patch 7/7 did not work in that
> case).

I would agree to Antonio that sending a claim is not necessary, and might 
actually lead to bad choices of the outgoing backbone gateway. After all, at 
this point any "random" backbone gateway may answer to this request, just 
because it has the DAT entry, but maybe may actually not be able to reach the 
client via the mesh.

I think checking if a local claim exists is a good idea, but sending a claim 
is not a good idea - this might introduce effects which will be even more 
complicated to debug.

Cheers,
      Simon
--nextPart2778484.jn6WS42W2a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4YZfAAoJEKEr45hCkp6hky0P/2v79wwS7Q48m/LFVdRlM3/F
u2KouTHb84qg9y/NH0cw3s85gGViE7jbsk+jzYBn4RXsPfXrdmss645+zHbotlcl
b/78zCEyPCG8BelcTpHu+LYbS6uyEaV0IyFAVpOZpX5/ujhINWnvhWj3oHIcLu9V
ZyhvaPl+znSAP6QVO0q7sVZAf5FmAiJAa6fM0mMnhMvNm+jEUPGj/6qnw7/k5RbV
yPvkP5NWT9AzRSlNJduR1I7df4UZs57JV47C5PCSgbmcHREis8VWMDD86NutpTv2
hJnkaJnDQeVrAihcczp1Qo4MuySw+SF+Zwh3wtB9rhEYujMKpwbPLpuSqsOn4ihj
hYadqiMJJ4VoQQ6EAPSWHSoSghMrNuOYIAbYAbmtJuxJTGMBGQCS5cnZA3hNu8z2
hE7D6nLV64Sr7ZvP2GOf6zr8WuNbmxyXIrSl68X+GoE4BctKL6ZcxEKZ6vMEHswI
jbeuuuCrwGnWxLpzWwzr4jgsUu2MsLvhp4yW4271vNzE0oBuRMpFn6MBCwIlgKjj
kTsJjYm7Aoh2k+/8CwNZg0ewL/maRzAanEEdbI5uWa0xXTkBEuf+t43GQYcOvI2e
YywCdG8Lv1JoWn4E8ovCwKO56hVly4z+k6HoS//1SP8RGtmLcowsttgZ3GhD4Vkg
Dqdoqy1hUoa6UVYHgDxs
=bj6s
-----END PGP SIGNATURE-----

--nextPart2778484.jn6WS42W2a--

