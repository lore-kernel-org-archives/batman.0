Return-Path: <andrew@lunn.ch>
Date: Thu, 13 Feb 2014 11:09:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140213100954.GE7193@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-16-git-send-email-antonio@meshcoding.com>
 <20140212091215.GI30814@lunn.ch> <52FB6525.7090001@open-mesh.com>
 <52FB6F04.3000404@openwrt.org> <52FB6F75.6070802@meshcoding.com>
 <20140213095527.GC7193@lunn.ch> <52FC981C.50309@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52FC981C.50309@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 15/23] batman-adv: ELP - send unicast ELP
 packets for throughput sampling
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: Felix Fietkau <nbd@openwrt.org>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> We can't use the hard_iface statistics because we need to know where
> that traffic has been sent to.

Oh, yes, my error.

> However, to go in the direction that you are suggesting, I could use the
> same API I use to read the throughput (cfg80211_get_station()) to also
> read when the last packet was sent to a given peer.
> This information should be good for our purposes, but it means that we
> probe the neighbours right after having read the throughput.

My guess is, there are not many use cases where the hard interface is
used for other traffic as well as BATMAN. So i don't see it as being a
big issue. Maybe put it onto a TODO list once the code has been
merged, to swap to using statistics from lower down in the stack.

   Andrew
