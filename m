Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 12 Mar 2012 15:55:02 +0800
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
	<201203121541.04403.lindner_marek@yahoo.de>
	<CAG7VhQS9gJpSrpTL3K9w6K=tVo7fBm988SYA_io8YbNO9FYbeg@mail.gmail.com>
In-Reply-To: <CAG7VhQS9gJpSrpTL3K9w6K=tVo7fBm988SYA_io8YbNO9FYbeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201203121555.03282.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Monday, March 12, 2012 15:49:26 Daniele Furlan wrote:
> > I don't quite understand what you are proposing. Are you saying removing
> > the averaging mechanism makes this patch obsolete and allows replacing
> > the TTL/TQ values as the code does now (without the patch) ?
> 
> No no this patch is good, the removing of TQ average can be a following
> step as now average is not forwarded anymore, but only used as a
> comparative value between path in another point of the source code.

This follow-up step needs a volunteer. It is a bigger operation to remove the 
averaging and ensure everything still works.  :-)

Do you mind explaining in simple words how the averaging could cause routing 
havoc together with the strict OGM forwarding patch ? I did not understand.
Or are you in favor of removing the averaging for style / performance reasons?

Cheers,
Marek

