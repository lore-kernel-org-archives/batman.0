Return-Path: <andrew@lunn.ch>
Date: Tue, 17 Jul 2012 20:22:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120717182254.GN4015@lunn.ch>
References: <CAKLmikNDZQL2bDWYMMUHcHA5WTMj2Ou0yFiZ7wg134OHFQZWrw@mail.gmail.com>
 <201207161202.45306.lindner_marek@yahoo.de>
 <CAKLmikOuvdvdzV+UD-qr=FSKA0s+1yMHcdYr4GU6S4VzvqcMcw@mail.gmail.com>
 <201207171257.23627.lindner_marek@yahoo.de>
 <CAKLmikPKq3Ys8L=wtc08-GBeX04huu85OYJR17MByqOBGbi6sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKLmikPKq3Ys8L=wtc08-GBeX04huu85OYJR17MByqOBGbi6sw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Route selection over VPN links
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Tue, Jul 17, 2012 at 11:06:27AM -0700, Mitar wrote:
> Hi!
> 
> On Tue, Jul 17, 2012 at 3:57 AM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> > I was more curious about the bandwidth routing than the latency stuff. The
> > current routing algorithm already takes latency into account. An alternate
> > path always need to be better than the current path. If both paths are equal
> > the faster packets win the race.
> 
> Hm. This happens only first time, it does not really change the route
> latter on, if chosen path latency increases and becomes worse than the
> second path, but packet loss stays the same (zero). Or it does?
> 
> For bandwidth, I would say that we first need multipath routing. And
> then route on all possible paths some percentage of packets, based on
> given capacity ratio. So if you have three paths A, B, and C with same
> packet loss and capacity Ca, Cb, and Cc, you route over A with Ca/(Ca
> + Cb + Cc) ratio.

You have to be careful with packet reordering. If i remember
correctly, Linus did some measurements when link bonding was
introduced in BATMAN. TCP can cope with packet reordering, but it has
negative effects on goodput.

...

> This would do correct thing for the case of VPN links, where most of
> links will have almost zero packet loss, latency will be or small (for
> local VPN servers) or big (for foreign VPN servers), and then based on
> free capacity we would route on that.

Are these assumptions really true? In my home setup, my ADSL modem is
where my telephone socket is. My VPN server is somewhere else and
there is a wifi and a powerline link in between. If my neighbors swamp
the wifi channel with their torrent download, my VPN will
suffer. (Well not really, i known this wifi stuff better than my
neighbors)

   Andrew

