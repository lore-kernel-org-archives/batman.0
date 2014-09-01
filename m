Return-Path: <linus.luessing@web.de>
Date: Mon, 1 Sep 2014 09:27:46 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140901072746.GG6470@odroid>
References: <1407007130-23077-1-git-send-email-linus.luessing@web.de>
 <201408081606.01045.sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201408081606.01045.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Enhancements for Unsolicited Neigh. Adv. / grat
 ARP Reply
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Fri, Aug 08, 2014 at 04:06:00PM +0200, Simon Wunderlich wrote:
> > Currently these ugly unsol. NAs cause about 40% of ICMPv6 multicast
> > overhead in our networks here.
> 
> I think it's quite a good idea - to motivate your proposal, I'd suggest to add 
> some information on how many broadcasts you think you can save in your 
> networks - 40% of ICMPv6 traffic is a little vague, since we don't know how 
> much of your traffic is ICMPv6 and what you have already blocked.

Hrmpf, had spend some time to set up some live-monitoring plus
dumping into RRDs. And now figured out, that from day to it varies
a lot, the NA traffic at Freifunk Hamburg for instance is very
"peaky", so only at certain minutes but then quite a lot. Some
days I see 40% again, some days it's maybe just 5-10%.

So at least along half of a day NA overhead is actually marginal.

I'll need to figure out first what's causing these spikes. Whether
it's some broken or malicious client devices, the bus and train
tables or something else causing these extreme spikes. Funnily,
any other multicast traffic is smoothly following the
#number-of-clients curve along the day (max at ~13:00, min at
~04:00)...

Cheers, Linus
