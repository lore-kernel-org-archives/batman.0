Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 29 Aug 2013 20:18:28 +0800
References: <y> <521C9BB4.2010306@gmail.com>
In-Reply-To: <521C9BB4.2010306@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308292018.28480.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: add sys framework for VLAN
	support
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, August 27, 2013 20:29:40 Marco Dalla Torre wrote:
> Version 2 - code style fixes
> 
> If no directory entry corresponding to the user-selected device is found 
> at the
> standard location for non VLAN interfaces (/sys/class/net/${base_device}),
> 'batctl' now looks into directory:
>       /sys/devices/virtual/net/${base_device}/mesh/vlan${vid}
> Where:
>      -${base_device}: the batman device on top of which the VLAN is sitting
>      -${device}: the device interface for the VLAN,
>      -${vid}: the identifier assigned to the VLAN.
> 
> Information on VLAN devices (base device, vid) necessary to construct the
> directory path is acquired by parsing /proc/net/vlan/${device}.
> 
> If the user-selected command is not supported by the VLAN, an appropriate
> error is shown.
> ---
>   functions.c |  3 +++
>   sys.c       | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)

Please don't forget the man page update.

Thanks,
Marek
