Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201201272354.26055.lindner_marek@yahoo.de>
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
	<20120127151914.GB19664@lunn.ch>
	<201201272354.26055.lindner_marek@yahoo.de>
Date: Fri, 27 Jan 2012 19:17:36 +0100
Message-ID: <CAG7VhQRZ462=-eRiKPvQAOpruq-vWmmkrY-_qnUHsp5nBy2fKw@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: encourage batman to take
 shorter routes by changing the default hop penalty
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

Hi all,

2012/1/27 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi Andrew,
>
>> Do you have any performance analysis to show this is really helpful
>> and not harmful?
>>
>> I've seen indoor results where i had to reduce the hop penalty,
>> otherwise BATMAN was taking a short path which worked badly. By
>> reducing the hop penalty, so encouraging it to take more hops, i got
>> usable routes.
>>
>> I see the danger here this could break working networks, so maybe it
>> needs justification?

I have experencied the same situation in some tests, and I agree with Andrew
when he says that some form of justification is necessary.
>
> as a matter of fact I do believe it is helpful. In various networks (more than
> a dozen) I have seen that batman would largely favor multi-hop routes, thus
> reducing the overall throughput. By setting it to a higher value I regained
> some of its performance. The networks are still up & running - I can show them
> to you if you are interested.
>
> So, you had to reduce the default value of 10 to something even smaller ? A
> hop penalty of 10 results in a penatly of 4% per hop. A rough equivalent of 2
> lost packets (62/64). Does not sound very much to me. Can you explain your
> test setup a little more ?
>
> Nevertheless, this patch was intended to get a discussion going. The main
> problem I have been seeing in the last weeks is that OGM broadcasts have a
> hard time estimating the link quality / throughput on 11n devices. I'll also
> try to hack a proof of concept for an rssi influence on the routing and see if
> that has a better effect.

The problems of TQ emerges when the rate of devices increase, because especially
in mixed b,g,n networks TQ does not distinguish between fast and slow link.
We all know that brodcast losses does not say almost nothing about link speed
or load.

The only way to improve the TQ metric is a cross-layer implementation as already
experienced (considering only bandwidth) in my tests. Obviously this
means breaking
the "universal" compatibility with network interfaces, the use of
mac80211 and cfg80211
in any case can limit this problem in my opinion.

>
> Regards,
> Marek

Regards,
Daniele
