Return-Path: <linux+b.a.t.m.a.n=lists.open-mesh.org@arm.linux.org.uk>
Date: Sun, 4 Dec 2011 21:33:16 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20111204213316.GB14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1323013369-29691-1-git-send-email-sven@narfation.org>
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
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>, linux-m32r@ml.linux-m32r.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Sun, Dec 04, 2011 at 04:42:49PM +0100, Sven Eckelmann wrote:
> diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/tile/include/asm/atomic_32.h b/arch/tile/include/asm/atomic_32.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> diff --git a/arch/tile/include/asm/atomic_64.h b/arch/tile/include/asm/atomic_64.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)

I think this is rather silly - all these definitions are very similar to
each other.  Is there really no way to put this into include/linux/atomic.h,
maybe as something like:

#ifndef atomic64_dec_not_zero
#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
#endif

and avoid having to add essentially the same definition to 12 individual
files?

Architectures which want to override it can do by the following:

#define atomic64_dec_not_zero		atomic64_dec_not_zero

which won't have any effect on C nor asm code.
