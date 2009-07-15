Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Jul 2009 02:00:30 +0800
References: <20090714163750.GR19071@ma.tech.ascom.ch>
In-Reply-To: <20090714163750.GR19071@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907160200.31170.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.]
 =?iso-8859-1?q?=5Bbatman-adv=5D_VIS_startup_race_c?=
 =?iso-8859-1?q?ondition_fix_plus_coding_style=09cleanup?=
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Wednesday 15 July 2009 00:37:50 Andrew Lunn wrote:
> There is a race condition between batman starting, adding the
> interfaces and creating the bat0 interface, and setting VIS into
> server mode, by echo'ing server into /proc/net/batman/vis. If you
> enable server mode before the bat0 interface is up and running, this
> gets forgotten when bat0 comes up. The vis_init() function has been
> split into two parts, vis_init() and vis_start(). vis_init() is called
> during the module init function and vis_start() is called when the
> bat0 interface is setup, thus closing the race.
>
> The files vis.[ch] have also been cleaned up with respect to the Linux
> kernel coding standard and 2.6.29 checkpatch script.

Sorry, the code review of this patch took a bit more time as it is a quite 
long one and mixes several topics:
* coding style cleaning
* race condition
* struct changes and their respective code modifications
* moving a variable to proc.c

It would be very helpful if you split the patch into smaller parts before I 
submit them. Is that feasible ?

Nevertheless, I dug through and noticed you modified the struct vis_info by 
adding "struct vis_info_entry entries[130];". This would lead to an allocation 
of nearly 1KB (130 * 7 Bytes) for every incoming vis packet. Is that 
intended ? 

I also applied your coding style patches for bitarray.[ch] and hash.[ch]. 
Thanks!

Regards,
Marek



