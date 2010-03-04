Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 4 Mar 2010 23:09:05 +0800
References: <4B8FBAAA.7060406@tiwoc.de>
In-Reply-To: <4B8FBAAA.7060406@tiwoc.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201003042309.05473.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batctl: avoid parsing bat-hosts
	multiple times
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

On Thursday 04 March 2010 21:50:34 Daniel Seither wrote:
> Currently, running batctl from the home directory leads to warnings
> ("Warning - mac already known") if ~/bat-hosts exists. This is caused by
> batctl parsing both "~/bat-hosts" and "bat-hosts" which happen to be the
> same file when the working directory is ~
> 
> This patch adds duplicate file name detection to bat_hosts_init() to
> avoid these warnings.

Applied in rev 1582.
I added a small check add the end of the patch to make sure that we don't 
attempt to free a NULL pointer.

Keep up the good work!  :-)

Cheers,
Marek
