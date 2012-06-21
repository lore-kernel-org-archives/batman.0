Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 21 Jun 2012 10:28:17 +0200
References: <4FE1350E.9040807@versatic.net>
In-Reply-To: <4FE1350E.9040807@versatic.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206211028.18281.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] packets not processed by batman on eth0
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


Hi,

> I talked to marec last week on irc (I'm tahini).  I have a linksys
> router that runs batman on the eth0 interface and other routers or
> laptops are connected to it.  Problem is, even though the batman packets
> pass from the other machines to the linksys, it seems something weird
> happens on the linksys and the interface is not recognized as a batman
> neighbor.

the problem is that leon does not receive any packets from its neighbors. Its 
log only repeatedly states "Sending own packet" but no information about 
incoming packets is printed. If you compare it with the other logs you will 
see what I mean.
A common mistake leading to this symptom is a bridge misconfiguration. Is eth0 
on leon part of a bridge ?

Cheers,
Marek
