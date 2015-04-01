Return-Path: <alex.suykov@gmail.com>
Date: Thu, 2 Apr 2015 00:53:02 +0300
From: Alex Suykov <alex.suykov@gmail.com>
Message-ID: <20150401215302.GA25434@vostro>
References: <20150401171821.GA21008@vostro> <2646597.jD5Rzrq2qD@sven-desktop>
 <20150401193550.GA24391@vostro> <1834234.ImvpviMFU3@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1834234.ImvpviMFU3@sven-edge>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Wed, Apr 01, 2015 at 10:02:14PM +0200, Sven Eckelmann wrote:

> The linux/if_ether.h -> netinet/if_ether.h seems to be understandable (but 
> rather unfortunate). 
> 
> I am  not sure why why you include linux/types.h to the different source 
> files. Most likely because this include should actually be in packet.h as 
> mentioned in
>  https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-March/012930.html
>  https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-March/012942.html

I assume any changes in packet.h must be done in batman-adv first, then
ported to batctl, and preferably not the other way around.
And since I was only concerned with batctl, I saw packet.h as read-only.

Moving linux/types.h to packet.h does make sense I think.
However, it also brings linux/if_ether.h there, which immediately
makes musl support difficult. Maybe even impractical.


I'm not saying that's wrong, because I'm not trying to say batctl needs
musl support in the first place. Just another point to consider.
