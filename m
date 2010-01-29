Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 29 Jan 2010 16:59:59 +0800
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
In-Reply-To: <20100129082545.GI7844@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001291659.59677.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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

On Friday 29 January 2010 16:25:45 Andrew Lunn wrote:
> This is what Mareks patch does. However, this part of Marek's patch looks
>  wrong:

I'd like to point out that this lock wasn't introduced by my previously posted 
patch. I managed to reduce the effect of this lock but you can't remove it 
entirely without changing the whole sending mechanism.


> You are disable interrupts and then call send_vis_packet(). This will
> not work since all calls under send_vis_packet will have interrupts
> disabled.

Yes, that is correct. The reason for this is simple: The interrupt flags are 
stored in send_vis_packets() and without passing them on we can't re-enable 
the interrupts. That did not appear to be a good solution.  ;)
As far as I understand the vis_lock's only purpose is to avoid that the "info" 
pointer which is passed to send_vis_packet() can't be deleted while we use it. 
That might be better solved using reference counting. 

Cheers,
Marek
