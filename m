From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 21 May 2009 03:02:22 +0800
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200905210010.54489.lindner_marek@yahoo.de>
	<4313f3060905201001u5658c660p5a9be3d63dbff150@mail.gmail.com>
In-Reply-To: <4313f3060905201001u5658c660p5a9be3d63dbff150@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200905210302.22639.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Kernel crashes with batgat installed
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Thursday 21 May 2009 01:01:43 Nathan Wharton wrote:
> In this case, it does the same thing whether or not batgat is installed.

Ok.

I miss a couple of things in your output - do you use the plain sources from 
open-mesh.net or do you apply custom patches ?


> Debug level 4 gives:
> ========================================
> WARNING: You are using the unstable batman branch. If you are
> interested in *using* batman get the lat
> est stable release !
> Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unknown)
> Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unknown)
> Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unknown)
> Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unknown)
> Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unknown)
> Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unknown)

Your log indicates that all routes are still present and batman tries to clean 
them up while starting. As you can see here table 68 is not mentioned. On my 
machine I get:

Deleting throw route to 105.0.0.0/8 via 0.0.0.0 (table 68 - unknown)


> [        30] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 65)
> [        30] Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 66)

Here we lack the message that says we found a new HNA:
Adding HNA to announce network list: 105.0.0.0/8


> It does this while not connected.

I could make a patch that produces more debug output to get to the root of it 
but first we have to make sure we run the same code ...


> If you consider 1 bug being the debug_malloc stuff not working, and
> the other being batgat possibly crashing the kernel, then yes.
> If I turn off debug malloc, then everything works fine, except using
> batgat and going from gateway to routing class.

Ok, lets do the malloc stuff first and then we move to the batgat issue.

Just to be clear here: DEBUG_MALLOC is not the problem - it just makes the 
problem visible. Everytime batman allocates memory the debugger will allocate 
more than needed to add its debugging information. Now the debugging 
information gets overwritten and the debugger tells you that (including a 
direction towards the source of the problem). If you deactivate the debugger 
the memory will still be overwritten but you don't notice it! 
It can destroy arbitrary structures in the memory that need hours to lead to a 
crash (if it all). May be it leads to broken routing entries ..

Regards,
Marek


