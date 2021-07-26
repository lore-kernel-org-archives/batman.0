Return-Path: <arnd@arndb.de>
MIME-Version: 1.0
References: <20210724162429.394792-1-sven@narfation.org> <YPxHYW/HPI/LLMXx@zeniv-ca.linux.org.uk>
 <CAK8P3a2MVQMFFBUzudy+yrcp4Md8mm=NcvX7YzGVz4C8W61sgQ@mail.gmail.com> <3234493.RMHOAZ7QyG@ripper>
In-Reply-To: <3234493.RMHOAZ7QyG@ripper>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Jul 2021 18:22:02 +0200
Message-ID: <CAK8P3a35PNhsMQNU11RCaKm-o3-oG8pOXG836aoubxQMpTyVNQ@mail.gmail.com>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, b.a.t.m.a.n@lists.open-mesh.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Jul 26, 2021 at 5:04 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Monday, 26 July 2021 14:57:31 CEST Arnd Bergmann wrote:
> > >
> > > > The special attribute force must be used in such statements when the cast
> > > > is known to be safe to avoid these warnings.
> >
> > I can see why this would warn, but I'm having trouble reproducing the
> > warning on linux-next.
>
> I have sparse 0.6.3 on an Debian bullseye amd64 system. Sources are from
> linux-next next-20210723
>
>     make allnoconfig
>     cat >> .config << "EOF"
>     CONFIG_NET=y
>     CONFIG_INET=y
>     CONFIG_BATMAN_ADV=y
>     CONFIG_BATMAN_ADV_DAT=y
>     EOF
>     make olddefconfig
>     make CHECK="sparse -Wbitwise-pointer" C=1
>
> I should maybe have made this clearer in the last sentence of the first
> paragraph: "This is also true for pointers to variables with this type when
> -Wbitwise-pointer is activated."

Ok, got it. I assumed this would be turned on by an 'allmodconfig' build.

> > If both work equally well, I'd prefer Sven's patch since that only
> > expands 'type' once, while container_of() expands it three more times

Not sure what I was thinking here, as it's not 'type' that gets expanded
here but 'ptr'. We could do Al's suggestion to avoid the __force without
multiple expansions, using

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 1c4242416c9f..d138dc5fd8e3 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -10,17 +10,25 @@
 #include <asm/byteorder.h>

 #define __get_unaligned_t(type, ptr) ({
                 \
-       const struct { type x; } __packed *__pptr =
(typeof(__pptr))(ptr);      \
+       const struct { type x; } __packed *__pptr =
         \
+                               container_of(ptr, typeof(*__pptr), x);
         \
        __pptr->x;
         \
 })

 #define __put_unaligned_t(type, val, ptr) do {
         \
-       struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);
         \
+       struct { type x; } __packed *__pptr =
         \
+                               container_of(ptr, typeof(*__pptr), x);
         \
        __pptr->x = (val);
         \
 } while (0)

-#define get_unaligned(ptr)     __get_unaligned_t(typeof(*(ptr)), (ptr))
-#define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
+#define get_unaligned(ptr)     ({
         \
+       __auto_type _ptr = (ptr);
         \
+       __get_unaligned_t(typeof(*(_ptr)), (_ptr));
         \
+})
+#define put_unaligned(val, ptr)        ({
                 \
+       __auto_type _ptr = (ptr);
         \
+       __put_unaligned_t(typeof(*(_ptr)), (val), (_ptr));
         \
+})

 static inline u16 get_unaligned_le16(const void *p)
 {

Not sure if this is any better.

        Arnd
