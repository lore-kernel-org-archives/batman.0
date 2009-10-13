Return-Path: <andrew@lunn.ch>
Date: Tue, 13 Oct 2009 09:48:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091013074837.GD21060@lunn.ch>
References: <20091012081122.GB12833@lunn.ch>
	<200910130048.49571.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200910130048.49571.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Changing vis output ready for mainline...
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

> So, the question is whether we want to make batctl the almighty tool that we 
> always depend on or are we trying to find alternative solutions to avoid that 
> dependency ?
> 
> One option for the case at hand might be debugfs 
> (http://lwn.net/Articles/115282/). It is another filesystem which needs to be 
> mounted seperately - there we can output whatever we want (unlike /proc). It 
> would be possible to create virtual files for the dot draw / json / raw output 
> (raw means the neutral format suggested by Andrew).

I personally don't like the idea of using debugfs for VIS. I would not
call the mesh topology debug information for kernel hackers, which is
the purpose of debugfs.

However i do see a compromise. 

1) Make /proc/net/batman-adv/vis the neutral format i suggested, or
something similar. Extend batctl to use this and apply formatting as
wanted.

2) Add a kernel module internal interface which allows other kernel
modules to get access to the raw VIS data. Write a batman-graphviz and
a batman-json kernel module which outputs the VIS data in formatted
text to debugfs.

If you don't want userspace dependencies, and you know your kernel
supports the optional debugfs, you can use the kernel modules. If not,
batctl will always work, it just requires you have a version which
understands the current proc format.

       Andrew
