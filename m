Return-Path: <ff@jluehr.de>
Message-ID: <539E9FF0.1040703@jluehr.de>
Date: Mon, 16 Jun 2014 09:42:40 +0200
From: =?ISO-8859-1?Q?Jan_L=FChr?= <ff@jluehr.de>
MIME-Version: 1.0
References: <539E0DEF.90703@jluehr.de> <1768207.ba35ClYi8x@diderot>
In-Reply-To: <1768207.ba35ClYi8x@diderot>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] DHCP-Monitoring of Gateways
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

Am 06/16/2014 08:14 AM, schrieb Marek Lindner:
> 
> Hi,
> 
>> we're running batman 2013.4, having multiple Gateways. For doing
>> so, we'd like to monitor the availability of every dhcp-server on
>> each Gateway.
>> 
>> I noticed: If DHCP-Packages (even unicast ones) that unicast 
>> DHCP-Requests / Discovery are unanswered, if -> they're sent
>> locally on a gateway -> sent to a gateway not "chosen" (according
>> to batctl gwl) by the monitoring host.
>> 
>> What's the best way of monitoring all DHCP-Servers? Is there a
>> way to set up a monitoring node, that can reach all
>> DHCP-Servers? If not, how can request an ip address locally?
> 
> if you don't wish batman to interfere with your DHCP requests I
> suggest to disable the gateway mode.

thanks for your feedback. I'd like to keep the gateway mode enable for
regular clients. It is sufficient to disable the gateway-mode on the
monitoring-node?

Thanks,
Jan

