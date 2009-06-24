Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Jun 2009 22:38:14 +0800
References: <20090624082845.GS19149@ma.tech.ascom.ch>
In-Reply-To: <20090624082845.GS19149@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906242238.14487.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] originator tq_avg oscilations
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

On Wednesday 24 June 2009 16:28:45 Andrew Lunn wrote:
> I already tried changing TQ_GLOBAL_WINDOW_SIZE to 5 instead of 10 and
> that helped. Changing it to one is interesting. I've not tried it yet,
> but i would of thought some ring buffer was needed to handle the 0s
> which are added when originator messages are received for other
> neighbors.

Oh yeah, you right about the 0s.


> What ideas do you have for improving the algorithms. Depending on the
> scale of work needed i might have some time to do some coding.

I'd suggest we discuss this in a more interactive mode as chatting via IRC. 
What about the batman IRC channel ?

Regards,
Marek

