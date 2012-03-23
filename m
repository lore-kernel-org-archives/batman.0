Return-Path: <andrew@lunn.ch>
Date: Fri, 23 Mar 2012 07:34:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120323063418.GB5662@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201203222250.31309.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] ELP
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

> cat /sys/kernel/debug/batman_adv/routing_algos 
> Available routing algorithms:
> BATMAN IV
> BATMAN V
> 
> To activate B.A.T.M.A.N. V (ELP) you should run the following command *before*
> adding any interface via batctl:
> 
> echo -n "BATMAN V" > /sys/module/batman_adv/parameters/routing_algo

Hi Marek

How about BATMAN_V and BATMAN_IV, so avoiding the need for "" or \
escaping of the space?

    Thanks
	Andrew
