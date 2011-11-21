Return-Path: <greg@kroah.com>
Date: Mon, 21 Nov 2011 12:54:22 -0800
From: Greg KH <greg@kroah.com>
Message-ID: <20111121205422.GB11089@kroah.com>
References: <20111121192611.GA32510@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111121192611.GA32510@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] batman-adv stable patches: information request
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Nov 21, 2011 at 08:27:24PM +0100, Antonio Quartulli wrote:
> Hello Greg,
> 
> I'm Antonio Quartulli, a net/batman-adv kernel module contributor, and I'm
> contacting you as you are the stable tree maintainer.
> 
> On Oct 25, 2011 I sent the following two patches to stable@kernel.org:
> 
> - [PATCH 1/2] batman-adv: fix tt_local_reset_flags() function
>   which is 31901264511cf20c5ed33b8649a3ca9ce28df60b in David's net-next branch
> 
> 
> - [PATCH 2/2] batman-adv: correctly set the data field in the TT_REPONSE packet
>   which is 9d8523931f7f5eb8900077f0da0fbe6b8ad0010b in David's net-next branch
> 
> Up to now we didn't received any reply, either ACK or NACK, but I saw that
> linux-3.1.1 has been released in the meanwhile. As I guessed, this release
> doesn't contain our patches.
> 
> Did I miss something in the stable-submit procedure?
> I'm sorry for any inconvenient but this is the first time that I send patches to
> stable.

Ugh, no, you did everything right, it's just that at that point in time,
stable@kernel.org was down, as it still is, the new address is
stable@vger.kernel.org.

I'll queue these two patches up for the next release.  Just to verify,
these should only go to 3.1-stable, and not 3.0-stable as well?

Also, in the future, you can just add a simple:
	Cc: stable <stable@vger.kernel.org>
to the patch in the signed-off-by: area, and when it hits Linus's tree,
I'll automatically pick it up for the next stable release, you don't
have to do anything extra.

thanks,

greg k-h
