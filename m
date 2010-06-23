Return-Path: <andrew@lunn.ch>
Date: Wed, 23 Jun 2010 17:09:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100623150913.GJ15420@lunn.ch>
References: <201006231620.11058.lindner_marek@yahoo.de>
	<1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add routing debug log
 accessible via debugfs
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

Hi Marek

> +int debug_log(struct bat_priv *bat_priv, char *fmt, ...)
> +{
> +	va_list args;
> +	char tmp_log_buf[256];
> +
> +	va_start(args, fmt);
> +	vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
> +	fdebug_log(bat_priv->debug_log, "[%10u] %s",
> +		   (jiffies / HZ), tmp_log_buf);
> +	va_end(args);

Thinking forward to when we try to get multiple meshes working, or are
trying to debug why they don't work together...

There will be a ring buffer per mesh. When debugging problems between
meshes it is likely both logs will be combined performing a merge
based on the timestamp. However at this point you have lost
information about which line belongs to which mesh. Could we maybe
include the soft interface name in the output?

Also, do you really want to do jiffies / HZ? You are throwing away
useful information. Either keep it as jiffies, or scale the remainder
to ms and print it as well?

   Andrew
