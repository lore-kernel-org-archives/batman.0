Return-Path: <arnd@arndb.de>
MIME-Version: 1.0
References: <20210724162429.394792-1-sven@narfation.org> <YPxHYW/HPI/LLMXx@zeniv-ca.linux.org.uk>
In-Reply-To: <YPxHYW/HPI/LLMXx@zeniv-ca.linux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Jul 2021 14:57:31 +0200
Message-ID: <CAK8P3a2MVQMFFBUzudy+yrcp4Md8mm=NcvX7YzGVz4C8W61sgQ@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sven Eckelmann <sven@narfation.org>, Arnd Bergmann <arnd@arndb.de>, b.a.t.m.a.n@lists.open-mesh.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Jul 24, 2021 at 7:01 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Jul 24, 2021 at 06:24:29PM +0200, Sven Eckelmann wrote:
>
> > The special attribute force must be used in such statements when the cast
> > is known to be safe to avoid these warnings.

I can see why this would warn, but I'm having trouble reproducing the
warning on linux-next.

>         How about container_of(ptr, typeof(*__pptr), x) instead of a cast?
> Would be easier to follow...

If both work equally well, I'd prefer Sven's patch since that only
expands 'type'
once, while container_of() expands it three more times. This may not make
much of a difference, but I've seen a number of cases where nested macros
can explode the preprocessed code size enough to slow down kernel compilation
over all, and it's quite possible to have get_unaligned()/put_unaligned in
the middle of that, with a complex expression passed into that.

      Arnd
