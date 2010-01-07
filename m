Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 7 Jan 2010 21:23:31 +0800
References: <200912181714.58212.lindner_marek@yahoo.de>
	<DE721D43-8031-4174-8357-DE4A475A7898@dd19.de>
In-Reply-To: <DE721D43-8031-4174-8357-DE4A475A7898@dd19.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001072123.32104.lindner_marek@yahoo.de>
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

On Thursday 07 January 2010 15:44:36 Alex Morlang wrote:
> are you considering attaching metrics to HNA?

That is not necessary as each non-batman host is connected to a batman host 
which has a metric. Therefore the implementation just needs to support the HNA 
metric. The batman daemon does so since quite a long time. It is on the 
feature list for batman-adv 0.3 but does not require any protocol changes 
unless I miss your point.


> How about ipv6?

I can't follow you here. The length of the protocol identifier (IPv4 
address/IPv6 address/mac address/random number) is not relevant for the 
routing protocol.

Regards,
Marek
