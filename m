Return-Path: <andrew@lunn.ch>
Date: Mon, 30 Jan 2012 09:06:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120130080634.GC19664@lunn.ch>
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
	<20120127151914.GB19664@lunn.ch>
	<201201272354.26055.lindner_marek@yahoo.de>
	<20120127191334.GF27169@lunn.ch>
	<20120128141253.GF15766@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120128141253.GF15766@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: encourage batman to take
 shorter routes by changing the default hop penalty
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

On Sat, Jan 28, 2012 at 03:12:57PM +0100, Antonio Quartulli wrote:
> Hi all,
> 
> Very nice setup Andrew :)

I cannot take much credit for it. I helped write the project proposal,
but then was not allowed to take part in the project because of other
higher priority projects. The credit goes to Hochschule Luzern, Linus
and others.

> In my honest opinion we are mixing two different issues:
> 1) current hop penalty value not really significant
> 2) OGM link quality measurements do not reflect the metric we'd like it to be

Yes, i agree. However, in the scenarios we have seen in this project,
they are related. When OGM based TQ giving us too optimistic values, a
higher hop penalty makes this even worse.

However, comments so far suggest i'm in a corner case, and that for
others, a higher hop penalty does help. So for the moment, maybe
increasing the hop penalty is the right things to do, but remember
that once we have a better TQ measurement, that the hop penalty should
be examined again.

   Andrew
