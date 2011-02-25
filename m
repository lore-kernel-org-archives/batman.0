Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 25 Feb 2011 01:30:35 +0100
References: <4D668F3F.4080700@orxrail.com> <20110224194414.GA15337@Sellars>
	<4D66BBC9.80101@orxrail.com>
In-Reply-To: <4D66BBC9.80101@orxrail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201102250130.35865.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv mesh slows down wired clients
	(bridge-loop-avoidance)
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


Hi Vinay,

> I am having trouble finding binaries of batman-adv 2011.0 for OpenWRT . 
> Are they available or do I have to build them myself  ?

as Linus already pointed out - bridge loop avoidance is not available before 
batman-adv 2011.0.0. That is what you need to address first.

Where did you get the binaries for batman-adv 2010.1.0 ? Does this source also 
provide newer binaries ? Unlike user space application a kernel module heavily 
depends on your system (kernel version / patches / etc). Which means nobody 
can give you binaries without having access to exactly the same system you are 
using.

Regards,
Marek
