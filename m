From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 20 May 2009 09:30:32 +0800
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200905192121.08028.sven.eckelmann@gmx.de>
	<4313f3060905191338n3ac9a795nd605da75ec1523aa@mail.gmail.com>
In-Reply-To: <4313f3060905191338n3ac9a795nd605da75ec1523aa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905200930.52901.lindner_marek@yahoo.de>
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

On Wednesday 20 May 2009 04:38:31 Nathan Wharton wrote:
> >> Everything works fine otherwise.  Except one thing that just came to
> >> mind, I had to remove -DDEBUG_MALLOC -DMEMORY_USAGE because batman
> >> wouldn't do anything without crashing because of magic number
> >> problems.  Could this be because I am on Big Endian hardware?
> >
> > I am running it also on big endian hardware and it seems to work. Does it
> > happen right after the start or were extra interaction needed? What was
> > the error output?
>
> It happens right after the start, and the error is debugRealloc -
> invalid magic number in trailer.

The DEBUG_MALLOC option enables additional functions within batman that allow 
it to easily trace back malloc bugs. A simple core dump might help but 
sometimes it is hard to say where it is coming from. Could you post the exact 
"invalid trailer number" line ?

I'm a bit confused here:
* Is batman crashing ?
* Is the kernel crashing ?
* Is batman crashing if you use the batgat module ?

Regards,
Marek

