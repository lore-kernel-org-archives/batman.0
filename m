Return-Path: <andrew@lunn.ch>
Date: Sun, 15 Apr 2012 12:10:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120415101022.GB24461@lunn.ch>
References: <CA+wR77r2CfzDYbNKD+G+0vNV-OCsMYLbPKkHL_JhH5Ad7A3S6A@mail.gmail.com>
	<20120413162649.GB21399@lunn.ch>
	<CA+wR77q3GJMoCE4=DN9LQxQkww59D3o3xsQwk8ivoRuM3GBorw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+wR77q3GJMoCE4=DN9LQxQkww59D3o3xsQwk8ivoRuM3GBorw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Backwards Compatibility
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

On Sat, Apr 14, 2012 at 07:12:46PM +0300, NorthPole wrote:
> Hi Andrew
> 
> I googled bit and didnt find anything significant also I posted on
> kernel newbies mailing list and they couldnt help me.
> 
> SInce i'm completely new to kernel dev could you suggest a better way
> to look or a mailing list where I should ask?

Hi Spyros

First off, this is supposed to be Summer of code, not Spring of
code. So you have plenty of time.

I would probably look at this backwards around. You say on the wiki
page that wifi uses TLVs. So look in the kernel code for 802.11 and
see how IE are handled.

What other network protocols use TLVs? I know ATM signaling does, so
maybe look at the ATM code. However, ATM signaling is quite complex,
so maybe it is in user space?

What about protocols like Bluetooth? Frame relay? X.25, ISDN?

At the moment, you should just be getting an idea where are TLVs used
in the kernel. Once you know that you can decide what to do next...

Maybe there is no code?
Maybe there is lots of different implementations?
Maybe there is lots of different implementations, but no generic code?

Maybe, it makes sense to have one generic library in the kernel
and modify all the current code to use this library?

    Andrew

