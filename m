Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 4 Jan 2010 08:14:35 +0800
References: <1262454706-6137-1-git-send-email-sven.eckelmann@gmx.de>
	<20100102193718.GM31328@lunn.ch>
In-Reply-To: <20100102193718.GM31328@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001040814.35799.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Correct smaller typographical errors
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

On Sunday 03 January 2010 03:37:18 Andrew Lunn wrote:
> However, this basic description is not really correct, at least not
> for batman-adv. The throughput is not used in deciding on links to
> use. Maybe Marek should first review the document for technical
> correctness and then i can look at the English.

How about this:
B.A.T.M.A.N. proactively maintains information about the existence of all 
nodes in the mesh that are accessible via single-hop or multi-hop 
communication links and chooses the best path towards the destination based on 
statistical analysis of protocol packet loss and propagation speed.

@Sven: I applied all your patches (rev: 1530, 1531, 1532).

Regards,
Marek
