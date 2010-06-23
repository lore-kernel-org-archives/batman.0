Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 23 Jun 2010 17:53:23 +0200
References: <201006231620.11058.lindner_marek@yahoo.de>
	<201006231702.37242.lindner_marek@yahoo.de>
	<20100623151233.GK15420@lunn.ch>
In-Reply-To: <20100623151233.GK15420@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201006231753.24067.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add routing debug log
	accessible via debugfs
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
To: b.a.t.m.a.n@lists.open-mesh.org, Andrew Lunn <andrew@lunn.ch>

On Wednesday 23 June 2010 17:12:33 Andrew Lunn wrote:
> So you get one global setting, which affects all meshes? Should this
> maybe pushed into priv? Is there a use case for having different
> logging levels for different meshes in a node?

You got a point here. Someone could want to debug one mesh but not the other. 
I will move it into bat_priv then.

Cheers,
Marek

