Return-Path: <greg@kroah.com>
Date: Sat, 12 Mar 2022 14:10:51 +0100
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4.9 0/2] batman-adv: Fixes for stable/linux-4.9.y
Message-ID: <Yiyb2yeRFTfFiEsc@kroah.com>
References: <20220309164542.408824-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309164542.408824-1-sven@narfation.org>
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
Cc: stable@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

On Wed, Mar 09, 2022 at 05:45:40PM +0100, Sven Eckelmann wrote:
> Hi,
> 
> following two patches were backported "automatically" applied in
> 4.14.y, 4.19.y, 5.4.y, 5.10.y, 5.5.y and 5.16.y. But they failed
> to apply cleanly in v4.9.y due to some changes in the patch context
> and one missing function in the older batman-adv version.
> 
> These problems were now fixed manually.
> 
> Kind regards,
> 	Sven
> 
> Sven Eckelmann (2):
>   batman-adv: Request iflink once in batadv-on-batadv check
>   batman-adv: Don't expect inter-netns unique iflink indices
> 
>  net/batman-adv/hard-interface.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> -- 
> 2.30.2
> 

Both now queued up, thanks.

greg k-h
