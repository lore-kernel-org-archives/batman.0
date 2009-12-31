Return-Path: <andrew@lunn.ch>
Date: Thu, 31 Dec 2009 11:56:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091231105652.GJ8143@lunn.ch>
References: <20091204214251.GE29768@lunn.ch>
	<20091213190149.GA22421@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091213190149.GA22421@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [patchv2] batman-adv: Use printk(%pM) for
	MAC	addres
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

On Sun, Dec 13, 2009 at 08:01:49PM +0100, Simon Wunderlich wrote:
> Hello Andrew,
> 
> i've checked your patch against older kernel, and there seem to be some
> compile problems. E.g. compiling against 2.6.26, i find:
> 
>   CC [M]  /home/dotslash/msrc/batman-svn/batman-adv-kernelland/bat_printk.o
> /home/dotslash/msrc/batman-svn/batman-adv-kernelland/bat_printk.c: In function ???pointer???:
> /home/dotslash/msrc/batman-svn/batman-adv-kernelland/bat_printk.c:564: error: implicit declaration of function ???dereference_function_descriptor???
> /home/dotslash/msrc/batman-svn/batman-adv-kernelland/bat_printk.c:564: warning: assignment makes pointer from integer without a cast
> 
> against 2.6.21, there are a lot more lines of warnings and errors, while 
> 2.6.20 works mostly fine. Could you please review your patch in this regard? 
> I have nearly all kernels installed so i can give you a list of compile logs if you
> are interested.

Hi Simon

I just posted an updated version of the patch. It would be great if
you could test it on a few different kernels. I tried
2.6.21. bat_printk.c now compiles, but other parts of batman-adv fail.
I think it was your skbuff patches which broke it, but i could be
wrong.

	Andrew      
