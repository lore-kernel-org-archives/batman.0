Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Nov 2010 13:00:59 +0100
References: <1288778342-10056-1-git-send-email-tklauser@distanz.ch>
	<201011031112.20044.sven.eckelmann@gmx.de>
	<20101103102512.GD10579@distanz.ch>
In-Reply-To: <20101103102512.GD10579@distanz.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201011031301.00736.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.]
 =?iso-8859-1?q?=5BPATCH=5D_staging=3A_batman-adv?=
 =?iso-8859-1?q?=3A_Use_linux/etherdevice=2Eh_address=09helper_functions?=
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: devel@driverdev.osuosl.org, Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@suse.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Wednesday 03 November 2010 11:25:12 Tobias Klauser wrote:
> I was refering to the following part of the patch:
> 
> -       if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
> +       if (is_multicast_ether_addr(ethhdr->h_dest)) {
> 
> I think this change should be legitimate as the same branch is done for
> multicast and broadcast addresses.

Soon we will have different code paths for broadcast and multicast right at 
this spot as multicast can be optimized further. But I think we can merge the 
change for the time being.

Regards,
Marek
