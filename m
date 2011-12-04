Return-Path: <linux+b.a.t.m.a.n=lists.open-mesh.org@arm.linux.org.uk>
Date: Sun, 4 Dec 2011 22:18:50 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20111204221850.GC14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
	<20111204213316.GB14542@n2100.arm.linux.org.uk>
	<1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergma nn <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>, linux-m32r@ml.linux-m32r.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Sun, Dec 04, 2011 at 10:49:10PM +0100, Sven Eckelmann wrote:
> On Sunday 04 December 2011 21:33:16 Russell King - ARM Linux wrote:
> [...]
> > > +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> > 
> > I think this is rather silly - all these definitions are very similar to
> > each other.  Is there really no way to put this into include/linux/atomic.h,
> > maybe as something like:
> > 
> > #ifndef atomic64_dec_not_zero
> > #define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> > #endif
> > 
> > and avoid having to add essentially the same definition to 12 individual
> > files?
> > 
> > Architectures which want to override it can do by the following:
> > 
> > #define atomic64_dec_not_zero		atomic64_dec_not_zero
> > 
> > which won't have any effect on C nor asm code.
> 
>  * https://lkml.org/lkml/2011/5/8/15
>  * https://lkml.org/lkml/2011/5/8/16
>  * https://lkml.org/lkml/2011/5/8/321

I don't see any reason in that set of messages _not_ to do what I suggest.
Even on SMP architectures, your:

#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)

makes total sense - and with the adjustments I've suggested it means
that architectures (like x86) can still override it if have a more
optimal way to perform this operation.

Not only that, but we already do this kind of thing in
include/linux/atomic.h for the non-64 bit ops, for example:

#ifndef atomic_inc_unless_negative
static inline int atomic_inc_unless_negative(atomic_t *p)
{
        int v, v1;
        for (v = 0; v >= 0; v = v1) {
                v1 = atomic_cmpxchg(p, v, v + 1);
                if (likely(v1 == v))
                        return 1;
        }
        return 0;
}
#endif

And really, I believe it would be a good cleanup if all the standard
definitions for atomic64 ops (like atomic64_add_negative) were also
defined in include/linux/atomic.h rather than individually in every
atomic*.h header throughout the kernel source, except where an arch
wants to explicitly override it.  Yet again, virtually all architectures
define these in exactly the same way.

We have more than enough code in arch/ for any architecture to worry
about, we don't need schemes to add more when there's simple and
practical solutions to avoiding doing so if the right design were
chosen (preferably from the outset.)

So, I'm not going to offer my ack for a change which I don't believe
is the correct approach.
