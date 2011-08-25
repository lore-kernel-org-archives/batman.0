Return-Path: <andrew@lunn.ch>
Date: Thu, 25 Aug 2011 09:27:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110825072719.GB28359@lunn.ch>
References: <CAPjQAd9-g6ugSci1Y_5t1BOqZ-Pa2k=hGhyauV-09d1unq=ecA@mail.gmail.com>
	<30568448.oAQcoQ5y1R@sven-laptop.home.narfation.org>
	<CAPjQAd_kJT72R28f+0+xjLBp7gT-64U8xKKnVKQg2wbNvYiRkA@mail.gmail.com>
	<20110824071841.GA7895@lunn.ch>
	<CAPjQAd9nSQhRtfbfDsN-raqK2mo5NhuDWPxmt_FCvAS8ZYkf9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjQAd9nSQhRtfbfDsN-raqK2mo5NhuDWPxmt_FCvAS8ZYkf9w@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] A case for batman-11s
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: devel@lists.open80211s.org, Clara Gnos <clara.gnos@googlemail.com>

> 802.11s is designed to fit within the IEEE 802 family of protocols (it
> was approved by the IEEE 802 Executive Committee in July).  You are
> correct in that 11s does restrict the mesh to be a wireless mesh.  But
> it is designed to connect to external networks via 802.1D bridges.
> 802.1D bridges have been around for ages and are good at
> interconnecting diverse MAC types without routing loops.  I read here
> (http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance) that
> batman implements its own loop-avoidance protocol which, from my
> limited perspective, seems redundant.

STP, RSTP protocols are good when the networks are nearly
perfect. However, wifi is no way near perfect, there is high packet
loss. So when deciding to block ports, to resolve loops, you want to
block the wireless part and keep the wired part working. It can be
hard to make STP and RSTP do this, it often blocks the wired part, so
making your overall network work badly. Read the page, it explains the
concept quite well.

> > You also said 802.11s contains device authentication, encryption,
> > etc. This also seems to me to be the wrong layering. These should be
> > generic services which any 802.11 "mode" above can use.
> > Can these services be used in adhoc mode or managed mode?
> 
> In 802.11 infrastructure mode you have only one authenticator (the AP)
> and many supplicants.  You cannot use the same security model in a
> mesh, when there are no such role divisions. 

BATMAN does not really care if the WiFi is in infrastructure mode of
adhoc. However, generally, it is used in adhoc. Maybe the 802.11s
authentication and encryption schemes don't make too much sense in
infrastructure mode, but it would be nice to be able to use them in
adhoc mode.

> Does batman-adv provide a security layer above the link layer
> security (and below IP)?  If so, where can I read more about that?

Nope. That is a problem for some other layer, e.g. the link layer
below, IPSEC above, TLS end to end etc...

> Based on my current understanding it looks like you could establish a
> batman-adv network over 1-hop 11s links.  Interesting.

I expect it will also work over 42-hop 11s links. It probably won't
have the "optimal" toplogy, by some definition of "optimal". 

> deployments (... and mesh battles :).  But it seems like batman's main
> strength is its ability to establish routes over heterogeneous links,
> not necessarily minimizing the spectrum utilization.

Actually, most of the mesh protocols i listed try to minimizing the
spectrum. They try to use wired as much as possible! Wired links give
a much better goodput compared to wireless, so that it is better to
take a longer low bandwidth looking path over wired than a shorter
higher bandwidth looking path over wireless.

I'm not a PHY person, but i've seen papers from coding/PHY people who
actually say you should be maximizing spectrum utilization, not
minimizing it. If i understand the research correctly, you get better
overall mesh performance by sending for a long time a 6Mbps at lower
power, compared to sending a short burst at 54Mbps at high power. To
receive at 6Mbps you need a much lower SNR than at 54Mbps. So you can
transmit at lower power, so causing less interference to others and
receive in a noisier environment at 6Mbps, than receive a 54MBps frame
which needs more transmit power and less background noise in order to
receive it. So 6Mbps at lower power allows more links to be active at
the same time, maximizing the overall mesh bandwidth/latency. But like
i said, i'm not a PHY person, so i might have this all wrong.

Most mesh protocols actually go partway towards this. They all roughly
approximate to "least number of hops over good links", by some
definition of "good link". Least hops generally means using long hops,
which will naturally have less bits per symbol, i.e more medium
time. All that is missing is power control in the wireless layer.

      Andrew
