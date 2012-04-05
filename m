Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 5 Apr 2012 23:08:23 +0300
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-2-git-send-email-lindner_marek@yahoo.de>
	<20120323212233.GG5662@lunn.ch>
In-Reply-To: <20120323212233.GG5662@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204052308.23891.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/5] batman-adv: ELP - creating neighbor
	structures, updating LQs
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

On Friday, March 23, 2012 23:22:33 Andrew Lunn wrote:
> I've not looked at the code, but i assume this can happen because
> there is not a per algorithm receive handler? Maybe it makes sense to
> have a receive handler in algo structure, which can handle per
> algorithm receive functions? The common PDUs can be handled first and
> then a call into the algo receive function made to dispatch algo
> specific PDUs.

Each algorithm registers its own packet types which end up in the protocol 
specific receive function. Nevertheless, we might receive a B.A.T.M.A.N. V 
packet on an interface not running B.A.T.M.A.N. V. 

Regards,
Marek
