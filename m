Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 19 Jul 2016 18:13:16 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160719161316.GB10173@otheros>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1655869.LYQpVbDg6l@prime> <20160719062907.GA10173@otheros>
 <2594732.GzDknJdsZu@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2594732.GzDknJdsZu@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/6] batman-adv: speed up dat by
 snooping received ip traffic
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

On Tue, Jul 19, 2016 at 08:59:01AM +0200, Sven Eckelmann wrote:
> On Dienstag, 19. Juli 2016 08:29:07 CEST Linus Lüssing wrote:
> > What do you think about doing the same in batman-adv? That is,
> > only updating, but not creating DAT cache entries from IP traffic.
> > That should get rid of the main two concerns, accidentally
> > snooping routed IP traffic and performance implications, shouldn't it?
> 
> You have to snoop the traffic anyway and search in the dat cache for each(?) 
> packet. And the DAT cache is distributed. So why would it avoid the 
> performance implications?

I was talking about the local DAT cache. Not the DHT. Antonio and
I were thinking about a ratelimited DHT_PUT, too, but he wanted to give
it some further thoughts. No DHT_GET involved.

Also, Andreas already took care that the snooping code only uses
stack and not heap memory. No pskb_may_pull, just
skb_head_pointer()s. So if we were removing the DAT entry
creation, then there'd be no more kmalloc()'s.

A hashmap lookup in the local DAT cache shouldn't be that costly either,
should it? (and we are doing one such lookup for the originator
and translation table each already anyway)

Regards, Linus
