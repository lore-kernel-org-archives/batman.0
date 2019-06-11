Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 11 Jun 2019 16:12:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 1/2] batman-adv: mcast: detect, distribute and
 maintain multicast router presence
Message-ID: <20190611141214.GA2877@otheros>
References: <20190610004535.13725-1-linus.luessing@c0d3.blue>
 <1984348.Q8u5oXqQmF@sven-edge> <20190610231414.GA10498@otheros>
 <1705254.clgQh6sisM@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1705254.clgQh6sisM@sven-edge>
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

On Tue, Jun 11, 2019 at 07:44:12AM +0200, Sven Eckelmann wrote:
> On Tuesday, 11 June 2019 01:14:14 CEST Linus Lüssing wrote:
> > I'm currently unsure when we would need that. Are you suggesting
> > to interpret it that way, just in case we might need it some day?
> > 
> > Note that this would also be a "soft compatibility break". So old
> > nodes would still interpret 0x1f the same way as 0x07, meaning
> > they would send all multicast traffic to nodes announcing either
> > 0x1f or 0x07. It'd be a "soft break" because it wouldn't cause
> > packet loss, old nodes would just overestimate.
> 
> I am just unsure how we could/would interpret this in the future. Not that we 
> need support for it in the first version.

Ah, okay. Yes, then I think I would prefer to interpret WANT_ALL_IPV{4,6} +
WANT_NO_RTR{4,6} as WANT_ALL_LL{4,6} in the future (just, but all
link-local).

I'll change the code in PATCH 1/2 to always unset WANT_NO_RTR{4,6}
in the transmitted TVLV if WANT_ALL_IPV{4,6} is set for now, to allow to
reuse and interpret it that way in the future.


(An alternative would have been to keep it as is and adding
another flag in the future if the use case for all-link-local-only
came up. The advantage of transmitting WANT_NO_RTR{4,6} independent of
WANT_ALL_IPV{4,6} would have been some additional (debug) information.
But on the other hand, adding yet another flag in the future would just
get more messy/confusing.)
