Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 4 Mar 2010 20:49:25 +0800
References: <4B8FA639.5000502@tiwoc.de>
In-Reply-To: <4B8FA639.5000502@tiwoc.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201003042049.25362.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: avoid parsing bat-hosts multiple
	times
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

On Thursday 04 March 2010 20:23:21 Daniel Seither wrote:
> Currently, running batctl from the home directory leads to warnings
> ("Warning - mac already known") if ~/bat-hosts exists. This is caused by
> batctl parsing both "~/bat-hosts" and "bat-hosts" which happen to be the
> same file when the working directory is ~
> 
> This patch adds duplicate file name detection to bat_hosts_init() to
> avoid these warnings.

I tested your patch and it works very well. That is a nice catch! I did not 
stumble over this problem before.
However, I wonder whether it would be better to let realpath() allocate the 
normalized file path buffer instead of using the static normalized array, simply 
to save some disk space. What do you think ?

Cheers,
Marek
