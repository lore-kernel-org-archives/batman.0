Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Sep 2011 02:10:04 +0200
References: <1315500051-1122-1-git-send-email-lindner_marek@yahoo.de>
	<201109220139.26897.lindner_marek@yahoo.de>
	<20110921.200539.1422752575190292433.davem@davemloft.net>
In-Reply-To: <20110921.200539.1422752575190292433.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201109220210.05025.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-09-08
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>

On Thursday, September 22, 2011 02:05:39 David Miller wrote:
> From: Marek Lindner <lindner_marek@yahoo.de>
> Date: Thu, 22 Sep 2011 01:39:26 +0200
> 
> >  To ensure a smooth transition and efficient testing later, we
> >  decided to offer a choice of routing algorithm but have not
> >  come to a final decision on how to design this choice yet. It
> >  either will be a compile time option, a module parameter or a
> >  runtime switch. Any suggestions / best practice tips ?
> 
> What do you mean by "algorithm"?  Do you mean the implementation
> of the data-structure used to perform lookups?
> 
> We had two data structures for our main routing table lookup
> implementation in ipv4, this was a mistake.  We spent the next couple
> years maintaining two pieces of code, and finally investing lots of
> effort to eliminate the older code.

No, the data structures for the routing lookups remain the same but there will 
be more than one way to fill them with data. You will only use one "filling 
algorithm" at a time, so you will need to select the one you want.

Regards,
Marek
