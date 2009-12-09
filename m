Return-Path: <gregkh@suse.de>
Date: Wed, 9 Dec 2009 12:23:49 -0800
From: Greg KH <gregkh@suse.de>
Message-ID: <20091209202348.GA16094@suse.de>
References: <1260389373-1071-1-git-send-email-andrew@lunn.ch>
	<1260389373-1071-2-git-send-email-andrew@lunn.ch>
	<1260389373-1071-3-git-send-email-andrew@lunn.ch>
	<1260389373-1071-4-git-send-email-andrew@lunn.ch>
	<1260389373-1071-5-git-send-email-andrew@lunn.ch>
	<1260389373-1071-6-git-send-email-andrew@lunn.ch>
	<1260389373-1071-7-git-send-email-andrew@lunn.ch>
	<1260389373-1071-8-git-send-email-andrew@lunn.ch>
	<1260389373-1071-9-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1260389373-1071-9-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 08/10] staging:batman-adv:Fix the naming
 of the debug option in Kconfig.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.net

On Wed, Dec 09, 2009 at 09:09:31PM +0100, Andrew Lunn wrote:
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

First off, much better on sending the patches, that worked fine.

> ---
>  drivers/staging/batman-adv/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/batman-adv/Kconfig b/drivers/staging/batman-adv/Kconfig
> index b9742e7..698eb31 100644
> --- a/drivers/staging/batman-adv/Kconfig
> +++ b/drivers/staging/batman-adv/Kconfig

But it seems that only this one, and one other (10/10) are able to be
applied to the kernel tree, as they properly have the files in the
correct location.

What were the other patches against?  A local repo somewhere that did
not have the batman-adv code in drivers/staging/batman-adv?

confused,

greg k-h
