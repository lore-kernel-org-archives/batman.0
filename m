Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 13 Nov 2012 18:04:49 +0800
References: <1350479255-904-1-git-send-email-linus.luessing@web.de>
 <trinity-466685df-dab6-476d-be38-9f1320389eff-1350499385870@3capp-webde-bs10>
 <20121017184839.GS7023@ritirata.org>
In-Reply-To: <20121017184839.GS7023@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211131804.49542.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Do not add multicast MAC
	addresses to translation table
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

On Thursday, October 18, 2012 02:48:39 Antonio Quartulli wrote:
> > Hm, no, I do not have a specific scenario in mind. I only accidentally
> > noticed such an FF:FF:FF:FF:FF:FF mac address in our vis graph here when
> > I made a typo with the tool 'mausezahn'.
> >
> > 
> >
> > I don't know of any RFC or so which would generally forbid using a
> > multicast source MAC for every ether type (although for sane IPv4/v6
> > stacks I haven't seen something like this before either and yes, I bet
> > it's not allowed there).
> >
> > 
> >
> > The Linux bridge I had on top of bat0 was happily forwarding such frames
> > into batman-adv. So I thought doing it like the bridge code - forwarding
> > but with no learning - might be the right way?
> 
> I think you are right. We should not care about the payload logic. If that
> is not allowed for the upper layer, then that layer will drop the packet
> once received.
> 
> 
> So we should keep forwarding such packets and yes, we should prevent
> learning from them. Therefore:
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision 9868989.

Thanks,
Marek
