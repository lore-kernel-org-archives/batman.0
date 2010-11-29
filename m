Return-Path: <linus.luessing@web.de>
Date: Mon, 29 Nov 2010 21:36:54 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101129203654.GB5899@Sellars>
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
	<1289350093-5782-2-git-send-email-linus.luessing@ascom.ch>
	<201011101206.18881.lindner_marek@yahoo.de>
	<OFD539991B.AC1A53B7-ONC12577D7.0055C780-C12577D7.0055E665@ln.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFD539991B.AC1A53B7-ONC12577D7.0055C780-C12577D7.0055E665@ln.ascom.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: [PATCHv2] batman-adv: Allow
 promiscuous reception of unicast packets
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

Hi there,

Hmm, okay, and I made some further measurements. In typical
scenarios with "default" settings, I unfortunately could not
really get a reliability improvement. The thing is, due to the
multicast rate of 1MBit/s in common wifi drivers, I wasn't able to
put the devices close enough for the promisc-reception to take
effect without BATMAN switching to the direct, shorter path.
So I ended up setting the multicast rate to 48mbit/s and
could get a reliability improvement from 14.5% packet loss down to
about 9.5%. But of course, such a high multicast rate is not
feasible.

So it'd be ok to ommit this patch, unless/until someone might have some
further ideas to get the promisc-idea usable.

Cheers, Linus

On Wed, Nov 10, 2010 at 04:38:15PM +0100, Linus Luessing wrote:
> Marek Lindner <lindner_marek@yahoo.de> schrieb am 10.11.2010 12:06:18:
> 
> > [Bild entfernt] 
> > 
> > Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Allow promiscuous reception
> > of unicast packets
> > 
> > Marek Lindner 
> > 
> > an:
> > 
> > The list for a Better Approach To Mobile Ad-hoc Networking, Linus 
> Lüssing
> > 
> > 10.11.2010 12:08
> > 
> > [Bild entfernt] 
> > 
> > Von:
> > 
> > Marek Lindner <lindner_marek@yahoo.de>
> > 
> > An:
> > 
> > "The list for a Better Approach To Mobile Ad-hoc Networking" 
> > <b.a.t.m.a.n@lists.open-mesh.org>, Linus Lüssing 
> <linus.luessing@ascom.ch>
> > 
> > On Wednesday 10 November 2010 01:48:13 Linus Lüssing wrote:
> > > Firstly, a very mobile node moving towards the sender along the hop 
> path
> > > benefits from this as for such a mobility pattern the reception 
> probability
> > > increases, no matter how slow the topology convergence speed is.
> > 
> > Would you mind explaining why you think it helps for mobile nodes in the 
> 
> > scenario you mention ?
> > If I understand it correctly it helps for data originating from a 
> non-mobile 
> > node traveling towards the mobile node but this is less critical 
> > (assuming the 
> > mobile node has a higher orig interval).
> Correct, I was assuming equal intervals ;). Yes, this is usually not 
> critical, but just
> found it note worthy anyway, that you could possibly move towards the 
> sender along the
> path as fast as you wish without losing the stream from the sender, being 
> independent
> of the receivers OGM interval.
> 
> > For data originating at the mobile 
> > node traveling towards the non-mobile node it will only help if 
> bothnodes are 
> > single hop neighbors.
> That's not what I've been claiming afaik :). And if both nodes are just 
> one hop away, then
> you don't have any advantage of this promisc-reception anyway.
> 
> Hope that paragraph did not cause too much confusion, if you think there's 
> something misleading
> in it, I can change it, no problem.
> 
> > 
> > Regards,
> > Marek
> 
> Cheers,
> Linus
> 
