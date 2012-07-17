Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120717182254.GN4015@lunn.ch>
References: <CAKLmikNDZQL2bDWYMMUHcHA5WTMj2Ou0yFiZ7wg134OHFQZWrw@mail.gmail.com>
 <201207161202.45306.lindner_marek@yahoo.de>
 <CAKLmikOuvdvdzV+UD-qr=FSKA0s+1yMHcdYr4GU6S4VzvqcMcw@mail.gmail.com>
 <201207171257.23627.lindner_marek@yahoo.de>
 <CAKLmikPKq3Ys8L=wtc08-GBeX04huu85OYJR17MByqOBGbi6sw@mail.gmail.com>
 <20120717182254.GN4015@lunn.ch>
Date: Tue, 17 Jul 2012 12:29:02 -0700
Message-ID: <CAKLmikNosnGfr+Qx4KV39mmjcA1M-+VqpM7Nd6B_GQpXwjA_4Q@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi!

On Tue, Jul 17, 2012 at 11:22 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> You have to be careful with packet reordering.

Hm. True. Yes, maybe multipath routing is just in theory a good idea.
;-) I also don't really believe in it. Or even believe it is
necessary. But some balancing could be useful to have. For example,
based on origin. So all packets from same origin goes on the same
link, and the other on the other. Is this possible to achieve?

> Are these assumptions really true? In my home setup, my ADSL modem is
> where my telephone socket is. My VPN server is somewhere else and
> there is a wifi and a powerline link in between. If my neighbors swamp
> the wifi channel with their torrent download, my VPN will
> suffer. (Well not really, i known this wifi stuff better than my
> neighbors)

I think we talk about different topologies here. We have a gateway
server on collocation, with VPN servers spread around the country. We
connect all nodes to those VPN servers, and VPN servers to gateway
server. We do not use ADSL uplinks for anything else than just to
connect to those VPN servers.

I am not talking about user's VPN servers, but network's. The ones
which allow nodes to be in the same network even if there is no (yet)
existing WiFi link between them.


Mitar
