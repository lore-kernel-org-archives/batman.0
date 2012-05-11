Return-Path: <andrew@lunn.ch>
Date: Fri, 11 May 2012 21:23:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120511192347.GA14707@lunn.ch>
References: <1336760987-1523-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1336760987-1523-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Prefix non-static
 functions with batadv_
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

On Fri, May 11, 2012 at 08:29:46PM +0200, Sven Eckelmann wrote:
> batman-adv can be compiled as part of the kernel instead of an module. In that
> case the linker will see all non-static symbols of batman-adv and all other
> non-static symbols of the kernel. This could lead to symbol collisions. A
> prefix for the batman-adv symbols that defines their private namespace avoids
> such a problem.

Hi Sven

Two probably dumb questions...

1) Did you use objdump to check for any symbols you missed?

2) A quick look at the patch suggests its changing function names. Are
   there any variables with global scope?

Thanks
	Andrew   
