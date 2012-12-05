Return-Path: <andrew@lunn.ch>
Date: Wed, 5 Dec 2012 12:24:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20121205112435.GE26922@lunn.ch>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
 <20121205103527.GC26922@lunn.ch>
 <20121205110642.GD27828@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121205110642.GD27828@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> I think the major advantage here is that, whenever a person sends a
> patch which is not going to work on older kernels, he must also send
> a patch for compat.h/c.

Hi Antonio

This is where you are fighting again the kernel process. The kernel
process does not care about older kernels, expect for patches flowing
into stable as bug fixes. So anybody from outside of BATMAN will not
supply such compat.[ch] changes.

Maybe its also time to evaluate the value of older kernels with newest
BATMAN? Is the pain worth the gain? 

	Andrew
