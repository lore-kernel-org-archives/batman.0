Return-Path: <benh@kernel.crashing.org>
Message-ID: <1323038515.11728.26.camel@pasglop>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 05 Dec 2011 09:41:55 +1100
In-Reply-To: <20111204221850.GC14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
	<20111204213316.GB14542@n2100.arm.linux.org.uk>
	<1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
	<20111204221850.GC14542@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCHv5] atomic: add *_dec_not_zero
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergma nn <arnd@arndb.de>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-alpha@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, linux-m32r@ml.linux-m32r.org, linux-parisc@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Kyle McMartin <kyle@mcmartin.ca>, Richard Weinberger <richard@nod.at>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Hirokazu Takata <takata@linux-m32r.org>

On Sun, 2011-12-04 at 22:18 +0000, Russell King - ARM Linux wrote:

 .../...

> And really, I believe it would be a good cleanup if all the standard
> definitions for atomic64 ops (like atomic64_add_negative) were also
> defined in include/linux/atomic.h rather than individually in every
> atomic*.h header throughout the kernel source, except where an arch
> wants to explicitly override it.  Yet again, virtually all architectures
> define these in exactly the same way.
> 
> We have more than enough code in arch/ for any architecture to worry
> about, we don't need schemes to add more when there's simple and
> practical solutions to avoiding doing so if the right design were
> chosen (preferably from the outset.)
> 
> So, I'm not going to offer my ack for a change which I don't believe
> is the correct approach.

I agree with Russell, his approach is a lot easier to maintain long run,
we should even consider converting existing definitions.

Cheers,
Ben.


