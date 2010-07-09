Return-Path: <greg@kroah.com>
Date: Fri, 9 Jul 2010 16:40:04 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100709234004.GA12128@kroah.com>
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
	<201007061736.14006.sven.eckelmann@gmx.de>
	<20100706161737.GA16045@kroah.com>
	<201007100107.57451.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201007100107.57451.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (3)
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sat, Jul 10, 2010 at 01:07:56AM +0200, Sven Eckelmann wrote:
> I have a small question about the topic "how to reduce the workload for you". 
> We send the patch which should integrate batman-adv into net/ around two weeks 
> ago to David S. Miller and the netdev@vger mailing list [1]. Some hours later 
> Hagen Paul Pfeifer responded with some questions and different ideas - which 
> we (batman developers and Henning Rogge from olsr) either answered and/or 
> started to discuss them.
> 
> The problem is that the discussion stopped quite fast... actually there was 
> only one mail from the netdev guys. This is quite irritating to me and the 
> question arose whether we did something terrible wrong when we send the patch.

Nope, you all did fine.

> Maybe you could give us a small hint how to proceed further. If we should 
> wait, poke around or maybe submit it in a completely different way. It is not 
> about "getting it into net right away", but we would really like to get some 
> responses so we can work on it to make it better.
> 
> batman-adv works quite well for us - but that doesn't mean that it is good in 
> context of the current kernel development. And who should know it better than 
> the netdev guys.

Try sending it again after a few more days with the comment, "everything
is addressed in the last round of comments" somewhere in it.

Persistance is key :)

thanks,

greg k-h
