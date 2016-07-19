Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 19 Jul 2016 18:15:37 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160719161537.GC10173@otheros>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1655869.LYQpVbDg6l@prime> <20160719062907.GA10173@otheros>
 <2594732.GzDknJdsZu@sven-edge>
 <754884F3-4762-43EA-81D7-D1904035D163@vfn-nrw.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <754884F3-4762-43EA-81D7-D1904035D163@vfn-nrw.de>
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

On Tue, Jul 19, 2016 at 09:06:38AM +0200, Ruben Wisniewski wrote:
> What exactly is the target of it? Just refresh the timer for arp entries? Why don't just ask the kernel arp table if it knows something bout the mac-address?

Yes, refreshing DAT cache entry timers more frequently was the
idea.

There usually is no entry in a host's ARP table if bridges are
involved, though. Which is the typical use-case with batman-adv.

Regards, Linus
