Return-Path: <viro@ftp.linux.org.uk>
Date: Sat, 24 Jul 2021 17:01:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
Message-ID: <YPxHYW/HPI/LLMXx@zeniv-ca.linux.org.uk>
References: <20210724162429.394792-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724162429.394792-1-sven@narfation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
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
Cc: Arnd Bergmann <arnd@arndb.de>, b.a.t.m.a.n@lists.open-mesh.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 06:24:29PM +0200, Sven Eckelmann wrote:

> The special attribute force must be used in such statements when the cast
> is known to be safe to avoid these warnings.

	How about container_of(ptr, typeof(*__pptr), x) instead of a cast?
Would be easier to follow...
