Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 4 Jul 2011 14:55:32 +0200
References: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
In-Reply-To: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201107041455.33023.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv 2011.1.0
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

On Monday, July 04, 2011 14:45:57 Max Ip wrote:
> sudo iptables -A INPUT -s 10.42.43.3 -j DROP
> 
> When, I now run batman-adv protocol, node_1 still finds node_3 without
> node_2 being involved.
> 
> Though they cannot ping and avahi doesn't run, batman-adv shows them
> as 1 hop neighbors.
> 
> How can I disconnect node_1 from node_3 so that I can see the 2 hop
> patterns.

batman-adv operates on layer 2 - the mac address layer. IP addresses are 
irrelevant for the mesh to work. You can remove all IP addresses and the nodes 
still find each other (try batctl ping or batctl traceroute when you have no 
IP addresses configured). Therefore blocking the IP traffic does not interrupt 
anything. You'd have to block mac addresses via ebtables or similar tools.

Regards,
Marek
