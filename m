Return-Path: <alx@dd19.de>
Message-Id: <FA411C2E-E989-4352-9ACC-3D8B7653031E@dd19.de>
From: Alex Morlang <alx@dd19.de>
In-Reply-To: <20100107211430.GA5373@pandem0nium>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Thu, 7 Jan 2010 23:39:37 +0100
References: <200912181714.58212.lindner_marek@yahoo.de>
	<DE721D43-8031-4174-8357-DE4A475A7898@dd19.de>
	<201001072123.32104.lindner_marek@yahoo.de>
	<914B198A-C2DA-4222-9306-B81CFFE88284@dd19.de>
	<20100107211430.GA5373@pandem0nium>
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


Am 07.01.2010 um 22:14 schrieb Simon Wunderlich:

> Hello,
>
> we probably did not make this very clear in the document, but we will
> focus our work on batman-adv (layer 2) and will keep the batmand  
> (layer 3)
> as it is for now. As a consequence, some ideas for BATMAN V are  
> layer 2
> exclusive (mesh bonding, incoming interface based routing).

thanks for that clarification.

>
> On Thu, Jan 07, 2010 at 05:10:39PM +0100, Alex Morlang wrote:
>>
>> Am 07.01.2010 um 14:23 schrieb Marek Lindner:
>>
>>> On Thursday 07 January 2010 15:44:36 Alex Morlang wrote:
>>>> are you considering attaching metrics to HNA?
>>>
>>> That is not necessary as each non-batman host is connected to a  
>>> batman
>>> host
>>> which has a metric. Therefore the implementation just needs to  
>>> support
>>> the HNA
>>> metric. The batman daemon does so since quite a long time. It is on
>>> the
>>> feature list for batman-adv 0.3 but does not require any protocol
>>> changes
>>> unless I miss your point.
>>
>> maybe you do, as you might have costs between the connected network  
>> and
>> the connecting batman node.
>>
>> when you have more then one batman node connecting a network to the
>> mesh, this costs should be relevant.
>>
> That might be true, however in batman-adv we are dynamically adding  
> and
> removing MAC addresses. IMHO, it would not make so much sense to
> add custom metrics to each mac address. If you need to connect  
> subnets,
> it might be feasible to use something like BGP and extract batman  
> metrics
> out of the module.

sure, but as i understand, you have no way of exporting STP and RSTP   
path costs into batman, which could make sense in a mixed wired/ 
wireless enviroment.
...

> best regards,
> 	Simon

Gruss, Alex

