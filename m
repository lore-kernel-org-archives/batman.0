Return-Path: <andrew@lunn.ch>
Date: Thu, 25 Aug 2011 08:47:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110825064717.GA28359@lunn.ch>
References: <CAPjQAd9-g6ugSci1Y_5t1BOqZ-Pa2k=hGhyauV-09d1unq=ecA@mail.gmail.com>
	<30568448.oAQcoQ5y1R@sven-laptop.home.narfation.org>
	<CAPjQAd_kJT72R28f+0+xjLBp7gT-64U8xKKnVKQg2wbNvYiRkA@mail.gmail.com>
	<20110824071841.GA7895@lunn.ch>
	<CAPjQAd9nSQhRtfbfDsN-raqK2mo5NhuDWPxmt_FCvAS8ZYkf9w@mail.gmail.com>
	<CAEFj9860Ozj--PsaFAd1afAZwjapVC5S6JF8Dv0fZD8MkCvqBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEFj9860Ozj--PsaFAd1afAZwjapVC5S6JF8Dv0fZD8MkCvqBA@mail.gmail.com>
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
To: Yeoh Chun-Yeow <yeohchunyeow@gmail.com>
Cc: devel@lists.open80211s.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Clara Gnos <clara.gnos@googlemail.com>

On Thu, Aug 25, 2011 at 09:36:14AM +0800, Yeoh Chun-Yeow wrote:
> Hi, all,
> 
> Although batman-adv is a layer 2 routing that works across multiple access
> technologies (not so sure about other technologies, because it mainly use
> for WiFi), but it only make senses if we configure the wireless interface
> operating in adhoc or adhocdemo mode. If we configure the wireless interface
> as Infrastructure mode, all the traffic will go to the AP first, even if we
> can direct communicate between the two STAs.
> 
> Correct me if I am wrong.

Ideally, you have BATMAN on the AP as well as the STA. So you never do
STA->AP->STA hops between BATMAN nodes, you only do a STA->AP BATMAN
hop followed by a AP->STA BATMAN hop. Performing two BATMAN hops means
BATMAN knows the transmit quality of each of the two wireless hop, not
the combined transmit quality of the STA->AP->STA path. So BATMAN
running on the AP can then decide if it makes sense to take a
different path.

There is code to enforce this, i.e. blocking STA->AP->STA transfers,
in the development tree and it has been push upstream to be included
in the mainline kernel.

	 Andrew
