Return-Path: <andrew@lunn.ch>
Date: Wed, 24 Aug 2011 09:18:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110824071841.GA7895@lunn.ch>
References: <CAPjQAd9-g6ugSci1Y_5t1BOqZ-Pa2k=hGhyauV-09d1unq=ecA@mail.gmail.com>
	<30568448.oAQcoQ5y1R@sven-laptop.home.narfation.org>
	<CAPjQAd_kJT72R28f+0+xjLBp7gT-64U8xKKnVKQg2wbNvYiRkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjQAd_kJT72R28f+0+xjLBp7gT-64U8xKKnVKQg2wbNvYiRkA@mail.gmail.com>
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

> unique way.  And now that a standard is in place, everyone interested
> in mesh could benefit if there was a seventh (and final) version bump
> to bring it in line with IEEE 802.11s.

Hi Javier

I don't know that much about 802.11s, so i would be very happy to be
wrong....

I actually think IEEE 802.11s needs to first evolve and become part of
IEEE802.1. The problem is, mesh != wireless, so having it part of
802.11 limits its application way too much.

I've been to a few of the wireless battlemesh events and gained some
experience with real mesh network. One thing which is very clear to me
is, they are multi-technology. They mix 802.11, 802.3, cable modems,
VPN, and in theory, there is no reason why avian carriers could not be
used.

If you look at the mesh routing protocols represented in battlemesh,
static routes, babel, olsr, BMX, and batman{-adv} all are multi
technology and have no problem building one mesh over a heterogeneous
network.

What a mesh technology ideally wants is a collection of links which it
can send ethernet or IP frames over. So this puts it somewhere in
802.1, or a sublayer of IP.

You also said 802.11s contains device authentication, encryption,
etc. This also seems to me to be the wrong layering. These should be
generic services which any 802.11 "mode" above can use. Can these
services be used in adhoc mode or managed mode? If yes, great, anybody
setting up a static routes, babel, olsr, BMX, and batman{-adv} mesh
can just use there services.

My personal opinion is that taking the multi-technology batman-adv
protocol and shoehorning it into the single technology 802.11s is the
wrong way to go. What might however be interesting is taking a closer
look at 802.11s and see what can be generalized and moved up into
babel, olsr, BMX, and batman{-adv}, or merged into plain old managed
mode and adhoc mode 802.11 and offered as services to layers above.

       Andrew

