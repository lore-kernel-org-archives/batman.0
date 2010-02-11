Return-Path: <andrew@lunn.ch>
Date: Thu, 11 Feb 2010 11:01:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100211100156.GI2900@lunn.ch>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch> <20100211094659.GH2900@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100211094659.GH2900@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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

On Thu, Feb 11, 2010 at 10:46:59AM +0100, Andrew Lunn wrote:
> Hi Linus
> 
> Here is a new version of the patch. I've tested it this time using
> five UML machines. It should not immediately opps now. 

Instead is will leak memory and crash after a while...

I will try to find the memory leak.

  Andrew
