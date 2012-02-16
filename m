Return-Path: <martin@hundeboll.net>
Message-ID: <4F3CE080.6000409@hundeboll.net>
Date: Thu, 16 Feb 2012 11:54:56 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1328727958-16119-1-git-send-email-martin@hundeboll.net>
	<1328885591-10445-1-git-send-email-martin@hundeboll.net>
	<20120215192321.GA24703@pandem0nium>
In-Reply-To: <20120215192321.GA24703@pandem0nium>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [RFCv2] batman-adv: Add blocking of one hop OGM
 messages
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

Hi Simon,

On 2012-02-15 20:23, Simon Wunderlich wrote:
> Hey Martin,
>
> On Fri, Feb 10, 2012 at 03:53:11PM +0100, Martin Hundebøll wrote:
>>   13 files changed, 491 insertions(+), 0 deletions(-)
>
> please excuse my superficial review, but do we really need to bloat batman-adv
> by 491 more lines to drop these OGMs? I'm afraid the filter will evolve
> more and more, and eventually the research/debugging code in batman-adv
> is bigger than the routing code. ;)

Actually, I agree with you. The first patch was nice and (too) simple, but quickly grew :) My initial goal with the filtering was not to get it included in batman-adv, but just to make it available to others, who might need it. I use it in my work on the university and will continue to keep it updated on master.

> (sorry for ranting ;] )

We like to rant and bash :)
  
> Have you considered using and/or extending the former ebtables patch
> from Linus[1]? We removed [2] it after some discussions [3], but maybe
> its worth fixing these problems if its just about dropping some neighbors
> packets. The patch has some problems, but it was really short and I guess
> we wouldn't mind accepting the performance overhead by ebtables for
> research/debugging purposes. Plus, we could make this a compile-feature too.

With my approach, we only check OGMs, which is relatively cheap, compared to checking every incoming packet, which is why I didn't chose the netfilter path. At this point I am satisfied with the dropping of OGM's, so I don't think I will spend time looking into netfilter.

-- 
Kind regards,
Martin Hundebøll
Nordborggade 57, 2. 1
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net
