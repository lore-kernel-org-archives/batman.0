Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 12 Mar 2012 16:36:17 +0800
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
	<201203121555.03282.lindner_marek@yahoo.de>
	<CAG7VhQTT-x3WKXahkN5LCbEqFQnhT=0a5ZvX_JA=CRsfS1KdOA@mail.gmail.com>
In-Reply-To: <CAG7VhQTT-x3WKXahkN5LCbEqFQnhT=0a5ZvX_JA=CRsfS1KdOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201203121636.17494.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: avoid temporary routing
	loops by being strict on forwarded OGMs
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Monday, March 12, 2012 16:23:30 Daniele Furlan wrote:
> 2012/3/12 Marek Lindner <lindner_marek@yahoo.de>:
> > On Monday, March 12, 2012 15:49:26 Daniele Furlan wrote:
> >> > I don't quite understand what you are proposing. Are you saying
> >> > removing the averaging mechanism makes this patch obsolete and allows
> >> > replacing the TTL/TQ values as the code does now (without the patch)
> >> > ?
> >> 
> >> No no this patch is good, the removing of TQ average can be a following
> >> step as now average is not forwarded anymore, but only used as a
> >> comparative value between path in another point of the source code.
> > 
> > This follow-up step needs a volunteer. It is a bigger operation to remove
> > the averaging and ensure everything still works.  :-)
> 
> I can try  to send some patch next week to start this operation.. :)

Wow - cool!


> > Do you mind explaining in simple words how the averaging could cause
> > routing havoc together with the strict OGM forwarding patch ? I did not
> > understand. Or are you in favor of removing the averaging for style /
> > performance reasons?
> 
> Actually the average as it is calculated in the current version
> (without "considering" lost OGMs) is not monotonically decreasing. This
> cause routing loops when it is forwarded so with this patch the problem does
> not happen. 

That is what I thought. This patch also enforces monotonicity, thereby 
eliminating the loop "potential" created by averaging the TQ.


> Also maintaing only the latest TQ guarantee to have a more updated
> information about the path. Furthermore an average is already done at
> every link TQ calculation so it is superfluous to have another window.
> This reduce also memory and computational requirements.

Full agreement on this part. 
At the moment, I was more worried about temporary loops which seems to be 
addressed with this patch.

Thanks for all your feedback!

Cheers,
Marek
