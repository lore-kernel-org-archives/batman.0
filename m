Return-Path: <andrew@lunn.ch>
Date: Tue, 5 Jan 2010 07:31:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100105063146.GE9585@lunn.ch>
References: <201001042344.02273.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001042344.02273.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv gateway support
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

> * The third patch checks whether locally received packets are DHCP
> queries and forwards them via uncicast to the best gateway instead
> of broadcasting them.

Can this be made a bit more robust? An easy DoS would be to offer to
be a gateway, but not run DHCP. All my near neighbours then fail to
get an IP address and i have quiet network with more bandwidth for
myself.

Could we inspect the DHCP packet a bit more deeply, look for DHCP
discovery packets, unicast 3 in 4 to the best gateway, broadcast 1 in
4 as a fallback.

  Andrew
