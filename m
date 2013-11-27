Return-Path: <linus.luessing@web.de>
Date: Wed, 27 Nov 2013 07:32:04 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20131127063204.GE5457@Linus-Debian>
References: <20130912093641.GX1558@medion.lan> <5233571B.3050405@sotun.de>
 <20130915075534.GI11829@medion.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130915075534.GI11829@medion.lan>
Subject: Re: [B.A.T.M.A.N.] fool batman by simulating a layer3 mesh
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

Hi Bastian,

Did you have a chance to try the iptables + netfilter_bridge hook
(I believe via the iptables physdev module?) Antonio suggested
yet?

It sounds like a good idea to me and since no one seems to have
tried it with batman-adv yet I'm curious whether it works well in
practice.

Whether you could enhance the user experience in an open,
batman-adv based community mesh network by having an IP instead
of connection based sharing of available bandwidth.

Cheers, Linus


On Sun, Sep 15, 2013 at 09:55:34AM +0200, Bastian Bittorf wrote:
> * Jan Huwald <jh@sotun.de> [13.09.2013 20:37]:
> > How do you handle the splash status of a user under roaming? Does a
> > splash screen reoccur if the gateway is switched (NODE-2 -> NODE-3)?
> > Because this switch will happen on a minutely basis if a user sits
> > between two equally strong gateways.
> 
> Splashing is only done for clients which have a lease from this
> node. All other traffic gets just true (picopeer alike). After
> some minutes the information that "IPx/MAC must be shaped like..."
> is applied in the hole network. If the client only has a lease but
> is not "unsplashed" this information is also spread netwide.
> 
> A little bit ugly, but works and we have no memory or load problems
> anymore on the gateway. (~1000 clients)
> 
> bye, bastian
