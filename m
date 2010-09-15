Return-Path: <andrew@lunn.ch>
Date: Thu, 16 Sep 2010 01:44:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100915234416.GB21479@lunn.ch>
References: <1284589835-26617-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1284589835-26617-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-ad: automatically add .llseek fop
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thu, Sep 16, 2010 at 12:30:35AM +0200, Sven Eckelmann wrote:

Hi Sven

...

> The generated code is often incorrectly
> indented and right now contains comments that
> clarify for each added line why a specific
> variant was chosen. In the version that gets
> submitted upstream, the comments will be gone
> and I will manually fix the indentation,
> because there does not seem to be a way to
> do that using coccinelle.

...

> diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
> index c73ce4a..0b35616 100644
> --- a/batman-adv/bat_debugfs.c
> +++ b/batman-adv/bat_debugfs.c
> @@ -177,6 +177,7 @@ static const struct file_operations log_fops = {
>  	.release        = log_release,
>  	.read           = log_read,
>  	.poll           = log_poll,
> +	.llseek = noop_llseek,/* read uses no f_pos */
>  };

Would it not be better to wait for the final version which has the
indentation fixed and probably no comment? If you commit this version
now, won't you get a conflict later?

     Andrew
