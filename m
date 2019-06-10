Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 11 Jun 2019 01:14:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 1/2] batman-adv: mcast: detect, distribute and
 maintain multicast router presence
Message-ID: <20190610231414.GA10498@otheros>
References: <20190610004535.13725-1-linus.luessing@c0d3.blue>
 <20190610004535.13725-2-linus.luessing@c0d3.blue>
 <1984348.Q8u5oXqQmF@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1984348.Q8u5oXqQmF@sven-edge>
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

On Mon, Jun 10, 2019 at 09:24:26AM +0200, Sven Eckelmann wrote:
> On Monday, 10 June 2019 02:45:34 CEST Linus Lüssing wrote:
> > @@ -107,12 +107,20 @@ enum batadv_icmp_packettype {
> >   * @BATADV_MCAST_WANT_ALL_UNSNOOPABLES: we want all packets destined for
> >   *  224.0.0.0/24 or ff02::1
> >   * @BATADV_MCAST_WANT_ALL_IPV4: we want all IPv4 multicast packets
> > + *  (both link-local and routeable ones)
> >   * @BATADV_MCAST_WANT_ALL_IPV6: we want all IPv6 multicast packets
> > + *  (both link-local and routable ones)
> > + * @BATADV_MCAST_WANT_NO_RTR4: we have no IPv4 multicast router and therefore
> > + * only need routeable IPv4 multicast packets we signed up for explicitly
> > + * @BATADV_MCAST_WANT_NO_RTR6: we have no IPv6 multicast router and therefore
> > + * only need routeable IPv6 multicast packets we signed up for explicitly
> >   */
> >  enum batadv_mcast_flags {
> >         BATADV_MCAST_WANT_ALL_UNSNOOPABLES      = 1UL << 0,
> >         BATADV_MCAST_WANT_ALL_IPV4              = 1UL << 1,
> >         BATADV_MCAST_WANT_ALL_IPV6              = 1UL << 2,
> > +       BATADV_MCAST_WANT_NO_RTR4               = 1UL << 3,
> > +       BATADV_MCAST_WANT_NO_RTR6               = 1UL << 4,
> >  };
> 
> I wonder what a good interpretation of 0x1f would be (all bits set). The code 
> doesn't seem to be able to handle this but an interpretation would be:
> 
> * get all unsnoopable
> * get all link-local but not rtr

Good question. Currently code-wise it's neither of those and
the BATADV_MCAST_WANT_ALL_IPV{4,6} is authoritative. So if those
are set then you'd get all IPv4/IPv6 multicast traffic regardless
of the other flags.

> * get all unsnoopable

That one does not make so much sense to me. That should be
covered by only setting BATADV_MCAST_WANT_ALL_UNSNOOPABLES and
would currently contradict the purpose of BATADV_MCAST_WANT_ALL_IPV{4,6},
wouldn't it?

> * get all link-local but not rtr

That could be another way to interpret it. It's an option we
currently do not have, the option to receive all IPv6 link-local but
not routeable IPv6 multicast traffic.

I'm currently unsure when we would need that. Are you suggesting
to interpret it that way, just in case we might need it some day?

Note that this would also be a "soft compatibility break". So old
nodes would still interpret 0x1f the same way as 0x07, meaning
they would send all multicast traffic to nodes announcing either
0x1f or 0x07. It'd be a "soft break" because it wouldn't cause
packet loss, old nodes would just overestimate.
