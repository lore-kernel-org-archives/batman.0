Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 8 Jun 2019 13:26:56 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v3 1/2] batman-adv: mcast: detect, distribute and
 maintain multicast router presence
Message-ID: <20190608112656.GA2503@otheros>
References: <20190526164829.4247-1-linus.luessing@c0d3.blue>
 <20190526164829.4247-2-linus.luessing@c0d3.blue>
 <3461137.lo7lFcuFkP@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3461137.lo7lFcuFkP@bentobox>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thu, Jun 06, 2019 at 05:48:32PM +0200, Sven Eckelmann wrote:
> On Sunday, 26 May 2019 18:48:28 CEST Linus Lüssing wrote:
> > If a multicast router is detected then this is signalized via the new
> > BATADV_MCAST_WANT_ALL_RTR4 and BATADV_MCAST_WANT_ALL_RTR6
> > multicast tvlv flags (which are sent flipped over the wire for backwards
> > compatibility - so that old nodes will always have them "set").
> [...]
> > @@ -691,7 +868,12 @@ batadv_mcast_mla_flags_update(struct batadv_priv 
> *bat_priv,
> >         batadv_mcast_bridge_log(bat_priv, flags);
> >         batadv_mcast_flags_log(bat_priv, flags->tvlv_flags);
> >  
> > +       /* toggle WANT_ALL_RTR flags as they are sent flipped on the
> > +        * wire for backwards compatibility
> > +        */
> >         mcast_data.flags = flags->tvlv_flags;
> > +       mcast_data.flags ^= BATADV_MCAST_WANT_ALL_RTR4;
> > +       mcast_data.flags ^= BATADV_MCAST_WANT_ALL_RTR6;
> >         memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
> 
> Ehrm, this sounds like it is a good way to confuse people. Have a packet field 
> which is called BATADV_MCAST_WANT_ALL_RTR4 but it actually means that it 
> doesn't have BATADV_MCAST_WANT_ALL_RTR4. So maybe we should call this 
> differently in batadv_packet.h's enum batadv_mcast_flags. 
> BATADV_MCAST_WANT_ALL_RTR4 -> BATADV_MCAST_WANT_NO_RTR4? And then switch the 
> logic in batadv_mcast_mla_rtr_flags_softif_get_ipv*, 
> batadv_mcast_mla_rtr_flags_bridge_get, batadv_mcast_mla_rtr_flags_bridge_get, 
> batadv_mcast_mla_softif_get_ipv*, ....
> 
> Or is it really necessary to have this enabled for older nodes?

No, I can swap that. Then we'd just need to make sure we really
and correctly swap the logic every else (which I initially wanted
to avoid, to be able to reuse as much code unmodified as possible as used
by the WANT_ALL_IPV{4,6} flags).

But you are right, when looking at things on the wire (through
Wireshark/tcpdump etc.) it might be confusing for the user to have the
bit flipped. I'll give the WANT_NO_RTR{4,6} a try to so we can
compare.
