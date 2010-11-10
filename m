Return-Path: <greg@kroah.com>
Date: Tue, 9 Nov 2010 16:21:07 -0800
From: Greg KH <greg@kroah.com>
Message-ID: <20101110002107.GB4111@kroah.com>
References: <1288908150-19744-1-git-send-email-sven.eckelmann@gmx.de>
	<1288908150-19744-2-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288908150-19744-2-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] Staging: batman-adv: Remove useless
	braces
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thu, Nov 04, 2010 at 11:02:28PM +0100, Sven Eckelmann wrote:
> 77099f0afe94928b5b0066a7efa5fa9f81696b54 added changes to vis.c which
> trigger a checkpatch.pl warning about braces which are not necessary
> anymore.
> 
> WARNING: braces {} are not necessary for any arm of this statement
> +               if (entry->primary)
> [...]
> +               else {
> [...]
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>

This isn't needed for .37, sorry.  I'll use the other version of this
and queue it up for .38.

thanks,

greg k-h
