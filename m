Return-Path: <michaelfazio@me.com>
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Message-id: <67B8674E-E8BB-4EE6-B368-F28AA0C957AB@me.com>
From: Michael Fazio <michaelfazio@me.com>
In-reply-to: <201003151944.27711.lindner_marek@yahoo.de>
Date: Mon, 15 Mar 2010 20:35:42 +0800
References: <8D692389-52C5-4CCB-BE58-D4B2E4D07161@me.com>
	<20100314204138.GA6096@Linus-Debian>
	<59537C95-BCEC-4E94-9E59-E0E96D289776@me.com>
	<201003151944.27711.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Suitability for MAGIC 2010
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

Marek,

		Woops! Forgot my own email subject! Silly me....

With regards to the type of middleware that I am searching for. Well,  
pub/sub with reliable and unreliable QoS is what we will most likely  
be using. I don't want to rush into a solution that buries the network  
in traffic from inter-broker communication, nor do I want to choose a  
middleware that fails in ad-hoc type networks. In any case, the  
middleware must hold up against repeated network partitioning and  
merging.

If we do use B.A.T.M.A.N we will likely be using the layer-2 flavor  
running on a router with openWRT. So drivers will not be an issue,  
just router selection.

I will be sure to share the tests if they occur!

Michael


On 15/03/2010, at 7:44 PM, Marek Lindner wrote:

>
> Hi,
>
>> Well I don't remember mentioning MAGIC 2010, but you are   correct,  
>> the
>> project is MAGIC 2010. Good investigatory work! :)
>
> the email's subject contained the necessary hints.  ;-)
>
>
>> Furthermore, message passing may not necessarily be done with the  
>> use of a
>> middleware. Realtime unreliable data such as GPS and telemetry  
>> information
>> may simply be pushed onto the network in UDP packets. I would  
>> prefer to
>> use a nice middleware that performs well in MANET environments and I
>> am still evaluating the possibility of this. If you have any
>> recommendations that would be good!
>
> What exactly are you looking for ("middleware" is a pretty broad  
> term) ? An
> application that can send GPS data through the network ?
>
>
>> Further on the topic of using BSS. We do expect wifi dead-spots and  
>> we
>> must absolutely try to minimize these. So the multi-hop nature of
>> something like B.A.T.M.A.N (i was hoping) would help in that regard.
>
> Yes, batman can help you "extending" the network. But the biggest  
> troublemaker
> will be the wifi driver because adhoc mode isn't that well  
> supported. 99% of
> the users want infrastructure mode, therefore developers work on  
> that first.
> Adhoc mode comes later (if at all), is often buggy and not well  
> tested. The
> wifi communities get around this issue by focussing on hardware  
> which either
> comes with an open driver (e.g. atheros chips) or have a working  
> adhoc mode
> implementation. Depending on how much freedom of hardware choice you  
> have I'd
> suggest you carefully pick your wifi chips.
>
>
>> I can't guarantee that we will use B.A.T.M.A.N but I will try to
>> evaluate it in the field eventually.
>
> Please, share the results of these tests with us. Even if you don't  
> choose
> batman we would be very interested to find out what we can  
> improve.  :-)
>
> Cheers,
> Marek
>

