Return-Path: <greg@kroah.com>
Date: Fri, 18 Jun 2010 16:58:35 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100618235835.GB1128@kroah.com>
References: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
	<1275852501-28523-3-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275852501-28523-3-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/9] Staging: batman-adv: Move device for
 icmp injection to debugfs
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
Cc: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

On Sun, Jun 06, 2010 at 09:28:14PM +0200, Sven Eckelmann wrote:
> batctl uses /dev/batman-adv to send special batman-adv icmp packets to
> other nodes in the mesh. To get it working with multiple batX devices we
> must ensure that every mesh device can have their own socket which is
> used to inject those packets in exactly one mesh.
> 
> The current implementation still doesn't allow to use complete separated
> meshes as we rely on structures which are not part of the private data
> of a batman device.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>

This patch doesn't apply, I get the following error:
patching file drivers/staging/batman-adv/Makefile
patching file drivers/staging/batman-adv/bat_debugfs.c
patching file drivers/staging/batman-adv/bat_debugfs.h
patching file drivers/staging/batman-adv/device.c
Reversed (or previously applied) patch detected!  Assume -R? [n] ^C

Any ideas?

thanks,

greg k-h
