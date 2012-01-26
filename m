Return-Path: <andre_mailinglist@net-forces.com>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1251.1)
From: Andre Courchesne <andre_mailinglist@net-forces.com>
In-Reply-To: <201201270313.19652.lindner_marek@yahoo.de>
Date: Thu, 26 Jan 2012 15:39:24 -0500
Content-Transfer-Encoding: 7bit
Message-Id: <53319420-548B-407C-94EA-AD8BA1B3F73C@net-forces.com>
References: <9AAB212A-A9C6-41CD-BACA-0BA1542FA8F5@net-forces.com>
	<201201270313.19652.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] ap_isolation issue
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

Sorry for the reply on the other post, getting tired I guess...


So...

Ok, disabling loop avoidance has no effect.

Has ap_isolation been tested in this type of scenario?


On 2012-01-26, at 2:13 PM, Marek Lindner wrote:

> 
> Hi,
> 
>>  We are trying to get OpenWRT with batman-adv 2011.4.0 to play nice using
>> ap_isolation. However as soon as ap_isolation is turned on the meshed ap
>> are not acessible anymore by our Linux firewall on which at least 1 ap
>> node is physically connected. The following pastebin post shows the exact
>> configuration and details:
>> 
>> 	http://pastebin.com/2bghWLkp
> 
> how is the Linux firewall connected to batman-adv-AP#1 ? Via eth0 ? 
> Can you please also add the output of "batctl if" and "batctl sn" on all 
> devices ?
> 
> What happens if you disable the bridge loop avoidance ? Does it have any 
> effect ?
> 
> You are implying that disabling and then re-enabling the ap isolation also 
> fixes the "ping problem" ? 
> 
> Regards,
> Marek

