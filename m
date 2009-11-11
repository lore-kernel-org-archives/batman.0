Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 11 Nov 2009 20:14:22 +0800
References: <200911082144.49637.lindner_marek@yahoo.de>
	<200911092239.01984.lindner_marek@yahoo.de>
	<591bc9930911101917j149b5ba5j666ddded7a0ceeb0@mail.gmail.com>
In-Reply-To: <591bc9930911101917j149b5ba5j666ddded7a0ceeb0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200911112014.23054.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 released
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

On Wednesday 11 November 2009 11:17:22 Donald Gordon wrote:
> One implementation possibility I was thinking of was adding yet another
> ethernet device that sat like a proxy in front of bat0.  It would fragment
> transmitted frames larger than the bat0 MTU (changing the ethernet frame
> type), and reassemble recieved frames.  This would push the load of frame
> fragmentation to the edge of the network, and shouldn't add too much
> overhead.  Does that sound like a reasonable way forward?  And if so, does
> anyone have any pointers on how to develop fake ethernet drivers?

If you look for simple interfaces then just dive into the bat0 code - it is 
exactly that. But at that point I doubt you would need yet another interface 
to achieve your goal. If you wanted your fragmentation happening at each 
beginning and ending of the mesh you easily could do that inside of the 
batman-adv code. The data will go in and out via bat0 ...

Besides, I'm not sure your approach will make everyone happy as you might have 
different MTUs throughout the network (e.g. see you batman over IP suggestion). 
The endpoints might have a higher MTU than a segment inbetween. In that case 
the fragmentation could not help.


>  Which means I'm also keen on some sort of integrated way to tunnel batman
>  packets over IP without the overhead of passing them to userspace through
>  a tun/tap but I guess that'll have to wait :-)

Well, if static tunneling solves the problem you easily could use GRE or 
similar techniques.

Regards,
Marek
