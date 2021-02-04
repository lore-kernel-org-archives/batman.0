Return-Path: <kuba@kernel.org>
Date: Thu, 4 Feb 2021 11:58:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 2/4] batman-adv: Update copyright years for 2021
Message-ID: <20210204115836.4f66e1c8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <3636307.aAJz7UTs6F@ripper>
References: <20210202174037.7081-1-sw@simonwunderlich.de>
	<20210202174037.7081-3-sw@simonwunderlich.de>
	<20210203163506.4b4dbff0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
	<3636307.aAJz7UTs6F@ripper>
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

On Thu, 04 Feb 2021 08:54:33 +0100 Sven Eckelmann wrote:
> On Thursday, 4 February 2021 01:35:06 CET Jakub Kicinski wrote:
> [...]
> > Is this how copyright works? I'm not a layer, but I thought it was
> > supposed to reflect changes done to given file in a given year.  
> 
> <irony>Because we all know that the first thing a person is doing when 
> submitting a change is to update the copyright year.</irony>
> 
> So we have either the option to:
> 
> * not update it at all (as in many kernel sources)
> * don't have it listed explicitly (as seen in other kernel sources)
> * update it once a year
> 
> I personally like to have a simple solution so I don't have to deal with this 
> kind of details while doing interesting things. The current "solution"
> was to handle the copyright notices year for the whole project as one entity - 
> once per year and then ignore it for the rest of the year.

Back when I was working for a vendor I had a script which used git to
find files touched in current year and then a bit of sed to update the
dates. Instead of running your current script every Jan, you can run
that one every Dec.

> And I would also prefer not to start a discussion about the differences 
> between the inalienable German Urheberrecht, pre 1989 anglo-american 
> copyright, post 1989 anglo american copyright and other copyright like laws.

No need, we can depend on common sense. I hope you understand that a
pull request which updates 8 lines of code, mostly comments, and then
contains a version bump + 57 lines of copyright bumps is very likely 
to give people a pause, right?

If you strongly prefer the current model please add appropriate commit
messages justifying it and repost. Right now patch 1 and 2 have none.
