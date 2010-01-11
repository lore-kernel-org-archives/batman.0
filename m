Return-Path: <andrew@lunn.ch>
Date: Mon, 11 Jan 2010 09:06:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100111080643.GA7844@lunn.ch>
References: <4B4AD36A.60209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B4AD36A.60209@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Are older kernels abandoned?
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

On Sun, Jan 10, 2010 at 11:29:46PM -0800, Gus Wirth wrote:
> Now that work is under way to incorporate B.A.T.M.A.N (batman-adv) into
> the mainline Linux kernel, hopefully 2.6.33, will older kernels be
> abandoned?
> 
> I have some embedded systems that are on 2.6.30.10 and running fine, and
> I really don't want to have to put in a new kernel and recertify the
> software just to get some improvements to B.A.T.M.A.N.
> 
> Is there any consideration to doing something similar to compat-wireless
> but for B.A.T.M.A.N  (batman-adv) instead?

Older kernels are still supported. The development work is being
performed in subversion. This tree has all the backwards compatibility
code which allows it be compiled on some older kernels, currently
2.6.20 - 2.6.32.

I then take the code out of subversion and put it into git. The git
repository has all this backwards compatibility removed in order that
i can make clean patches for this development work for submission to
mainline in 2.6.34.

  Andrew
