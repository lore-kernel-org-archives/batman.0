Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 29 Jan 2011 19:00:50 +0100
References: <201101282346.16035.clemens-john@gmx.de>
	<1296323152.2725.6.camel@mytilus>
In-Reply-To: <1296323152.2725.6.camel@mytilus>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201101291900.51081.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Connecting through Batman advanced interface
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

> I think if we don't want to change back our configuration (batman-adv on
> vpn with its mtu-problems etc.) the simplest way would be connecting a
> usual router to the wrt54g.

I don't think the VPN is the problem here but the fact that you can't bridge 
an interface running in adhoc mode. Ad-hoc is "lacks" a field in the wifi header 
which makes bridging impossible.
However, I agree with your proposed solution - another router connected to the 
Ethernet of the wrt54g can solve the issue.

Regards,
Marek
