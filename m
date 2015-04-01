Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 01 Apr 2015 19:36:10 +0200
Message-ID: <2646597.jD5Rzrq2qD@sven-desktop>
In-Reply-To: <20150401171821.GA21008@vostro>
References: <20150401171821.GA21008@vostro>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [B.A.T.M.A.N.] musl build fixes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Wednesday 01 April 2015 20:18:21 Alex Suykov wrote:
> batctl-2014.4.0 fails to build with musl, mostly because of somewhat
> weird netinet/*.h headers musl provides, but the problem turns out
> to be easy to fix.
> 
> musl does not allow including netinet/* and linux/* headers together.
> batctl includes netinet/if_ether.h indirectly via net/ethernet.h,
> so netinet/if_ether.h must be used instead of linux/if_ether.h.
> 
> __be16 and __be32 are linux-specific typedefs for uint16_t and
> uint32_t with __attribute__((bitwise)) that has no effect
> outside of the kernel. Replacing them with uint16_t and uint32_t
> removes dependency on linux/types.h.
> 
> Signed-off-by: Alex Suykov <alex.suykov@gmail.com>

Nacked-by: Sven Eckelmann <sven@narfation.org>

The __be32, __be16 are from the kernel and used there to check if data was 
correctly converted from host byte order to big endian (and the other way 
around). batctl just uses the packet.h from the kernel module. Removing them 
from the userspace would mean that it gets removed from the kernel module. 
This would mean that someone has send this "weird" commit to the next linux 
kernel maintainer. And I am quite happy that I will not be this person.

See https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-March/012926.html
for a proposal how to provide headers which are not yet part of linux-libc-dev 
(linux kernel uapi headers).

Kind regards,
	Sven
