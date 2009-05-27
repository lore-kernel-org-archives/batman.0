From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 27 May 2009 17:28:12 +0800
References: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
	<200905270013.12447.sven.eckelmann@gmx.de>
	<4313f3060905261706o16a78bd3l102c9921e035ada@mail.gmail.com>
In-Reply-To: <4313f3060905261706o16a78bd3l102c9921e035ada@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905271728.57302.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Debug Malloc Problem
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

On Wednesday 27 May 2009 08:06:16 Nathan Wharton wrote:
> I haven't looked at any documentation for the xscale for this problem.
>  I can do a test program.  I have seen this type of problem before,
> but it would throw a bus error instead of going along with an
> incorrect result.

Yes, I'd expect some kind of interrupt error that the kernel handles. Please 
try to run the code that Sven sent and let us know about the results.

If this test is negative I would make a debug patch for you that calls 
checkIntegrity() during the different stages of the startup phase to narrow 
down the issue.

Regards,
Marek

