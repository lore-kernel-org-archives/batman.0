Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201203121541.04403.lindner_marek@yahoo.de>
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
	<20120311215039.GA26577@pandem0nium>
	<CAG7VhQSgki4O-nryuRR_-3SF7n1AKBoa70zGBH9-89KTdw-vQA@mail.gmail.com>
	<201203121541.04403.lindner_marek@yahoo.de>
Date: Mon, 12 Mar 2012 08:49:26 +0100
Message-ID: <CAG7VhQS9gJpSrpTL3K9w6K=tVo7fBm988SYA_io8YbNO9FYbeg@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

2012/3/12 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi,
>
>> I agree with this patch, actually it should solve the loop problem as it is
>> very similar to the proposed modification in my thesis.
>
> thanks for the feedback!
>
>
>> In this way I think it is not necessary a global window to average TQ
>> values but only the latest value can be sufficient. Doing this can be
>> re-implemented a mechanism to improve OGM reliability sending old TQ ant
>> TTL (and also sequence number) of the current best router if for example 2
>> OGM are missing.
>
> I don't quite understand what you are proposing. Are you saying removing the
> averaging mechanism makes this patch obsolete and allows replacing the TTL/TQ
> values as the code does now (without the patch) ?
>
No no this patch is good, the removing of TQ average can be a following step
as now average is not forwarded anymore, but only used as a comparative
value between path in another point of the source code.

Also the mechanism of forwarding OGM even if it does not come from the best
router can be added later, on top of this patch.

> Cheers,
> Marek



-- 
Daniele Furlan
