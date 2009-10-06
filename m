Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Oct 2009 20:55:13 +0800
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910061143.08021.sven.eckelmann@gmx.de>
	<d9bba8670910060333i45d91b8eyc5fb1f1b05b94194@mail.gmail.com>
In-Reply-To: <d9bba8670910060333i45d91b8eyc5fb1f1b05b94194@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200910062055.14214.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> you can find as attachment the dump on eth2 of GW (tcpdump -ni eth2 -s 0 -w
> gw.cap);
> the output of batctl td -p 4 eth1 is:

I could not find anything revealing in the logs you provided. Could you please 
follow Sven's suggestion to log both ends as well ?

Just to not forget the obvious:
* What batman-adv version are you running ?
* GW1 routes the packets - does this work via NAT or do you manually add 
routing entries to both ends ?


> A question: am I the first one with this problem?

AFAIK batman-adv has no problem transporting TCP traffic (unless you found an 
undiscovered bug nobody has seen before). The most common source of trouble is 
the configuration of the setup, in particular MTU settings or routing issues 
(which is why most people simply bridge).

Regards,
Marek
