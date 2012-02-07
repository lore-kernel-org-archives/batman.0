Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 7 Feb 2012 20:21:55 +0800
References: <201202071719.22804.lindner_marek@yahoo.de>
	<1328606451-3418-2-git-send-email-lindner_marek@yahoo.de>
	<20120207121200.GA15165@lunn.ch>
In-Reply-To: <20120207121200.GA15165@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201202072021.55937.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: randomize initial seqno
	to avoid collision
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

On Tuesday, February 07, 2012 20:12:00 Andrew Lunn wrote:
> Does this sequence number have any security relevance? Does it make
> sense to use the TCP sequence number generation code?

There is no security relevance I know of. The idea was simply to start with 
random number. Random is a bit better than 1.  ;-)

Where can I find the TCP sequence number code you are referring to ?

Regards,
Marek
