Return-Path: <andrew@lunn.ch>
Date: Thu, 14 Jan 2010 21:03:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100114200359.GB24649@lunn.ch>
References: <5522db2e1001140540p7af82ba9gd52b375d54a2441d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5522db2e1001140540p7af82ba9gd52b375d54a2441d@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] network down timeout
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

On Thu, Jan 14, 2010 at 08:40:25AM -0500, ecfu wrote:
> Is there a configuration setting for batman-adv to timeout on a connection?
>  i.e. if I lose a node in my network, I noticed it took a long time for that
> node to leave the originators list.  What is this based on or in other words
> when does batman-adv declare the lost originator gone?

An originator is purged when it has not been heard from in 

#define PURGE_TIMEOUT 200000      /* purge originators after time in ms if no
                                   * valid packet comes in.

is 200s = 3.3 minutes.

   Andrew
