Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 5 Jan 2010 17:50:37 +0800
References: <201001042344.02273.lindner_marek@yahoo.de>
	<20100105063146.GE9585@lunn.ch>
In-Reply-To: <20100105063146.GE9585@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001051750.37976.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv gateway support
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Tuesday 05 January 2010 14:31:46 Andrew Lunn wrote:
> Can this be made a bit more robust? An easy DoS would be to offer to
> be a gateway, but not run DHCP. All my near neighbours then fail to
> get an IP address and i have quiet network with more bandwidth for
> myself.

Good point. Before I had another scheme in mind: DHCP requests are broadcasted 
but the batman-adv client would filter the responses preferring the selected 
gateway if its reply is available. Of course, that is more complex to 
implement.


> Could we inspect the DHCP packet a bit more deeply, look for DHCP
> discovery packets, unicast 3 in 4 to the best gateway, broadcast 1 in
> 4 as a fallback.

I'm not sure this approach is feasible. As soon as we broadcast a single 
packet we might end up with a badly chosen gateway.

The batman daemon is able to blacklist broken gateways and switches to another 
one. We may want to do the same.

Regards,
Marek
