Message-Id: <0C69D8C5-D212-4615-937B-B448397664AE@gmail.com>
From: Scott Raynel <scottraynel@gmail.com>
In-Reply-To: <20080717080054.GA15826@hrz.tu-chemnitz.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv-kernelland linux-2.6.21
	compatibility
Date: Thu, 17 Jul 2008 23:32:58 +1200
References: <A2A8A9D0-44EF-4330-8AEE-4A17F741C109@gmail.com>
	<20080717080054.GA15826@hrz.tu-chemnitz.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Simon,

On 17/07/2008, at 8:00 PM, Simon Wunderlich wrote:

> Hey Scott,
>
> thank you for the patch, it looks good to me so i applied it. Having a
> compat.h is a good idea, maybe we should use it even more to get rid  
> of
> some ugly #ifdef's. :)
> I've tested your patch against various kernels, it seems to work until
> 2.6.20, but breaks for 2.6.19.

Great, thanks. The idea of a compat.h for those macros is blatantly  
stolen from madwifi, which I'm a casual contributor to :) If I get  
some more spare time I'll look at fixes for earlier kernels, but I  
needed to target 2.6.21 with a project I'm working on, hence the  
patch :)

>
>
> We welcome any kind of patches, so don't hesitate to submit. We can
> integrate them directly (like your patch) or offer them on our  
> homepage
> (like the quagga patches [1]).
>

I'll keep that in mind - hopefully as we start to play with the module  
some more I'll be able contribute further.

Cheers,

--
Scott Raynel
WAND Network Research Group
Department of Computer Science
University of Waikato
New Zealand



