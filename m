Return-Path: <andrew@lunn.ch>
Date: Mon, 31 Aug 2009 07:28:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090831052853.GQ16067@lunn.ch>
References: <20090830013647.GA26017@Linus-Debian>
	<20090830195553.GA2410@pandem0nium>
	<20090830214719.GA3905@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090830214719.GA3905@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [patch] adding subgraph-feature to vis-output	in
	dot-file-format
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

Hi Linus, Simon

One of the things on the TODO list for mainline is to strip out all
the graphvis/JSON formatting done by the kernel and put it into user
space, probably batctl, or another standalone tool, or maybe even a
little library...

Why:

1) No other file in /proc does any special formatting.
2) What happens when one tool wants graphvis and another JSON, at the same time?
3) What happens when you want a third, forth, fifth format etc...

Are either of you interested on working on this? 

I guess the first step is to design a file format for vis in proc.  I
would suggest space separated values. Maybe one line per
vis_into_entry? I would also suggest the quality value is 0-255, not a
real number. User space, which has float support, can then turn it
into a float if need be.

     Andrew


