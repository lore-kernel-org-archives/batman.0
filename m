Return-Path: <alx@dd19.de>
Message-Id: <914B198A-C2DA-4222-9306-B81CFFE88284@dd19.de>
From: Alex Morlang <alx@dd19.de>
In-Reply-To: <201001072123.32104.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Thu, 7 Jan 2010 17:10:39 +0100
References: <200912181714.58212.lindner_marek@yahoo.de>
	<DE721D43-8031-4174-8357-DE4A475A7898@dd19.de>
	<201001072123.32104.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. V outlook
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


Am 07.01.2010 um 14:23 schrieb Marek Lindner:

> On Thursday 07 January 2010 15:44:36 Alex Morlang wrote:
>> are you considering attaching metrics to HNA?
>
> That is not necessary as each non-batman host is connected to a  
> batman host
> which has a metric. Therefore the implementation just needs to  
> support the HNA
> metric. The batman daemon does so since quite a long time. It is on  
> the
> feature list for batman-adv 0.3 but does not require any protocol  
> changes
> unless I miss your point.

maybe you do, as you might have costs between the connected network  
and the connecting batman node.

when you have more then one batman node connecting a network to the  
mesh, this costs should be relevant.

>
>
>> How about ipv6?
>
> I can't follow you here. The length of the protocol identifier (IPv4
> address/IPv6 address/mac address/random number) is not relevant for  
> the
> routing protocol.
>

ok, i thought you were talking about an implementation, so i asked  
about support for this addresstype.

so am i right in thinking the next batman will be protocol independent?

> Regards,
> Marek

Gruss, Alex

