Return-Path: <kuba@kernel.org>
Date: Fri, 5 Feb 2021 11:37:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 2/4] batman-adv: Update copyright years for 2021
Message-ID: <20210205113701.4ab0e1a0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <4678664.8dpOeDNDtA@ripper>
References: <20210202174037.7081-1-sw@simonwunderlich.de>
	<3636307.aAJz7UTs6F@ripper>
	<20210204115836.4f66e1c8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
	<4678664.8dpOeDNDtA@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

On Fri, 05 Feb 2021 08:47:38 +0100 Sven Eckelmann wrote:
> On Thursday, 4 February 2021 20:58:36 CET Jakub Kicinski wrote:
> > Back when I was working for a vendor I had a script which used git to
> > find files touched in current year and then a bit of sed to update the
> > dates. Instead of running your current script every Jan, you can run
> > that one every Dec.  
> 
> Just as an additional anecdote: Just had the situation that a vendor 
> complained that the user visible copyright notice was still 2020 for a project 
> published in 2021 but developed and tested 2020 (and thus tagged + packaged in 
> 2020).
> 
> Now to something more relevant: what do you think about dropping the copyright 
> year [1]?

Interesting! In my own code I do option 1, copyright protection is
longer than the code I write is relevant :S 

3 seems to be what US lawyers like but frankly in the git era they are
probably overly lazy^W cautious.

Option 4 seems nice as well - it's really up to you(r lawyer).
