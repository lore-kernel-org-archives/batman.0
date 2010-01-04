Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 4 Jan 2010 18:31:49 +0800
References: <1262454706-6137-1-git-send-email-sven.eckelmann@gmx.de>
	<201001040814.35799.lindner_marek@yahoo.de>
	<20100104062025.GA3750@lunn.ch>
In-Reply-To: <20100104062025.GA3750@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001041831.49389.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Correct smaller typographical errorsy
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

On Monday 04 January 2010 14:20:25 Andrew Lunn wrote:
> > B.A.T.M.A.N. proactively maintains information about the existence
> > of all nodes in the mesh that are accessible via single-hop or
> > multi-hop communication links and chooses the best path towards the
> > destination based on statistical analysis of protocol packet loss
> > and propagation speed.
> 
> It is good. I guess i would split it into two sentences.
> s/ and /. It /
> 
> I will try to find time to read through the entire man page.

I just found the manpage section Sven was talking about. This quote was a bit 
out of context because B.A.T.M.A.N. indeed considers the throughput when 
choosing the best gateway. This probably sounds better:

In level 1, B.A.T.M.A.N tries to find the best available connection by 
considering the gateway's advertised throughput as well as the link quality 
towards the gateway.

Regards,
Marek
