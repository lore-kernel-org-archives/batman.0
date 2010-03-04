Return-Path: <andrew@lunn.ch>
Date: Thu, 4 Mar 2010 10:03:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100304090355.GB29010@lunn.ch>
References: <20100303233946.GA24284@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100303233946.GA24284@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] vis packet format
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

On Thu, Mar 04, 2010 at 12:39:46AM +0100, Linus L??ssing wrote:
> Hi,
> 
> Marek and I have been chatting a little about the buggy vis raw
> output yesterday. And there was either the option to sort the
> mixed list on the receiving vis server or on the sender already.
> For the second option there was also the idea of changing the vis
> packet format accordingly to also save some more overhead.

A comment about the mainline development process. Changes which are
clearly bug fixes we should be able to get merged into the -rc kernels
at any time. Changes which look like development work have to wait
until the next merge window.

This vis problem about it showing the wrong interface will be in
-rc1. It would be nice to get it fixed. We are more likely to get such
a fix accepted if it is small and looks like a bug fix. I expect it
will get rejected if it is big and looks like development work.

So can we develop two fixes? Something small and simple for -rc1 and
an optimizing fix which will go into linux-next and then into mainline
during the next merge window?

       Andrew
